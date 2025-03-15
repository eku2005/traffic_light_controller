`timescale 1ns/1ps  // Explicit timescale definition

module traffic_light_tb;
    reg clk;
    reg Sa, Sb;
    wire Ra, Ga, Ya, Rb, Gb, Yb;

    // Instantiate the DUT (Design Under Test)
    traffic_light dut (
        .clk(clk), 
        .Sa(Sa), 
        .Sb(Sb), 
        .Ra(Ra), 
        .Ga(Ga), 
        .Ya(Ya), 
        .Rb(Rb), 
        .Gb(Gb), 
        .Yb(Yb)
    );

    // Clock Generation
    always #5 clk = ~clk;  // 10ns clock period

    // Simulation Process
    initial begin
        // Dump waveform data for EPWave
        $dumpfile("dump.vcd");
        $dumpvars(0, traffic_light_tb);

        // Initialize Signals
        clk = 0;
        Sa = 0;
        Sb = 0;

        // Print Header
        $display("Time | Sa Sb | Ra Ga Ya | Rb Gb Yb");
        $monitor("Time=%0t | Sa=%b Sb=%b | Ra=%b Ga=%b Ya=%b | Rb=%b Gb=%b Yb=%b", 
                  $time, Sa, Sb, Ra, Ga, Ya, Rb, Gb, Yb);

        // Simulate Traffic Light Changes
        #10 Sa = 1; Sb = 0;  // Case 1
        #40 Sa = 0; Sb = 0;  // Case 2
        #30 Sa = 0; Sb = 1;  // Case 3
        #50 Sa = 0; Sb = 0;  // Case 4
        #20 Sa = 1; Sb = 1;  // Case 5
        #50 Sa = 0; Sb = 0;  // Back to default

        // End Simulation
        #100;
        $finish;
    end
endmodule
