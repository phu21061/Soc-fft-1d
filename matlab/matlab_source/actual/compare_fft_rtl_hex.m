function results = compare_fft_rtl_hex(vecDir, actualDir)
% Compare actual RTL HEX to Simulink expected and an independent double FFT.
% Example:
% results = compare_fft_rtl_hex('C:/FPGA/ts/matlab_source', ...
%     'C:/FPGA/ts/fft_1d_v1/fft_1d_v1.sim/sim_1/behav/xsim');
% Input/output HEX: Im in bits 31:16, Re in bits 15:0, signed Q1.15.
% MAE/MaxError below use complex error magnitude, not magnitude-spectrum error.
if nargin < 1 || isempty(vecDir), vecDir = 'C:/FPGA/ts/matlab_source'; end
if nargin < 2 || isempty(actualDir), actualDir = pwd; end
N = 512;
names = {'impulse_n0'; 'impulse_n1'; 'two_tone_k32_k80'; 'speech_6s'};
frames = [1; 1; 1; 94];
rows = cell(numel(names), 10);
frameRows = cell(sum(frames), 7);
frameRow = 0;
for g = 1:numel(names)
    name = names{g};
    count = N * frames(g);
    in = read_hex32(fullfile(vecDir, ['input_' name '.hex']), count);
    expected = read_hex32(fullfile(vecDir, ['expected_' name '.hex']), count);
    actual = read_hex32(fullfile(actualDir, ['actual_' name '.hex']), count);
    x = reshape(decode_q15(in), N, frames(g));
    ref = fft(x, N, 1) / N;
    y = reshape(decode_q15(actual), N, frames(g));
    err = y - ref;
    mismatch = reshape(actual ~= expected, N, frames(g));
    frameMax = max(abs(err), [], 1);
    [worstMax, worstFrame] = max(frameMax);
    mae = mean(abs(err(:)));
    maxError = max(abs(err(:)));
    sqnr = energy_sqnr(ref(:), err(:));
    mismatchCount = nnz(mismatch);
    result = 'PASS';
    if mismatchCount ~= 0, result = 'FAIL'; end
    rows(g,:) = {name, frames(g), count, mismatchCount, mae, maxError, sqnr, ...
                 worstFrame-1, worstMax, result};
    for f = 1:frames(g)
        frameRow = frameRow + 1;
        frameRows(frameRow,:) = {name, f-1, nnz(mismatch(:,f)), ...
            mean(abs(err(:,f))), max(abs(err(:,f))), ...
            energy_sqnr(ref(:,f), err(:,f)), 512};
    end
end
results = cell2table(rows, 'VariableNames', {'Group','Frames','Samples', ...
    'MismatchSamples','MAE','MaxError','SQNR_dB','WorstFrameZeroBased', ...
    'WorstFrameMaxError','ExactResult'});
perFrame = cell2table(frameRows, 'VariableNames', {'Group','FrameZeroBased', ...
    'MismatchSamples','MAE','MaxError','SQNR_dB','Samples'});
disp(results);
writetable(results, fullfile(actualDir, 'fft_accuracy_results.csv'));
writetable(perFrame, fullfile(actualDir, 'fft_accuracy_per_frame.csv'));
fprintf('ExactResult compares RTL with Simulink bit for bit.\n');
fprintf('MAE, MaxError and SQNR compare RTL Q1.15 values with MATLAB fft(x)/512.\n');
fprintf('No application accuracy threshold is assumed or silently applied.\n');
end

function words = read_hex32(path, count)
assert(isfile(path), 'Missing HEX file: %s', path);
tokens = split(strtrim(fileread(path)));
tokens = tokens(strlength(tokens) > 0);
assert(numel(tokens) == count, '%s: expected %d words, got %d', path, count, numel(tokens));
for k = 1:numel(tokens)
    assert(~isempty(regexp(char(tokens(k)), '^[0-9A-Fa-f]{8}$', 'once')), ...
        '%s: invalid word at zero-based index %d', path, k-1);
end
words = uint32(hex2dec(char(tokens)));
words = words(:);
end

function y = decode_q15(words)
re = double(bitand(words, uint32(65535)));
im = double(bitshift(words, -16));
re(re >= 32768) = re(re >= 32768) - 65536;
im(im >= 32768) = im(im >= 32768) - 65536;
y = complex(re, im) / 32768;
end

function q = energy_sqnr(ref, err)
signalEnergy = sum(abs(ref).^2);
errorEnergy = sum(abs(err).^2);
if signalEnergy == 0 && errorEnergy == 0
    q = NaN;
elseif errorEnergy == 0
    q = Inf;
elseif signalEnergy == 0
    q = -Inf;
else
    q = 10*log10(signalEnergy/errorEnergy);
end
end
