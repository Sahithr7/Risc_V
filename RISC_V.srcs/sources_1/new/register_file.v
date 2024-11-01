// File: register_file.v
// Register File Module
`timescale 1ns / 1ps

module register_file (
    input clk,
    input [4:0] rs1_addr,
    input [4:0] rs2_addr,
    input [4:0] rd_addr,
    input [31:0] rd_data,
    input reg_write,
    output [31:0] rs1_data,
    output [31:0] rs2_data
);
    reg [31:0] registers [0:31];

    // Read operations
    assign rs1_data = registers[rs1_addr];
    assign rs2_data = registers[rs2_addr];

    // Write operation
    always @(posedge clk) begin
        if (reg_write && rd_addr != 0)
            registers[rd_addr] <= rd_data;
    end

    // Initialize registers
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 32'b0;
    end
endmodule
