// File: instruction_memory_tb.v
// Testbench for the Instruction Memory Module
`timescale 1ns / 1ps

module instruction_memory_tb;
    reg [31:0] addr;
    wire [31:0] instruction;

    // Instantiate the instruction memory
    instruction_memory dut (
        .addr(addr),
        .instruction(instruction)
    );

    // Initialize the instruction memory
    initial begin
        // Ensure the memory is initialized (if not already in the module)
        $readmemh("instruction_memory.hex", dut.memory);
    end

    // Test procedure
    initial begin
        // Apply test addresses
        addr = 32'h00000000;
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction);

        addr = 32'h00000004;
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction);

        addr = 32'h00000008;
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction);

        addr = 32'h0000000C;
        #10;
        $display("Address: %h, Instruction: %h", addr, instruction);

        // Finish simulation
        $finish;
    end
endmodule
