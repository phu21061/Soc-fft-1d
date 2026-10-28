% =========================================================================
% prepare_fft_vectors.m
% =========================================================================
% Tao bo du lieu kiem chung FFT 512 diem cho testbench RTL.
%
% Dau ra:
%   8 file HEX (4 input + 4 expected) — tu mo hinh Simulink fixed-point
%   fft_references.mat   — du lieu tham chieu day du
%   test_info.txt        — thong so cau hinh va dinh dang
%   prepare_summary.txt  — trang thai tao file va ket qua tu kiem tra
%
% Yeu cau: Simulink, DSP System Toolbox (hoac HDL Coder)
% Mo hinh: fft_512_steam.slx
% =========================================================================
clearvars; close all; clc;
fprintf('============================================================\n');
fprintf(' prepare_fft_vectors.m — FFT-512 Test Vector Generator\n');
fprintf('============================================================\n\n');

%% ==================== CAU HINH ====================
wavPath = fullfile('C:\FPGA\ts\matlab_source', 'OSR_us_000_0010_8k_6s.wav');
mdlName = 'fft_512_steam';
outDir  = 'C:\FPGA\ts\matlab_source';

N       = 512;          % FFT size
LATENCY = 1078;         % IP latency (clock cycles)
Fs      = 8000;         % Sample rate (Hz)
MARGIN  = 2*LATENCY;    % Extra cycles after data for pipeline flush

expectedSHA = '1bcb3085918eb4907f246ff8b71c35dc426c730fd1376922573c93e2348ebe16';

% Ket qua kiem tra tich luy
checkResults = {};

%% ==================== 1. DOC VA KIEM TRA WAV ====================
fprintf('[1] Doc va kiem tra WAV...\n');

% SHA-256
fid_w = fopen(wavPath, 'rb');
assert(fid_w > 0, 'Khong mo duoc file WAV: %s', wavPath);
wavBytes = fread(fid_w, inf, 'uint8');
fclose(fid_w);

md = java.security.MessageDigest.getInstance('SHA-256');
md.update(uint8(wavBytes));
hashBytes = typecast(md.digest(), 'uint8');
wavSHA256 = lower(sprintf('%02x', hashBytes));

if strcmp(wavSHA256, expectedSHA)
    fprintf('  SHA-256 KHOP: %s\n', wavSHA256);
    checkResults{end+1} = '[OK] WAV SHA-256 verified';
else
    error('SHA-256 KHONG KHOP!\n  Thuc te:  %s\n  Ky vong: %s', wavSHA256, expectedSHA);
end

% Doc PCM
[pcm, fsWav] = audioread(wavPath, 'native');
assert(isa(pcm, 'int16'),       'WAV phai la int16 PCM');
assert(fsWav == Fs,             'WAV sample rate phai la %d Hz', Fs);
assert(length(pcm) == 48000,    'WAV phai co 48000 mau');
fprintf('  WAV: mono, int16, Fs=%d Hz, %d mau, %.3f s\n', fsWav, length(pcm), length(pcm)/fsWav);

%% ==================== 2. SINH TIN HIEU DAU VAO ====================
fprintf('\n[2] Sinh 4 nhom tin hieu dau vao...\n');

% --- impulse_n0: Re[0] = 8192, cac mau khac = 0, Im = 0 ---
re_impulse_n0 = int16(zeros(N, 1));
re_impulse_n0(1) = int16(8192);   % n=0 -> chi so MATLAB 1
fprintf('  impulse_n0:       Re[0]=8192, %d mau\n', N);

% --- impulse_n1: Re[1] = 8192, cac mau khac = 0, Im = 0 ---
re_impulse_n1 = int16(zeros(N, 1));
re_impulse_n1(2) = int16(8192);   % n=1 -> chi so MATLAB 2
fprintf('  impulse_n1:       Re[1]=8192, %d mau\n', N);

% --- two_tone_k32_k80: Re[n] = round(3072*sin(2*pi*32*n/512) + 2048*sin(2*pi*80*n/512)) ---
nn = (0:N-1)';
re_two_tone_dbl = 3072*sin(2*pi*32*nn/N) + 2048*sin(2*pi*80*nn/N);
re_two_tone = int16(round(re_two_tone_dbl));
fprintf('  two_tone_k32_k80: 500Hz + 1250Hz, max=%d, min=%d, %d mau\n', ...
    max(re_two_tone), min(re_two_tone), N);

% --- speech_6s: PCM nguyen tu WAV + 128 zero padding ---
re_speech = int16([pcm(:); zeros(128, 1, 'int16')]);
nFramesSpeech = length(re_speech) / N;
assert(nFramesSpeech == 94, 'Speech phai co 94 frame (co %d)', nFramesSpeech);
fprintf('  speech_6s:        %d mau PCM + 128 zero = %d mau, %d frame\n', ...
    length(pcm), length(re_speech), nFramesSpeech);

%% ==================== 3. DINH NGHIA CAC NHOM TEST ====================
groups = struct( ...
    'name',     {'impulse_n0',   'impulse_n1',   'two_tone_k32_k80', 'speech_6s'}, ...
    'nSamples', {N,              N,              N,                   length(re_speech)}, ...
    'nFrames',  {1,              1,              1,                   94} ...
);
inputRe = {re_impulse_n0, re_impulse_n1, re_two_tone, re_speech};

%% ==================== 4. NAP MO HINH SIMULINK ====================
fprintf('\n[3] Nap mo hinh Simulink: %s...\n', mdlName);
load_system(mdlName);
fprintf('  Mo hinh da nap.\n');

% Luu cau hinh goc de khoi phuc sau
origSolver   = get_param(mdlName, 'SolverName');
origStep     = get_param(mdlName, 'FixedStep');
origStopTime = get_param(mdlName, 'StopTime');

%% ==================== 5. XU LY TUNG NHOM ====================
refs = struct();

for g = 1:length(groups)
    grpName   = groups(g).name;
    nSamples  = groups(g).nSamples;
    nFrames   = groups(g).nFrames;
    re_data   = inputRe{g};
    im_data   = int16(zeros(nSamples, 1));

    fprintf('\n============================================================\n');
    fprintf(' Nhom %d/%d: %s (%d mau, %d frame)\n', g, length(groups), grpName, nSamples, nFrames);
    fprintf('============================================================\n');

    % ----- 5a. Dong goi uint32: [31:16]=Im, [15:0]=Re -----
    re_u16 = typecast(re_data, 'uint16');
    im_u16 = typecast(im_data, 'uint16');
    inputPacked = bitor(bitshift(uint32(im_u16), 16), uint32(re_u16));

    % ----- 5b. Ghi input HEX -----
    inputHexFile = fullfile(outDir, ['input_' grpName '.hex']);
    write_hex_file(inputHexFile, inputPacked);
    fprintf('  [OK] Ghi: %s (%d dong)\n', inputHexFile, length(inputPacked));

    % ----- 5c. Doc lai HEX de kiem tra round-trip -----
    readBack = read_hex_file(inputHexFile);
    rb_re_u16 = uint16(bitand(readBack, uint32(65535)));
    rb_im_u16 = uint16(bitshift(readBack, -16));
    rb_re = typecast(rb_re_u16, 'int16');
    rb_im = typecast(rb_im_u16, 'int16');
    assert(isequal(rb_re, re_data), 'Round-trip THAT BAI cho Re, nhom %s', grpName);
    assert(isequal(rb_im, im_data), 'Round-trip THAT BAI cho Im, nhom %s', grpName);
    fprintf('  [OK] Round-trip HEX input: KHOP tung bit\n');

    % ----- 5d. Tao timeseries cho From Workspace -----
    nTotal = nSamples + MARGIN;
    timeVec = double((0:nTotal-1)');

    dataExt  = [inputPacked; zeros(MARGIN, 1, 'uint32')];
    validExt = [true(nSamples, 1); false(MARGIN, 1)];

    s_axis_tdata  = timeseries(dataExt,  timeVec);
    s_axis_tvalid = timeseries(validExt, timeVec);

    % Gan vao base workspace cho From Workspace block doc
    assignin('base', 's_axis_tdata',  s_axis_tdata);
    assignin('base', 's_axis_tvalid', s_axis_tvalid);

    % ----- 5e. Chay Simulink -----
    stopTime = nTotal - 1;
    fprintf('  Chay Simulink (StopTime=%d, FixedStep=1)...\n', stopTime);

    set_param(mdlName, 'Solver',    'FixedStepDiscrete');
    set_param(mdlName, 'FixedStep', '1');
    set_param(mdlName, 'StopTime',  num2str(stopTime));

    simOut = sim(mdlName);

    % ----- 5f. Lay du lieu dau ra -----
    outTdata  = simOut.get('tdata');
    outTvalid = simOut.get('tvalid');

    % Xu ly kieu du lieu: dam bao la mang cot
    if isa(outTdata, 'timeseries')
        outTdata  = outTdata.Data;
        outTvalid = outTvalid.Data;
    end
    outTdata  = uint32(outTdata(:));
    outTvalid = logical(outTvalid(:));

    fprintf('  Ket qua: %d buoc, %d mau valid\n', length(outTdata), sum(outTvalid));

    % ----- 5g. Trich xuat mau valid -----
    expectedPacked = outTdata(outTvalid);
    nExpected = nFrames * N;

    if length(expectedPacked) > nExpected
        fprintf('  CANH BAO: %d mau valid > %d ky vong, cat con %d\n', ...
            length(expectedPacked), nExpected, nExpected);
        expectedPacked = expectedPacked(1:nExpected);
    elseif length(expectedPacked) < nExpected
        error('Chi co %d mau valid, ky vong %d (nhom %s). Tang MARGIN?', ...
            length(expectedPacked), nExpected, grpName);
    else
        fprintf('  [OK] So mau valid = %d (dung)\n', nExpected);
    end

    % ----- 5h. Ghi expected HEX -----
    expectedHexFile = fullfile(outDir, ['expected_' grpName '.hex']);
    write_hex_file(expectedHexFile, expectedPacked);
    fprintf('  [OK] Ghi: %s (%d dong)\n', expectedHexFile, length(expectedPacked));

    % ----- 5i. Giai ma expected -----
    exp_re_u16 = uint16(bitand(expectedPacked, uint32(65535)));
    exp_im_u16 = uint16(bitshift(expectedPacked, -16));
    exp_re = typecast(exp_re_u16, 'int16');
    exp_im = typecast(exp_im_u16, 'int16');

    % ----- 5j. Tham chieu MATLAB double: fft(x_quantized, N)/N -----
    re_q = double(re_data) / 32768;
    im_q = double(im_data) / 32768;

    refFrames = struct();
    for f = 1:nFrames
        iS = (f-1)*N + 1;
        iE = f*N;

        xFrame  = complex(re_q(iS:iE), im_q(iS:iE));
        refDbl  = fft(xFrame, N) / N;   % scaling 1/N, da xac nhan Normalize=on

        refFrames(f).input_int16_re     = re_data(iS:iE);
        refFrames(f).input_int16_im     = im_data(iS:iE);
        refFrames(f).input_q15_re       = re_q(iS:iE);
        refFrames(f).input_q15_im       = im_q(iS:iE);
        refFrames(f).expected_int16_re  = exp_re(iS:iE);
        refFrames(f).expected_int16_im  = exp_im(iS:iE);
        refFrames(f).reference_double   = refDbl;
    end
    refs.(grpName) = refFrames;

    % ----- 5k. Kiem tra co ban -----
    if strcmp(grpName, 'impulse_n0')
        % Voi scaling 1/512: Re[0]=8192 -> Q1.15 = 0.25
        % X[k] = 0.25 / 512 = 16/32768 -> Re = 16 (int16), Im = 0
        allRe16 = all(double(exp_re) == 16);
        allIm0  = all(double(exp_im) == 0);
        if allRe16 && allIm0
            fprintf('  [PASS] impulse_n0: Re=16, Im=0 tai moi 512 bin\n');
            checkResults{end+1} = '[PASS] impulse_n0: Re=16, Im=0 at all bins';
        else
            fprintf('  [FAIL] impulse_n0: Re unique=%s, Im unique=%s\n', ...
                mat2str(unique(double(exp_re))'), mat2str(unique(double(exp_im))'));
            checkResults{end+1} = '[FAIL] impulse_n0: unexpected values';
        end
    end

    if strcmp(grpName, 'impulse_n1')
        % X[k] = (8192/32768)/512 * exp(-j*2*pi*k/512)
        % Magnitude = 16/32768 cho moi bin
        expMag = sqrt(double(exp_re).^2 + double(exp_im).^2);
        % Floor rounding co the lam sai lech 1 LSB
        if all(abs(expMag - 16) <= 1.5)
            fprintf('  [PASS] impulse_n1: magnitude ~16 tai moi bin\n');
            checkResults{end+1} = '[PASS] impulse_n1: magnitude ~16 at all bins';
        else
            fprintf('  [INFO] impulse_n1: magnitude range [%.1f, %.1f]\n', ...
                min(expMag), max(expMag));
            checkResults{end+1} = sprintf('[INFO] impulse_n1: mag range [%.1f, %.1f]', ...
                min(expMag), max(expMag));
        end
    end

    if strcmp(grpName, 'two_tone_k32_k80')
        % Dinh tai bin 32, 80, 432 (=512-80), 480 (=512-32)
        magTT = sqrt(double(exp_re).^2 + double(exp_im).^2);
        [~, pkIdx] = sort(magTT, 'descend');
        top4 = sort(pkIdx(1:4)) - 1;   % chuyen sang 0-based
        fprintf('  Top-4 bin (0-based): %s\n', mat2str(top4(:)'));
        if isequal(top4(:)', [32 80 432 480])
            fprintf('  [PASS] two_tone: dinh tai bin 32, 80, 432, 480\n');
            checkResults{end+1} = '[PASS] two_tone: peaks at bins 32, 80, 432, 480';
        else
            fprintf('  [FAIL] two_tone: dinh tai %s (ky vong [32 80 432 480])\n', mat2str(top4(:)'));
            checkResults{end+1} = sprintf('[FAIL] two_tone: peaks at %s', mat2str(top4(:)'));
        end
    end

    if strcmp(grpName, 'speech_6s')
        fprintf('  [OK] speech_6s: %d frame x %d = %d mau\n', nFrames, N, nFrames*N);
        checkResults{end+1} = sprintf('[OK] speech_6s: %d frames, %d samples', nFrames, nFrames*N);

        % Kiem tra 48000 mau dau giu nguyen PCM
        reInput48k = re_data(1:48000);
        if isequal(reInput48k, pcm)
            fprintf('  [OK] 48000 mau dau khop voi PCM goc\n');
            checkResults{end+1} = '[OK] speech_6s: first 48000 samples match original PCM';
        else
            fprintf('  [FAIL] 48000 mau dau KHONG khop voi PCM goc!\n');
            checkResults{end+1} = '[FAIL] speech_6s: first 48000 samples mismatch';
        end

        % Kiem tra 128 mau cuoi = 0
        rePad = re_data(48001:end);
        if all(rePad == 0)
            fprintf('  [OK] 128 mau padding = 0\n');
            checkResults{end+1} = '[OK] speech_6s: 128 padding samples are zero';
        else
            fprintf('  [FAIL] Padding KHONG bang 0!\n');
            checkResults{end+1} = '[FAIL] speech_6s: padding non-zero';
        end
    end
end

%% ==================== 6. LUU fft_references.mat ====================
fprintf('\n[4] Luu tham chieu...\n');
matFile = fullfile(outDir, 'fft_references.mat');
save(matFile, 'refs', '-v7.3');
fprintf('  [OK] %s\n', matFile);
checkResults{end+1} = '[OK] fft_references.mat saved';

%% ==================== 7. GHI test_info.txt ====================
fprintf('\n[5] Ghi test_info.txt...\n');
infoFile = fullfile(outDir, 'test_info.txt');
fid = fopen(infoFile, 'w', 'n', 'UTF-8');

fprintf(fid, 'FFT Test Vector Information\r\n');
fprintf(fid, '===========================\r\n\r\n');
fprintf(fid, 'Generated : %s\r\n\r\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));

fprintf(fid, 'FFT Configuration\r\n');
fprintf(fid, '-----------------\r\n');
fprintf(fid, '  N (FFT size)      : %d\r\n', N);
fprintf(fid, '  Architecture      : Streaming Radix 2^2\r\n');
fprintf(fid, '  Fs                : %d Hz\r\n', Fs);
fprintf(fid, '  Data format       : signed 16-bit, 15 frac bits (Q1.15 / sfix16_En15)\r\n');
fprintf(fid, '  Packing           : [31:16] = Im, [15:0] = Re, two''s complement\r\n');
fprintf(fid, '  HEX format        : 8 hex digits/line, uppercase, no prefix/header\r\n');
fprintf(fid, '  Scaling           : 1/N = 1/512 (Normalize = on)\r\n');
fprintf(fid, '  Rounding          : Floor\r\n');
fprintf(fid, '  Output order      : Natural (BitReversedOutput = off)\r\n');
fprintf(fid, '  Latency           : %d cycles\r\n', LATENCY);
fprintf(fid, '  Window            : None (rectangular)\r\n\r\n');

fprintf(fid, 'Files\r\n');
fprintf(fid, '-----\r\n');
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'input_impulse_n0.hex',         N,     1);
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'expected_impulse_n0.hex',       N,     1);
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'input_impulse_n1.hex',          N,     1);
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'expected_impulse_n1.hex',       N,     1);
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'input_two_tone_k32_k80.hex',   N,     1);
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'expected_two_tone_k32_k80.hex', N,     1);
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'input_speech_6s.hex',          48128, 94);
fprintf(fid, '  %-40s  %6d lines  %3d frames\r\n', 'expected_speech_6s.hex',        48128, 94);
fprintf(fid, '\r\n');

fprintf(fid, 'WAV Source\r\n');
fprintf(fid, '----------\r\n');
fprintf(fid, '  File    : %s\r\n', wavPath);
fprintf(fid, '  Format  : mono PCM 16-bit signed\r\n');
fprintf(fid, '  Fs      : %d Hz\r\n', Fs);
fprintf(fid, '  Samples : 48000 (6.000 s)\r\n');
fprintf(fid, '  Padding : 128 zeros appended in memory (WAV file unchanged)\r\n');
fprintf(fid, '  Total   : 48128 samples = 94 frames x 512\r\n');
fprintf(fid, '  SHA-256 : %s\r\n\r\n', wavSHA256);

fprintf(fid, 'Reference Values (fft_references.mat)\r\n');
fprintf(fid, '--------------------------------------\r\n');
fprintf(fid, '  Per group, per frame:\r\n');
fprintf(fid, '    input_int16_re/im     signed 16-bit integer (raw PCM or generated)\r\n');
fprintf(fid, '    input_q15_re/im       Q1.15 as double = int16 / 32768\r\n');
fprintf(fid, '    expected_int16_re/im  Simulink fixed-point output (int16)\r\n');
fprintf(fid, '    reference_double      MATLAB fft(x_quantized, 512) / 512\r\n');
fprintf(fid, '\r\n');
fprintf(fid, '  NOTE: reference_double uses the same quantized input as the model.\r\n');
fprintf(fid, '  To compare expected vs reference:\r\n');
fprintf(fid, '    expected_double = double(expected_int16) / 32768\r\n');
fprintf(fid, '    error = expected_double - reference_double\r\n');
fprintf(fid, '  Do NOT multiply or divide by 32768 twice.\r\n');

fclose(fid);
fprintf('  [OK] %s\n', infoFile);
checkResults{end+1} = '[OK] test_info.txt written';

%% ==================== 8. GHI prepare_summary.txt ====================
fprintf('\n[6] Ghi prepare_summary.txt...\n');
summaryFile = fullfile(outDir, 'prepare_summary.txt');
fid = fopen(summaryFile, 'w', 'n', 'UTF-8');

fprintf(fid, 'Preparation Summary\r\n');
fprintf(fid, '===================\r\n\r\n');
fprintf(fid, 'Date   : %s\r\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));
fprintf(fid, 'Model  : %s\r\n', mdlName);
fprintf(fid, 'Script : prepare_fft_vectors.m\r\n\r\n');

fprintf(fid, 'File Status\r\n');
fprintf(fid, '-----------\r\n');

hexFiles = { ...
    'input_impulse_n0.hex',         512;
    'expected_impulse_n0.hex',      512;
    'input_impulse_n1.hex',         512;
    'expected_impulse_n1.hex',      512;
    'input_two_tone_k32_k80.hex',   512;
    'expected_two_tone_k32_k80.hex',512;
    'input_speech_6s.hex',          48128;
    'expected_speech_6s.hex',       48128;
};

allFilesOK = true;
for i = 1:size(hexFiles, 1)
    fname = hexFiles{i, 1};
    expectedLines = hexFiles{i, 2};
    fpath = fullfile(outDir, fname);
    if exist(fpath, 'file')
        % Dem so dong
        fidCheck = fopen(fpath, 'r');
        nLines = 0;
        while ~feof(fidCheck)
            fgetl(fidCheck);
            nLines = nLines + 1;
        end
        fclose(fidCheck);
        if nLines == expectedLines
            fprintf(fid, '  [OK]   %-40s %6d lines\r\n', fname, nLines);
        else
            fprintf(fid, '  [FAIL] %-40s %6d lines (expected %d)\r\n', fname, nLines, expectedLines);
            allFilesOK = false;
        end
    else
        fprintf(fid, '  [MISS] %-40s NOT FOUND\r\n', fname);
        allFilesOK = false;
    end
end

fprintf(fid, '\r\nSelf-Check Results\r\n');
fprintf(fid, '------------------\r\n');
for i = 1:length(checkResults)
    fprintf(fid, '  %s\r\n', checkResults{i});
end

fprintf(fid, '\r\nTotal: %d input HEX + %d expected HEX = %d frames\r\n', 4, 4, 1+1+1+94);

fprintf(fid, '\r\nNote:\r\n');
fprintf(fid, '  RTL verification status is NOT included here.\r\n');
fprintf(fid, '  RTL PASS/FAIL requires Vivado simulation (actual HEX comparison).\r\n');

fclose(fid);
fprintf('  [OK] %s\n', summaryFile);

%% ==================== 9. KHOI PHUC MO HINH ====================
set_param(mdlName, 'SolverName', origSolver);
set_param(mdlName, 'FixedStep',  origStep);
set_param(mdlName, 'StopTime',   origStopTime);
close_system(mdlName, 0);   % Dong khong luu

%% ==================== 10. TOM TAT ====================
fprintf('\n============================================================\n');
fprintf(' HOAN THANH\n');
fprintf('============================================================\n');
fprintf(' Output directory: %s\n', outDir);
fprintf(' Files created:\n');
for i = 1:size(hexFiles, 1)
    fprintf('   %s\n', hexFiles{i, 1});
end
fprintf('   fft_references.mat\n');
fprintf('   test_info.txt\n');
fprintf('   prepare_summary.txt\n');
fprintf('\n Self-check summary:\n');
for i = 1:length(checkResults)
    fprintf('   %s\n', checkResults{i});
end
fprintf('============================================================\n');

%% ==================== LOCAL FUNCTIONS ====================

function write_hex_file(filename, dataU32)
%WRITE_HEX_FILE  Ghi mang uint32 ra file HEX (8 ky tu/dong, khong prefix)
    fid = fopen(filename, 'w');
    assert(fid > 0, 'Khong tao duoc file: %s', filename);
    for i = 1:length(dataU32)
        fprintf(fid, '%08X\n', dataU32(i));
    end
    fclose(fid);
end

function dataU32 = read_hex_file(filename)
%READ_HEX_FILE  Doc file HEX ve mang uint32
    fid = fopen(filename, 'r');
    assert(fid > 0, 'Khong doc duoc file: %s', filename);
    lines = textscan(fid, '%s');
    fclose(fid);
    lines = lines{1};
    nLines = length(lines);
    dataU32 = zeros(nLines, 1, 'uint32');
    for i = 1:nLines
        dataU32(i) = uint32(hex2dec(lines{i}));
    end
end
