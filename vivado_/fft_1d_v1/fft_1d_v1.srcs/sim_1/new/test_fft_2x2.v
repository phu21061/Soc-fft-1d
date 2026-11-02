`timescale 1ns / 1ps
module tb_FFT_512_I_ip_stream_2x2;
    reg IPCORE_CLK = 0, IPCORE_RESETN = 0;
    always #5 IPCORE_CLK = ~IPCORE_CLK; // 100 MHz

    reg  [31:0] AXI4_Stream_Slave_TDATA = 0;
    reg         AXI4_Stream_Slave_TVALID = 0;
    wire        AXI4_Stream_Slave_TREADY;
    wire [31:0] AXI4_Stream_Master_TDATA;
    wire        AXI4_Stream_Master_TVALID, AXI4_Stream_Master_TLAST;
    reg         AXI4_Stream_Master_TREADY = 1;
    integer out_count = 0;
    integer out_frame_count = 0;
    integer i;
    wire signed [15:0] out_real = AXI4_Stream_Master_TDATA[15:0];
    wire signed [15:0] out_imag = AXI4_Stream_Master_TDATA[31:16];

    FFT_512_I_ip_stream_2x2 u_dut (
        .IPCORE_CLK(IPCORE_CLK), .IPCORE_RESETN(IPCORE_RESETN),
        .AXI4_Stream_Slave_TDATA(AXI4_Stream_Slave_TDATA),
        .AXI4_Stream_Slave_TVALID(AXI4_Stream_Slave_TVALID),
        .AXI4_Stream_Slave_TREADY(AXI4_Stream_Slave_TREADY),
        .AXI4_Stream_Master_TDATA(AXI4_Stream_Master_TDATA),
        .AXI4_Stream_Master_TVALID(AXI4_Stream_Master_TVALID),
        .AXI4_Stream_Master_TREADY(AXI4_Stream_Master_TREADY),
        .AXI4_Stream_Master_TLAST(AXI4_Stream_Master_TLAST),
        // This generated IP defaults to enabled after reset.
        .AXI4_Lite_ACLK(IPCORE_CLK), .AXI4_Lite_ARESETN(IPCORE_RESETN),
        .AXI4_Lite_AWADDR(16'd0), .AXI4_Lite_AWVALID(1'b0),
        .AXI4_Lite_WDATA(32'd0), .AXI4_Lite_WSTRB(4'd0),
        .AXI4_Lite_WVALID(1'b0), .AXI4_Lite_BREADY(1'b1),
        .AXI4_Lite_ARADDR(16'd0), .AXI4_Lite_ARVALID(1'b0),
        .AXI4_Lite_RREADY(1'b1)
    );

    always @(posedge IPCORE_CLK) begin
        if (!IPCORE_RESETN) begin
            out_count <= 0;
            out_frame_count <= 0;
        end else if (AXI4_Stream_Master_TVALID && AXI4_Stream_Master_TREADY) begin
            out_count <= out_count + 1;
            if (AXI4_Stream_Master_TLAST)
                out_frame_count <= out_frame_count + 1;
        end
    end

    initial begin
        repeat (10) @(posedge IPCORE_CLK);
        @(negedge IPCORE_CLK); IPCORE_RESETN = 1;
        repeat (30) @(posedge IPCORE_CLK);

        // TWO consecutive impulse frames, 512 samples each.
        // Frame 1: impulse=8192 -> ideal FFT/512 = 16+j0 at every bin.
        // Frame 2: impulse=16384 -> ideal FFT/512 = 32+j0 at every bin.
        for (i = 0; i < 1024; i = i + 1) begin
            @(negedge IPCORE_CLK);
            if      (i == 0)   AXI4_Stream_Slave_TDATA = 32'h00002000;
            else if (i == 512) AXI4_Stream_Slave_TDATA = 32'h00004000;
            else              AXI4_Stream_Slave_TDATA = 32'd0;
            AXI4_Stream_Slave_TVALID = 1;
            @(posedge IPCORE_CLK);
            while (AXI4_Stream_Slave_TREADY !== 1'b1)
                @(posedge IPCORE_CLK);
        end
        @(negedge IPCORE_CLK);
        AXI4_Stream_Slave_TVALID = 0; // No additional valid zero frames.
        AXI4_Stream_Slave_TDATA = 0;

        wait (out_count == 1024);
        repeat (50) @(negedge IPCORE_CLK); // Idle tail for the waveform.
        $display("Two frames complete: samples=%0d, TLAST count=%0d", out_count, out_frame_count);
        $finish;
    end

    initial begin
        #100000;
        $display("[ERROR] Timeout waiting for FFT");
        $finish;
    end
endmodule
