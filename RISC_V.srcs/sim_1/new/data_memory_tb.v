// File: data_memory_tb.v
// Testbench for the Data Memory Module
`timescale 1ns / 1ps

module data_memory_tb;
    reg clk;
    reg mem_read;
    reg mem_write;
    reg [31:0] addr;
    reg [31:0] write_data;
    wire [31:0] read_data;

    // Instantiate the Data Memory
    data_memory dut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        // Write data to address 0x00000010
        mem_write = 1;
        mem_read = 0;
        addr = 32'h00000010;
        write_data = 32'hDEADBEEF;
        #10;

        // Disable write
        mem_write = 0;

        // Read data from address 0x00000010
        mem_read = 1;
        #10;
        $display("Read Data: %h (Expected: DEADBEEF)", read_data);

        // Finish simulation
        $finish;
    end
endmodule
