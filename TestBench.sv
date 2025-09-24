
`timescale 1ns / 1ps

module tb_counter;

    // Parameters
    

    // Clock and reset signals
    reg clk_ref = 0;
    reg clk_out = 0;
    reg rst = 1;
    reg en = 0;

    wire [1:0] count_o;

    // Instantiate the counter
    counter  dut (
        .clk_ref(clk_ref),
        .rst(rst),
        .en(en),
        .clk_out(clk_out),
        .count_o(count_o)
    );


    always #20 clk_ref = ~clk_ref;

  
    always #20 clk_out = ~clk_out;

    // Stimulus
    initial begin
        $display("Starting simulation...");
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, tb_counter);

        #100 rst = 0;  // Deassert reset
        #10 en = 1;     // Enable counting

        // Run simulation
        #500;

        en = 0;
        $display("Stopping simulation...");
        $finish;
    end

endmodule

