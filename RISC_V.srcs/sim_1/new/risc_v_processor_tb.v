// File: risc_v_processor_tb.v
// Testbench for the RISC-V Processor with Extended Register Testing
`timescale 1ns / 1ps

module risc_v_processor_tb;
    reg clk;
    reg reset;

    // Instantiate the processor
    risc_v_processor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock (Period = 10ns)
    end

    // Simulation control
    initial begin
        // Apply reset
        reset = 1;
        #15; // Hold reset for some time
        reset = 0;

        // Run the simulation for sufficient time to execute all instructions
        #1000; // Adjust the time as needed based on the program length
        $finish;
    end

    // Monitor key signals (optional)
    initial begin
        $monitor("Time: %0t | PC: %h | Instruction: %h | RegWrite: %b | ALUResult: %h",
                 $time, uut.pc_out, uut.instruction, uut.reg_write, uut.alu_result);
    end

    // Dump waveforms (optional)
    initial begin
        $dumpfile("risc_v_processor_tb.vcd");
        $dumpvars(0, risc_v_processor_tb);
    end

    // Monitoring register file contents
    wire [31:0] reg_file [0:31];
    integer i;

    // Access the register file inside the processor for monitoring
    generate
        genvar idx;
        for (idx = 0; idx < 32; idx = idx + 1) begin : reg_monitor
            assign reg_file[idx] = uut.RF.registers[idx];
        end
    endgenerate

    // Display register values at the end of simulation
    initial begin
        #1010; // Wait until simulation ends
        $display("\nRegister File Contents at the End of Simulation:");
        for (i = 0; i < 32; i = i + 1) begin
            $display("x%0d = %h", i, reg_file[i]);
        end
    end

    // Optionally monitor data memory contents if needed
    // (Not necessary in this test, as we are focusing on registers)

endmodule
