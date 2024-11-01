// File: alu_control_tb.v
// Testbench for the ALU Control Unit Module
`timescale 1ns / 1ps

module alu_control_tb;
    reg [1:0] alu_op;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire [3:0] alu_control;

    // Instantiate the ALU Control Unit
    alu_control dut (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)
    );

    // Test procedure
    initial begin
        // R-type ADD
        alu_op = 2'b10;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        $display("ALU Control (ADD): %b (Expected: 0010)", alu_control);

        // R-type SUB
        funct7 = 7'b0100000;
        #10;
        $display("ALU Control (SUB): %b (Expected: 0110)", alu_control);

        // R-type AND
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        #10;
        $display("ALU Control (AND): %b (Expected: 0000)", alu_control);

        // R-type OR
        funct3 = 3'b110;
        #10;
        $display("ALU Control (OR): %b (Expected: 0001)", alu_control);

        // R-type SLT
        funct3 = 3'b010;
        #10;
        $display("ALU Control (SLT): %b (Expected: 0111)", alu_control);

        // Finish simulation
        $finish;
    end
endmodule
