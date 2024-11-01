// File: instruction_memory.v
// Instruction Memory Module with Corrected Test Program
`timescale 1ns / 1ps

module instruction_memory (
    input [31:0] addr,
    output [31:0] instruction
);
    reg [31:0] memory [0:255]; // 256 instructions

    integer i;
    reg signed [11:0] imm;     // 12-bit signed immediate
    reg [4:0] rd;              // 5-bit destination register
    reg [4:0] rs1;             // 5-bit source register 1
    reg [4:0] rs2;             // 5-bit source register 2
    reg [6:0] funct7;          // 7-bit funct7 field
    reg [2:0] funct3;          // 3-bit funct3 field
    reg [6:0] opcode;          // 7-bit opcode field
    reg [31:0] instruction_word;

    initial begin
        // Initialize instruction memory with a test program that writes to many registers

        // Program:
        // Initialize registers x1 to x31 with values 10, 20, ..., 310
        // Using ADDI instructions

        for (i = 0; i < 31; i = i + 1) begin
            rd = i + 1;
            rs1 = 5'd0; // x0
            funct3 = 3'b000; // For ADDI
            opcode = 7'b0010011; // Opcode for immediate arithmetic instructions

            // Calculate immediate value and ensure it fits in 12 bits
            imm = (i + 1) * 10;
            if (imm > 2047) begin
                imm = 2047; // Limit to maximum positive value
            end

            // Build the instruction word for ADDI
            instruction_word = {imm[11:0], rs1[4:0], funct3[2:0], rd[4:0], opcode[6:0]};
            memory[i] = instruction_word;
        end

        // Perform operations on the registers

        // ADD x31, x1, x2     ; x31 = x1 + x2
        funct7 = 7'b0000000;
        rs2 = 5'd2; // x2
        rs1 = 5'd1; // x1
        funct3 = 3'b000; // For ADD
        rd = 5'd31; // x31
        opcode = 7'b0110011; // Opcode for R-type instructions
        instruction_word = {funct7[6:0], rs2[4:0], rs1[4:0], funct3[2:0], rd[4:0], opcode[6:0]};
        memory[31] = instruction_word;

        // SUB x30, x3, x4     ; x30 = x3 - x4
        funct7 = 7'b0100000; // For SUB
        rs2 = 5'd4; // x4
        rs1 = 5'd3; // x3
        funct3 = 3'b000; // For SUB
        rd = 5'd30; // x30
        opcode = 7'b0110011;
        instruction_word = {funct7[6:0], rs2[4:0], rs1[4:0], funct3[2:0], rd[4:0], opcode[6:0]};
        memory[32] = instruction_word;

        // AND x29, x5, x6     ; x29 = x5 & x6
        funct7 = 7'b0000000;
        rs2 = 5'd6; // x6
        rs1 = 5'd5; // x5
        funct3 = 3'b111; // For AND
        rd = 5'd29; // x29
        opcode = 7'b0110011;
        instruction_word = {funct7[6:0], rs2[4:0], rs1[4:0], funct3[2:0], rd[4:0], opcode[6:0]};
        memory[33] = instruction_word;

        // OR x28, x7, x8      ; x28 = x7 | x8
        funct7 = 7'b0000000;
        rs2 = 5'd8; // x8
        rs1 = 5'd7; // x7
        funct3 = 3'b110; // For OR
        rd = 5'd28; // x28
        opcode = 7'b0110011;
        instruction_word = {funct7[6:0], rs2[4:0], rs1[4:0], funct3[2:0], rd[4:0], opcode[6:0]};
        memory[34] = instruction_word;

        // SLT x27, x9, x10    ; x27 = (x9 < x10) ? 1 : 0
        funct7 = 7'b0000000;
        rs2 = 5'd10; // x10
        rs1 = 5'd9; // x9
        funct3 = 3'b010; // For SLT
        rd = 5'd27; // x27
        opcode = 7'b0110011;
        instruction_word = {funct7[6:0], rs2[4:0], rs1[4:0], funct3[2:0], rd[4:0], opcode[6:0]};
        memory[35] = instruction_word;

        // Additional instructions can be added here
    end

    assign instruction = memory[addr[9:2]]; // Word-aligned address
endmodule
