// File: alu_control.v
// ALU Control Unit Module
`timescale 1ns / 1ps

module alu_control (
    input [1:0] alu_op,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] alu_control
);
    always @(*) begin
        case (alu_op)
            2'b00: alu_control = 4'b0010; // ADD for Load/Store/ADDI
            2'b01: alu_control = 4'b0110; // SUB for BEQ
            2'b10: begin // R-type instructions
                if (funct7 == 7'b0000000) begin
                    case (funct3)
                        3'b000: alu_control = 4'b0010; // ADD
                        3'b111: alu_control = 4'b0000; // AND
                        3'b110: alu_control = 4'b0001; // OR
                        default: alu_control = 4'b0000;
                    endcase
                end else if (funct7 == 7'b0100000 && funct3 == 3'b000) begin
                    alu_control = 4'b0110; // SUB
                end else begin
                    alu_control = 4'b0000;
                end
            end
            default: alu_control = 4'b0000;
        endcase
    end
endmodule
