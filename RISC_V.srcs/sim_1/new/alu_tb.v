// File: alu_tb.v
// Testbench for the ALU Module
`timescale 1ns / 1ps

module alu_tb;
    reg [31:0] operand_a;
    reg [31:0] operand_b;
    reg [3:0] alu_control;
    wire [31:0] alu_result;
    wire zero;

    // Instantiate the ALU
    alu dut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero(zero)
    );

    // Test procedure
    initial begin
        // Test ADD operation
        operand_a = 32'd10;
        operand_b = 32'd20;
        alu_control = 4'b0010; // ADD
        #10;
        $display("ADD Result: %d (Expected: 30)", alu_result);

        // Test SUB operation
        alu_control = 4'b0110; // SUB
        #10;
        $display("SUB Result: %d (Expected: -10)", alu_result);

        // Test AND operation
        alu_control = 4'b0000; // AND
        #10;
        $display("AND Result: %h (Expected: 00000000)", alu_result);

        // Test OR operation
        alu_control = 4'b0001; // OR
        #10;
        $display("OR Result: %h (Expected: 0000001E)", alu_result);

        // Test SLT operation
        alu_control = 4'b0111; // SLT
        #10;
        $display("SLT Result: %d (Expected: 1)", alu_result);

        // Test Zero flag
        operand_a = 32'd10;
        operand_b = 32'd10;
        alu_control = 4'b0110; // SUB
        #10;
        $display("Zero Flag: %b (Expected: 1)", zero);

        // Finish simulation
        $finish;
    end
endmodule
