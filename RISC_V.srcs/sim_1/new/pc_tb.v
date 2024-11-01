// File: pc_tb.v
// Testbench for the Program Counter Module
`timescale 1ns / 1ps

module pc_tb;
    reg clk;
    reg reset;
    reg [31:0] pc_in;
    wire [31:0] pc_out;

    // Instantiate the program counter
    pc dut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        // Apply reset
        reset = 1;
        pc_in = 32'h00000000;
        #12; // Wait for a few clock cycles
        reset = 0;

        // Apply test inputs
        pc_in = 32'h00000004;
        #10;
        $display("PC Out: %h (Expected: 00000004)", pc_out);

        pc_in = 32'h00000008;
        #10;
        $display("PC Out: %h (Expected: 00000008)", pc_out);

        pc_in = 32'h0000000C;
        #10;
        $display("PC Out: %h (Expected: 0000000C)", pc_out);

        // Apply reset again
        reset = 1;
        #10;
        $display("After reset, PC Out: %h (Expected: 00000000)", pc_out);

        // Finish simulation
        $finish;
    end
endmodule
