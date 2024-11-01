// File: risc_v_processor.v
// RISC-V Processor Top Module
`timescale 1ns / 1ps

module risc_v_processor (
    input clk,
    input reset
);
    wire [31:0] pc_in;
    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] rs1_data, rs2_data;
    wire [31:0] alu_result;
    wire [31:0] mem_read_data;
    wire [31:0] write_data;
    wire [31:0] immediate;
    wire zero;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1_addr, rs2_addr, rd_addr;

    // Control signals
    wire reg_write, mem_to_reg, mem_read, mem_write, branch, alu_src;
    wire [1:0] alu_op;
    wire [3:0] alu_control;

    // Program Counter
    pc PC (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Instruction Memory
    instruction_memory IMEM (
        .addr(pc_out),
        .instruction(instruction)
    );

    // Extract instruction fields
    assign opcode = instruction[6:0];
    assign rd_addr = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign funct7 = instruction[31:25];

    // Control Unit
    control_unit CU (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_to_reg(mem_to_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op),
        .alu_src(alu_src)
    );

    // Register File
    register_file RF (
        .clk(clk),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(write_data),
        .reg_write(reg_write),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Sign Extender
    sign_extender SE (
        .instruction(instruction),
        .immediate(immediate)
    );

    // ALU Control Unit
    alu_control ALU_CU (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)
    );

    // ALU
    wire [31:0] alu_operand_b;
    assign alu_operand_b = (alu_src) ? immediate : rs2_data;
    alu ALU (
        .operand_a(rs1_data),
        .operand_b(alu_operand_b),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero(zero)
    );

    // Data Memory
    data_memory DMEM (
        .clk(clk),
        .addr(alu_result),
        .write_data(rs2_data),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(mem_read_data)
    );

    // Write back data selection
    assign write_data = (mem_to_reg) ? mem_read_data : alu_result;

    // Next PC computation
    wire [31:0] pc_plus_4;
    assign pc_plus_4 = pc_out + 4;
    wire [31:0] branch_target;
    assign branch_target = pc_out + immediate;

    assign pc_in = (branch && zero) ? branch_target : pc_plus_4;

endmodule
