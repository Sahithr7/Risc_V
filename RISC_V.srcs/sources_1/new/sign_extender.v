// File: sign_extender.v
// Sign Extender Module
`timescale 1ns / 1ps

module sign_extender (
    input [31:0] instruction,
    output reg [31:0] immediate
);
    always @(*) begin
        case (instruction[6:0])
            7'b0000011, // Load
            7'b0010011: // Immediate arithmetic
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b0100011: // Store
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            7'b1100011: // Branch
                immediate = {{19{instruction[31]}}, instruction[31], instruction[7],
                             instruction[30:25], instruction[11:8], 1'b0};
            default:
                immediate = 32'b0;
        endcase
    end
endmodule
