// File: data_memory.v
// Data Memory Module
`timescale 1ns / 1ps

module data_memory (
    input clk,
    input [31:0] addr,
    input [31:0] write_data,
    input mem_write,
    input mem_read,
    output reg [31:0] read_data
);
    reg [31:0] memory [0:255]; // 256 words

    always @(posedge clk) begin
        if (mem_write)
            memory[addr[9:2]] <= write_data;
    end

    always @(*) begin
        if (mem_read)
            read_data = memory[addr[9:2]];
        else
            read_data = 32'b0;
    end

    // Initialize data memory if needed
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'b0;
    end
endmodule
