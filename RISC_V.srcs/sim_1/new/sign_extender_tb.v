// File: sign_extender_tb.v
// Testbench for the Sign Extender Module
`timescale 1ns / 1ps

module sign_extender_tb;
    reg [31:0] instruction;
    wire [31:0] immediate;

    // Instantiate the Sign Extender
    sign_extender dut (
        .instruction(instruction),
        .immediate(immediate)
    );

    // Test procedure
    initial begin
        // I-type instruction (ADDI x1, x0, 5)
        instruction = 32'b000000000101_00000_000_00001_0010011;
        #10;
        $display("Immediate (I-type): %d (Expected: 5)", immediate);

        // B-type instruction (BEQ x0, x1, -4)
        instruction = 32'b1111111_00001_00000_000_00000_1100011;
        #10;
        $display("Immediate (B-type): %d (Expected: -4)", immediate);

        // Finish simulation
        $finish;
    end
endmodule
