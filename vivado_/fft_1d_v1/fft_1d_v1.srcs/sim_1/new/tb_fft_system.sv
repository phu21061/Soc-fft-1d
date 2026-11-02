`timescale 1ns / 1ps

// FFT 512 verification using the existing DMA / AXI VIP block design.
// Replace the OLD simulation testbench with this file: both use tb_fft_system.
// Data files: one packed complex Q1.15 sample per line, Im[31:16], Re[15:0].
// Defaults can be overridden with +VEC_DIR=... and +OUT_DIR=... (use / in paths).
module tb_fft_system;
    import axi_vip_pkg::*;
    import design_1_axi_vip_0_0_pkg::*;
    import design_1_axi_vip_0_1_pkg::*;

    localparam real CLK_PERIOD_NS = 10.0;
    localparam int N = 512;
    localparam int WORD_BYTES = 4;
    localparam int FRAME_BYTES = N * WORD_BYTES;
    localparam int SPEECH_FRAMES = 94;
    localparam int MAX_SAMPLES = SPEECH_FRAMES * N;
    localparam int MAX_POLLS = 2000;
    localparam int MAX_MISMATCH_PRINTS = 12;

    localparam xil_axi_ulong FFT_BASE = 32'h43C0_0000;
    localparam xil_axi_ulong FFT_ENABLE = FFT_BASE + 32'h04;
    localparam xil_axi_ulong DMA_BASE = 32'h4040_0000;
    localparam xil_axi_ulong MM2S_DMACR = DMA_BASE + 32'h00;
    localparam xil_axi_ulong MM2S_DMASR = DMA_BASE + 32'h04;
    localparam xil_axi_ulong MM2S_SA = DMA_BASE + 32'h18;
    localparam xil_axi_ulong MM2S_LENGTH = DMA_BASE + 32'h28;
    localparam xil_axi_ulong S2MM_DMACR = DMA_BASE + 32'h30;
    localparam xil_axi_ulong S2MM_DMASR = DMA_BASE + 32'h34;
    localparam xil_axi_ulong S2MM_DA = DMA_BASE + 32'h48;
    localparam xil_axi_ulong S2MM_LENGTH = DMA_BASE + 32'h58;
    localparam xil_axi_ulong INPUT_ADDR = 32'h1000_0000;
    localparam xil_axi_ulong OUTPUT_ADDR = 32'h1000_1000;
    localparam bit [31:0] GUARD_WORD = 32'hA5C3_7E19;

    bit aclk = 0;
    bit aresetn = 0;
    always #(CLK_PERIOD_NS/2.0) aclk = ~aclk; // 100 MHz. Fs=8 kHz labels the audio, not this clock.

    design_1_wrapper dut (.aclk(aclk), .aresetn(aresetn));
    design_1_axi_vip_0_0_mst_t master_agent;
    design_1_axi_vip_0_1_slv_mem_t memory_agent;

    // Keep the instance paths from the original working testbench.
    wire in_valid = dut.design_1_i.FFT_512_I_ip_stream_0.AXI4_Stream_Slave_TVALID;
    wire in_ready = dut.design_1_i.FFT_512_I_ip_stream_0.AXI4_Stream_Slave_TREADY;
    wire [31:0] in_data = dut.design_1_i.FFT_512_I_ip_stream_0.AXI4_Stream_Slave_TDATA;
    wire out_valid = dut.design_1_i.FFT_512_I_ip_stream_0.AXI4_Stream_Master_TVALID;
    wire out_ready = dut.design_1_i.FFT_512_I_ip_stream_0.AXI4_Stream_Master_TREADY;
    wire [31:0] out_data = dut.design_1_i.FFT_512_I_ip_stream_0.AXI4_Stream_Master_TDATA;
    wire out_last = dut.design_1_i.FFT_512_I_ip_stream_0.AXI4_Stream_Master_TLAST;

    logic [31:0] input_vec [0:MAX_SAMPLES-1];
    logic [31:0] expected_vec [0:MAX_SAMPLES-1];
    logic [31:0] stream_capture [0:N-1];
    string vec_dir;
    string out_dir;
    string active_group = "initialization";
    int active_frame = -1;
    int frame_base = 0;
    bit frame_active = 0;
    bit monitor_clear = 0;
    int input_count = 0;
    int output_count = 0;
    int tlast_count = 0;
    int output_stall_cycles = 0;
    bit stalled_previous = 0;
    logic [31:0] stalled_data;
    logic stalled_last;
    longint cycle_count = 0;
    longint first_input_cycle = -1;
    longint first_output_cycle = -1;
    longint last_output_cycle = -1;
    // Timestamps at the IP AXI-Stream boundary (not inside the FFT core).
    longint last_input_cycle = -1;
    longint first_output_valid_cycle = -1;
    int input_stall_cycles = 0;
    int first_output_wait_cycles = 0;
    int latency_csv;
    bit latency_trace = 0;
    longint valid_latency_min = 64'h7fff_ffff_ffff_ffff;
    longint valid_latency_max = 0;
    longint valid_latency_sum = 0;
    longint handshake_latency_min = 64'h7fff_ffff_ffff_ffff;
    longint handshake_latency_max = 0;
    longint handshake_latency_sum = 0;
    int latency_frames = 0;
    // Add these signals to the waveform to follow latency live.
    wire latency_tracking = frame_active && first_input_cycle >= 0 && output_count < N;
    wire signed [63:0] live_elapsed_cycles = (first_input_cycle < 0) ? 64'sd0 :
        ((output_count == N ? last_output_cycle : cycle_count) - first_input_cycle);
    wire signed [63:0] first_valid_latency_cycles = (first_output_valid_cycle < 0) ?
        -64'sd1 : first_output_valid_cycle - first_input_cycle;
    wire signed [63:0] first_handshake_latency_cycles = (first_output_cycle < 0) ?
        -64'sd1 : first_output_cycle - first_input_cycle;
    int frame_csv;
    int group_csv;
    int total_frames = 0;
    int total_samples = 0;
    int total_mismatches = 0;
    int failed_frames = 0;
    int group_mismatch_prints = 0;

    initial begin
        #100_000_000; // 100 ms simulation time; old 2 ms limit is too restrictive.
        $fatal(1, "[FAIL] Global timeout at group=%s frame=%0d", active_group, active_frame);
    end

    always @(posedge aclk) begin
        if (!aresetn) cycle_count <= 0;
        else cycle_count <= cycle_count + 1;

        if (!aresetn || monitor_clear) begin
            input_count <= 0;
            output_count <= 0;
            tlast_count <= 0;
            output_stall_cycles <= 0;
            stalled_previous <= 0;
            first_input_cycle <= -1;
            first_output_cycle <= -1;
            last_output_cycle <= -1;
            last_input_cycle <= -1;
            first_output_valid_cycle <= -1;
            input_stall_cycles <= 0;
            first_output_wait_cycles <= 0;
        end else if (frame_active) begin
            if (in_valid && !in_ready)
                input_stall_cycles <= input_stall_cycles + 1;
            // Observe presentation independently from acceptance by the DMA.
            if (out_valid && first_output_valid_cycle < 0) begin
                first_output_valid_cycle <= cycle_count;
                if (latency_trace)
                    $display("[LATENCY EVENT] %s frame=%0d first_output_valid cycle=%0d",
                             active_group, active_frame, cycle_count);
            end
            if (out_valid && !out_ready && first_output_cycle < 0)
                first_output_wait_cycles <= first_output_wait_cycles + 1;
            // A stalled beat must remain valid and unchanged until accepted.
            if (stalled_previous &&
                (out_valid !== 1'b1 || out_data !== stalled_data || out_last !== stalled_last))
                $fatal(1, "[FAIL] Stream changed while stalled: %s frame=%0d", active_group, active_frame);
            stalled_previous <= out_valid && !out_ready;
            if (out_valid && !out_ready) begin
                stalled_data <= out_data;
                stalled_last <= out_last;
                output_stall_cycles <= output_stall_cycles + 1;
            end

            if (in_valid && in_ready) begin
                if (input_count >= N)
                    $fatal(1, "[FAIL] More than 512 input beats: %s frame=%0d", active_group, active_frame);
                else if (in_data !== input_vec[frame_base + input_count])
                    $fatal(1, "[FAIL] FFT input differs from HEX: %s frame=%0d sample=%0d got=%08h expected=%08h",
                           active_group, active_frame, input_count, in_data, input_vec[frame_base + input_count]);
                if (input_count == 0) begin
                    first_input_cycle <= cycle_count;
                    if (latency_trace)
                        $display("[LATENCY EVENT] %s frame=%0d first_input_handshake cycle=%0d",
                                 active_group, active_frame, cycle_count);
                end
                last_input_cycle <= cycle_count;
                input_count <= input_count + 1;
            end

            if (out_valid && out_ready) begin
                if (output_count >= N)
                    $fatal(1, "[FAIL] More than 512 output beats: %s frame=%0d", active_group, active_frame);
                else stream_capture[output_count] <= out_data;
                if ($isunknown(out_data) || $isunknown(out_last))
                    $fatal(1, "[FAIL] Unknown output data/TLAST: %s frame=%0d bin=%0d",
                           active_group, active_frame, output_count);
                if (output_count == 0) first_output_cycle <= cycle_count;
                last_output_cycle <= cycle_count;
                output_count <= output_count + 1;
                if (out_last) begin
                    tlast_count <= tlast_count + 1;
                    if (output_count != N-1)
                        $fatal(1, "[FAIL] TLAST at beat=%0d, expected=512", output_count + 1);
                end
            end
        end
    end

    function automatic string file_path(input string dir, input string leaf);
        return {dir, "/", leaf};
    endfunction

    // Strict loading rejects missing/extra words and malformed/X/Z data.
    // File contents are whitespace-separated 8-digit hexadecimal words.
    task automatic load_hex(input string path, input int count, input bit is_expected);
        integer fd;
        integer rc;
        integer parsed;
        integer index;
        integer ch;
        string token;
        logic [31:0] word;
        fd = $fopen(path, "r");
        if (fd == 0) $fatal(1, "[FAIL] Cannot open HEX: %s", path);
        index = 0;
        while (!$feof(fd)) begin
            rc = $fscanf(fd, "%s", token);
            if (rc == 1) begin
                if (index >= count) $fatal(1, "[FAIL] Too many HEX words: %s expected=%0d", path, count);
                if (token.len() != 8) $fatal(1, "[FAIL] HEX word must have 8 digits: %s index=%0d token=%s", path, index, token);
                for (int j = 0; j < 8; j++) begin
                    ch = token[j];
                    if (!((ch >= 48 && ch <= 57) || (ch >= 65 && ch <= 70) || (ch >= 97 && ch <= 102)))
                        $fatal(1, "[FAIL] Invalid HEX digit: %s index=%0d token=%s", path, index, token);
                end
                word = 'x;
                parsed = $sscanf(token, "%h", word);
                if (parsed != 1 || $isunknown(word)) $fatal(1, "[FAIL] Invalid HEX word in %s", path);
                if (is_expected) expected_vec[index] = word;
                else input_vec[index] = word;
                index++;
            end else if (!$feof(fd)) $fatal(1, "[FAIL] Cannot parse HEX: %s", path);
        end
        $fclose(fd);
        if (index != count) $fatal(1, "[FAIL] HEX size: %s got=%0d expected=%0d", path, index, count);
    endtask

    task automatic write_reg(input xil_axi_ulong addr, input bit [31:0] value);
        xil_axi_resp_t response;
        master_agent.AXI4LITE_WRITE_BURST(addr, 3'b000, value, response);
        if (response != XIL_AXI_RESP_OKAY) $fatal(1, "[FAIL] AXI-Lite write at %08h", addr);
    endtask

    task automatic read_reg(input xil_axi_ulong addr, output bit [31:0] value);
        xil_axi_resp_t response;
        master_agent.AXI4LITE_READ_BURST(addr, 3'b000, value, response);
        if (response != XIL_AXI_RESP_OKAY) $fatal(1, "[FAIL] AXI-Lite read at %08h", addr);
    endtask

    task automatic wait_for_dma();
        bit [31:0] tx_status;
        bit [31:0] rx_status;
        bit completed;
        completed = 0;
        for (int poll = 0; poll < MAX_POLLS; poll++) begin
            read_reg(MM2S_DMASR, tx_status);
            read_reg(S2MM_DMASR, rx_status);
            // Simple DMA errors at bits 6:4; bit13 is the error IRQ summary.
            if (((tx_status | rx_status) & 32'h0000_2070) != 0)
                $fatal(1, "[FAIL] DMA error: %s frame=%0d MM2S=%08h S2MM=%08h",
                       active_group, active_frame, tx_status, rx_status);
            if (tx_status[0] || rx_status[0])
                $fatal(1, "[FAIL] DMA halted during frame: %s frame=%0d", active_group, active_frame);
            if (tx_status[1] && rx_status[1] && tx_status[12] && rx_status[12]) begin
                completed = 1;
                break;
            end
            repeat (10) @(posedge aclk);
        end
        if (!completed)
            $fatal(1, "[FAIL] DMA timeout: %s frame=%0d MM2S=%08h S2MM=%08h",
                   active_group, active_frame, tx_status, rx_status);
    endtask

    task automatic prepare_frame(input int base);
        bit [31:0] word;
        // DMA is idle here. No global DUT reset between frames or groups.
        @(negedge aclk);
        frame_active = 0;
        monitor_clear = 1;
        frame_base = base;
        repeat (3) @(posedge aclk);
        @(negedge aclk);
        monitor_clear = 0;
        for (int k = 0; k < N; k++) begin
            memory_agent.mem_model.backdoor_memory_write(INPUT_ADDR + k*WORD_BYTES, input_vec[base+k], 4'hF);
            word = memory_agent.mem_model.backdoor_memory_read(INPUT_ADDR + k*WORD_BYTES);
            if (word !== input_vec[base+k]) $fatal(1, "[FAIL] Input preload sample=%0d", k);
            memory_agent.mem_model.backdoor_memory_write(OUTPUT_ADDR + k*WORD_BYTES, 32'hDEAD_BEEF, 4'hF);
        end
        // Guard words detect writes immediately outside the output frame.
        for (int k = 1; k <= 4; k++) begin
            memory_agent.mem_model.backdoor_memory_write(OUTPUT_ADDR - k*WORD_BYTES, GUARD_WORD, 4'hF);
            memory_agent.mem_model.backdoor_memory_write(OUTPUT_ADDR + FRAME_BYTES + (k-1)*WORD_BYTES, GUARD_WORD, 4'hF);
        end
        frame_active = 1;
    endtask

    task automatic start_frame();
        // Clear stale completion status. Channels remain in Run state.
        write_reg(MM2S_DMASR, 32'h0000_1000);
        write_reg(S2MM_DMASR, 32'h0000_1000);
        write_reg(S2MM_DA, OUTPUT_ADDR);
        write_reg(S2MM_LENGTH, FRAME_BYTES); // Arm receive before transmit.
        write_reg(MM2S_SA, INPUT_ADDR);
        write_reg(MM2S_LENGTH, FRAME_BYTES);
        wait_for_dma();
        // Let writes/counter updates settle and catch extra output beats.
        repeat (16) @(negedge aclk);
    endtask

    task automatic check_frame(input int actual_fd, output int mismatches,
                               output int max_component_error);
        bit [31:0] actual;
        bit [31:0] guard;
        int delta_re;
        int delta_im;
        longint latency;
        longint frame_span;
        longint valid_latency;
        longint input_span;
        longint output_span;
        longint first_output_wait;
        longint completion_latency;
        mismatches = 0;
        max_component_error = 0;
        if (input_count != N || output_count != N || tlast_count != 1)
            $fatal(1, "[FAIL] Frame counts: %s frame=%0d input=%0d output=%0d TLAST=%0d",
                   active_group, active_frame, input_count, output_count, tlast_count);
        if (first_input_cycle < 0 || first_output_cycle < first_input_cycle)
            $fatal(1, "[FAIL] Invalid frame timestamps");
        for (int k = 1; k <= 4; k++) begin
            guard = memory_agent.mem_model.backdoor_memory_read(OUTPUT_ADDR - k*WORD_BYTES);
            if (guard !== GUARD_WORD) $fatal(1, "[FAIL] Output underrun guard changed");
            guard = memory_agent.mem_model.backdoor_memory_read(OUTPUT_ADDR + FRAME_BYTES + (k-1)*WORD_BYTES);
            if (guard !== GUARD_WORD) $fatal(1, "[FAIL] Output overrun guard changed");
        end
        for (int k = 0; k < N; k++) begin
            actual = memory_agent.mem_model.backdoor_memory_read(OUTPUT_ADDR + k*WORD_BYTES);
            if (stream_capture[k] !== actual)
                $fatal(1, "[FAIL] Stream/memory mismatch: %s frame=%0d bin=%0d stream=%08h memory=%08h",
                       active_group, active_frame, k, stream_capture[k], actual);
            $fdisplay(actual_fd, "%08h", actual);
            // Extend each signed 16-bit part before subtraction (avoid overflow).
            delta_re = int'($signed(actual[15:0])) - int'($signed(expected_vec[frame_base+k][15:0]));
            delta_im = int'($signed(actual[31:16])) - int'($signed(expected_vec[frame_base+k][31:16]));
            if (delta_re < 0) delta_re = -delta_re;
            if (delta_im < 0) delta_im = -delta_im;
            if (delta_re > max_component_error) max_component_error = delta_re;
            if (delta_im > max_component_error) max_component_error = delta_im;
            if (actual !== expected_vec[frame_base+k]) begin
                mismatches++;
                if (group_mismatch_prints < MAX_MISMATCH_PRINTS) begin
                    $display("[MISMATCH] group=%s frame=%0d bin=%0d actual=%08h expected=%08h delta_Re=%0d delta_Im=%0d LSB",
                             active_group, active_frame, k, actual, expected_vec[frame_base+k], delta_re, delta_im);
                    group_mismatch_prints++;
                end
            end
        end
        if (first_output_valid_cycle < first_input_cycle ||
            first_output_cycle < first_output_valid_cycle ||
            last_input_cycle < first_input_cycle || last_output_cycle < first_output_cycle)
            $fatal(1, "[FAIL] Invalid latency timestamp ordering");
        latency = first_output_cycle - first_input_cycle;
        valid_latency = first_output_valid_cycle - first_input_cycle;
        first_output_wait = first_output_cycle - first_output_valid_cycle;
        if (first_output_wait != first_output_wait_cycles)
            $fatal(1, "[FAIL] First-output wait counter disagrees with timestamps");
        input_span = last_input_cycle - first_input_cycle + 1;
        output_span = last_output_cycle - first_output_cycle + 1;
        completion_latency = last_output_cycle - first_input_cycle;
        latency_frames++;
        valid_latency_sum += valid_latency;
        handshake_latency_sum += latency;
        if (valid_latency < valid_latency_min) valid_latency_min = valid_latency;
        if (valid_latency > valid_latency_max) valid_latency_max = valid_latency;
        if (latency < handshake_latency_min) handshake_latency_min = latency;
        if (latency > handshake_latency_max) handshake_latency_max = latency;
        $fdisplay(latency_csv, "%s,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0.3f,%0d,%0.3f,%0d,%0d,%0d,%0d,%0.3f,%0d,%0d,%0d",
            active_group, active_frame, first_input_cycle, last_input_cycle,
            first_output_valid_cycle, first_output_cycle, last_output_cycle,
            valid_latency, valid_latency*CLK_PERIOD_NS,
            latency, latency*CLK_PERIOD_NS, first_output_wait,
            input_span, output_span, completion_latency,
            completion_latency*CLK_PERIOD_NS, input_stall_cycles,
            output_stall_cycles, first_output_wait_cycles);
        $display("[LATENCY] %s frame=%0d first_valid=%0d cycles (%0.3f ns) first_handshake=%0d cycles (%0.3f ns) first_output_wait=%0d cycles completion=%0d cycles",
            active_group, active_frame, valid_latency, valid_latency*CLK_PERIOD_NS,
            latency, latency*CLK_PERIOD_NS, first_output_wait, completion_latency);
        frame_span = last_output_cycle - first_input_cycle + 1;
        $fdisplay(frame_csv, "%s,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0.3f,%0d,%0d,%s",
                  active_group, active_frame, input_count, output_count, tlast_count, mismatches,
                  max_component_error, latency, latency*CLK_PERIOD_NS, frame_span, output_stall_cycles,
                  (mismatches == 0) ? "PASS" : "FAIL");
        $display("[%s] %s frame=%0d input/output/TLAST=%0d/%0d/%0d mismatches=%0d max_error=%0d LSB first_handshake_latency=%0d cycles",
                 (mismatches == 0) ? "PASS" : "FAIL", active_group, active_frame,
                 input_count, output_count, tlast_count, mismatches, max_component_error, latency);
    endtask

    task automatic run_group(input string name, input int frames);
        integer fd;
        int errors;
        int group_errors;
        int group_failed_frames;
        int frame_max;
        int group_max;
        active_group = name;
        group_mismatch_prints = 0;
        group_errors = 0;
        group_failed_frames = 0;
        group_max = 0;
        load_hex(file_path(vec_dir, {"input_", name, ".hex"}), frames*N, 0);
        load_hex(file_path(vec_dir, {"expected_", name, ".hex"}), frames*N, 1);
        fd = $fopen(file_path(out_dir, {"actual_", name, ".hex"}), "w");
        if (fd == 0) $fatal(1, "[FAIL] Cannot create actual HEX in %s; directory must exist", out_dir);
        $display("\n[GROUP] %s frames=%0d samples=%0d (exact comparison against Simulink)", name, frames, frames*N);
        for (int f = 0; f < frames; f++) begin
            active_frame = f; // Frame and bin numbers are zero-based in logs.
            prepare_frame(f*N);
            start_frame();
            check_frame(fd, errors, frame_max);
            group_errors += errors;
            if (errors != 0) group_failed_frames++;
            if (frame_max > group_max) group_max = frame_max;
        end
        $fclose(fd);
        total_frames += frames;
        total_samples += frames*N;
        total_mismatches += group_errors;
        failed_frames += group_failed_frames;
        $fdisplay(group_csv, "%s,%0d,%0d,%0d,%0d,%0d,%s", name, frames, frames*N,
                  group_errors, group_failed_frames, group_max, (group_errors == 0) ? "PASS" : "FAIL");
        $display("[GROUP %s] %s frames=%0d samples=%0d mismatches=%0d failed_frames=%0d",
                 (group_errors == 0) ? "PASS" : "FAIL", name, frames, frames*N, group_errors, group_failed_frames);
    endtask

    initial begin : main
        bit [31:0] status;
        vec_dir = "C:/FPGA/ts/matlab_source";
        out_dir = "."; // Default: Vivado/XSim working directory.
        latency_trace = $test$plusargs("LATENCY_TRACE");
        if ($value$plusargs("VEC_DIR=%s", vec_dir)) begin end
        if ($value$plusargs("OUT_DIR=%s", out_dir)) begin end
        $display("========================================");
        $display(" FFT 512 HEX VERIFICATION -- 4 groups / 97 frames");
        $display(" VEC_DIR=%s", vec_dir);
        $display(" OUT_DIR=%s", out_dir);
        $display(" Exact expected: Simulink fixed point; Im[31:16], Re[15:0]");
        $display(" Frames are DMA transactions with gaps; this is not a gapless-stream test.");
        $display("========================================");
        frame_csv = $fopen(file_path(out_dir, "fft_frame_results.csv"), "w");
        group_csv = $fopen(file_path(out_dir, "fft_group_results.csv"), "w");
        latency_csv = $fopen(file_path(out_dir, "fft_latency_results.csv"), "w");
        if (latency_csv == 0) $fatal(1, "[FAIL] Cannot create latency CSV in %s", out_dir);
        $fdisplay(latency_csv, "group,frame_zero_based,first_input_handshake_cycle,last_input_handshake_cycle,first_output_valid_cycle,first_output_handshake_cycle,last_output_handshake_cycle,first_valid_latency_cycles,first_valid_latency_ns,first_handshake_latency_cycles,first_handshake_latency_ns,first_output_wait_cycles,input_span_cycles,output_span_cycles,completion_latency_cycles,completion_latency_ns,input_stall_cycles,output_stall_cycles,first_output_stall_cycles");
        if (frame_csv == 0 || group_csv == 0) $fatal(1, "[FAIL] Cannot create CSV files in %s", out_dir);
        $fdisplay(frame_csv, "group,frame_zero_based,input_beats,output_beats,tlast_beats,mismatch_samples,max_component_error_lsb,first_handshake_latency_cycles,first_handshake_latency_ns,frame_span_cycles,output_stall_cycles,result");
        $fdisplay(group_csv, "group,frames,samples,mismatch_samples,failed_frames,max_component_error_lsb,result");

        repeat (30) @(posedge aclk);
        @(negedge aclk); aresetn = 1;
        repeat (30) @(posedge aclk);
        master_agent = new("FFT_AXI_Master", dut.design_1_i.axi_vip_master_0.inst.IF);
        memory_agent = new("FFT_DDR_Memory", dut.design_1_i.axi_vip_memory_0.inst.IF);
        memory_agent.start_slave();
        master_agent.start_master();
        write_reg(FFT_ENABLE, 32'h1);
        write_reg(S2MM_DMACR, 32'h1);
        write_reg(MM2S_DMACR, 32'h1);
        repeat (30) @(posedge aclk);
        read_reg(MM2S_DMASR, status);
        if (status[0]) $fatal(1, "[FAIL] MM2S did not start");
        read_reg(S2MM_DMASR, status);
        if (status[0]) $fatal(1, "[FAIL] S2MM did not start");
        $display("[PASS] Initialization and AXI-Lite access");

        run_group("impulse_n0", 1);
        run_group("impulse_n1", 1);
        run_group("two_tone_k32_k80", 1);
        run_group("speech_6s", SPEECH_FRAMES);

        // Leave monitoring enabled briefly to reject late extra frame beats.
        repeat (20) @(negedge aclk);
        $fclose(frame_csv);
        $fclose(group_csv);
        $fclose(latency_csv);
        $display("[LATENCY SUMMARY] frames=%0d first_valid min/avg/max=%0d/%0.3f/%0d cycles; first_handshake min/avg/max=%0d/%0.3f/%0d cycles",
            latency_frames, valid_latency_min, real'(valid_latency_sum)/latency_frames,
            valid_latency_max, handshake_latency_min,
            real'(handshake_latency_sum)/latency_frames, handshake_latency_max);
        $display("Latency detail CSV: fft_latency_results.csv; clock period=%0.3f ns", CLK_PERIOD_NS);
        $display("\n========================================");
        $display("Frames=%0d Samples=%0d Mismatches=%0d Failed_frames=%0d",
                 total_frames, total_samples, total_mismatches, failed_frames);
        $display("CSV: fft_group_results.csv and fft_frame_results.csv");
        if (total_frames != 97 || total_samples != 49664) $fatal(1, "[FAIL] Incomplete test suite");
        if (total_mismatches != 0) $fatal(1, "[FAIL] RTL differs from Simulink expected. Inspect CSV and actual HEX; do not relax to a tolerance silently.");
        $display("[PASS] ALL 4 GROUPS / 97 FRAMES MATCH SIMULINK BIT FOR BIT");
        $display("This verifies simulated DMA/FFT/memory, not physical PS/DDR or board operation.");
        $display("========================================");
        $finish;
    end
endmodule
