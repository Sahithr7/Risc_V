// File: alu.v
// ALU Module
`timescale 1ns / 1ps

module alu (
    input [31:0] operand_a,
    input [31:0] operand_b,
    input [3:0] alu_control,
    output reg [31:0] alu_result,
    output zero
);
    assign zero = (alu_result == 0);

    always @(*) begin
        case (alu_control)
            4'b0000: alu_result = operand_a & operand_b;             // AND
            4'b0001: alu_result = operand_a | operand_b;             // OR
            4'b0010: alu_result = operand_a + operand_b;             // ADD
            4'b0110: alu_result = operand_a - operand_b;             // SUB
            4'b0111: alu_result = (operand_a < operand_b) ? 1 : 0;   // SLT
            4'b1100: alu_result = ~(operand_a | operand_b);          // NOR
            default: alu_result = 0;
        endcase
    end
endmodule
