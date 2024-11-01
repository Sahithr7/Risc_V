// File: control_unit_tb.v
// Testbench for the Control Unit Module
`timescale 1ns / 1ps

module control_unit_tb;
    reg [6:0] opcode;
    wire branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;
    wire [1:0] alu_op;

    // Instantiate the Control Unit
    control_unit dut (
        .opcode(opcode),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_op(alu_op)
    );

    // Test procedure
    initial begin
        // R-type instruction
        opcode = 7'b0110011;
        #10;
        $display("R-type: RegWrite=%b, ALUOp=%b (Expected: RegWrite=1, ALUOp=10)", reg_write, alu_op);

        // I-type instruction (ADDI)
        opcode = 7'b0010011;
        #10;
        $display("I-type (ADDI): RegWrite=%b, ALUSrc=%b, ALUOp=%b (Expected: RegWrite=1, ALUSrc=1, ALUOp=00)", reg_write, alu_src, alu_op);

        // Branch instruction (BEQ)
        opcode = 7'b1100011;
        #10;
        $display("Branch (BEQ): Branch=%b, ALUOp=%b (Expected: Branch=1, ALUOp=01)", branch, alu_op);

        // Finish simulation
        $finish;
    end
endmodule
