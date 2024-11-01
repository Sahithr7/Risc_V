// File: control_unit.v
// Control Unit Module
`timescale 1ns / 1ps

module control_unit (
    input [6:0] opcode,
    output reg reg_write,
    output reg mem_to_reg,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg [1:0] alu_op,
    output reg alu_src
);
    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1;
                mem_to_reg = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b10;
                alu_src = 0;
            end
            7'b0000011: begin // Load (LW)
                reg_write = 1;
                mem_to_reg = 1;
                mem_read = 1;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
                alu_src = 1;
            end
            7'b0100011: begin // Store (SW)
                reg_write = 0;
                mem_to_reg = 0;
                mem_read = 0;
                mem_write = 1;
                branch = 0;
                alu_op = 2'b00;
                alu_src = 1;
            end
            7'b1100011: begin // Branch (BEQ)
                reg_write = 0;
                mem_to_reg = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 1;
                alu_op = 2'b01;
                alu_src = 0;
            end
            7'b0010011: begin // Immediate arithmetic (ADDI)
                reg_write = 1;
                mem_to_reg = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
                alu_src = 1;
            end
            default: begin
                reg_write = 0;
                mem_to_reg = 0;
                mem_read = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
                alu_src = 0;
            end
        endcase
    end
endmodule
