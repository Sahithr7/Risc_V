// File: register_file_tb.v
// Testbench for the Register File Module
`timescale 1ns / 1ps

module register_file_tb;
    reg clk;
    reg reg_write;
    reg [4:0] rs1_addr, rs2_addr, rd_addr;
    reg [31:0] rd_data;
    wire [31:0] rs1_data, rs2_data;

    // Instantiate the register file
    register_file dut (
        .clk(clk),
        .reg_write(reg_write),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reg_write = 0;
        rd_addr = 0;
        rd_data = 0;
        rs1_addr = 0;
        rs2_addr = 0;

        // Wait for reset (if any)
        #10;

        // Write to register x1
        reg_write = 1;
        rd_addr = 5'd1;
        rd_data = 32'h12345678;
        #10;

        // Write to register x2
        rd_addr = 5'd2;
        rd_data = 32'h9ABCDEF0;
        #10;

        // Disable write
        reg_write = 0;

        // Read from x1 and x2
        rs1_addr = 5'd1;
        rs2_addr = 5'd2;
        #10;
        $display("Read x1: %h (Expected: 12345678)", rs1_data);
        $display("Read x2: %h (Expected: 9ABCDEF0)", rs2_data);

        // Attempt to write to x0 (should have no effect)
        reg_write = 1;
        rd_addr = 5'd0;
        rd_data = 32'hFFFFFFFF;
        #10;

        // Read from x0
        reg_write = 0;
        rs1_addr = 5'd0;
        #10;
        $display("Read x0: %h (Expected: 00000000)", rs1_data);

        // Finish simulation
        $finish;
    end
endmodule
