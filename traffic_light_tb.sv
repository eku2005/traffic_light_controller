`timescale 1ns/1ps

module tb_traffic_light;
  // testbench signals
  reg  clk   = 0;
  reg  reset = 1;
  reg  Sa    = 0;
  reg  Sb    = 0;
  wire Ra, Ya, Ga;
  wire Rb, Yb, Gb;

  // instantiate DUT
  traffic_light_controller dut (
    .clk   (clk),
    .reset (reset),
    .Sa    (Sa),
    .Sb    (Sb),
    .Ra    (Ra), .Ya (Ya), .Ga (Ga),
    .Rb    (Rb), .Yb (Yb), .Gb (Gb)
  );

  // clock generator: 10 ns period
  always #5 clk = ~clk;

  // dump waveforms
  initial begin
    $dumpfile("traffic.vcd");
    $dumpvars(0, tb_traffic_light);
  end

  // stimulus sequence
  initial begin
    // hold reset for 2 cycles
    #12 reset = 0;

    // after 100 ns, press Sa for one cycle
    #100 Sa = 1;
    #10  Sa = 0;

    // after another 200 ns, press Sb
    #200 Sb = 1;
    #10  Sb = 0;

    // finish after some time
    #300 $finish;
  end

  // optional console monitor
  initial begin
    $monitor("%0t | Sa=%b Sb=%b | A[G=%b Y=%b R=%b] B[G=%b Y=%b R=%b]",
             $time, Sa, Sb, Ga, Ya, Ra, Gb, Yb, Rb);
  end

endmodule
