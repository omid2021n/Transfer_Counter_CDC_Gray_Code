module counter (
    input  wire                  clk_ref,
    input  wire                  rst,
    input  wire                  en,
    input  wire                  clk_out,
    output wire [1:0]      count_o
);

    // Internal counter in source clock domain
    reg [1:0] count;

    // Counter logic
    always @(posedge clk_ref) begin
        if (rst) count <= 0;
        else if (en) begin
             if (count != 2'b11)
                    count <= count + 1;
             else
                    count <= 2'b00;
             end
        end

    // CDC using Gray-coded synchronizer
    xpm_cdc_gray #(
        .DEST_SYNC_FF(4),
        .INIT_SYNC_FF(1),
        .REG_OUTPUT(0),
        .SIM_ASSERT_CHK(0),
        .SIM_LOSSLESS_GRAY_CHK(0),
        .WIDTH(2)
    ) xpm_cdc_gray_inst (
        .src_clk(clk_ref),
        .src_in_bin(count),
        .dest_clk(clk_out),
        .dest_out_bin(count_o)
    );

endmodule
