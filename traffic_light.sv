`timescale 1ns/1ps

module traffic_light_controller(
    input  wire       clk,    // system clock
    input  wire       reset,  // synchronous reset (active‑high)
    input  wire       Sa,     // pedestrian A “walk” request
    input  wire       Sb,     // pedestrian B “walk” request
    output reg        Ra, Ya, Ga,  // Road A: Red, Yellow, Green
    output reg        Rb, Yb, Gb   // Road B: Red, Yellow, Green
);

    // simple 2‑bit state codes
    localparam [1:0]
        A_GREEN  = 2'b00,  // A = green, B = red
        A_YELLOW = 2'b01,  // A = yellow→red, B = red
        B_GREEN  = 2'b10,  // A = red, B = green
        B_YELLOW = 2'b11;  // A = red, B = yellow→red

    // how long each phase lasts (in clock ticks)
    localparam integer GREEN_MAX  = 100;
    localparam integer YELLOW_MAX =  20;

    reg [1:0] state, next_state;
    integer   timer;

    // 1) State register + timer
    always @(posedge clk) begin
        if (reset) begin
            state <= A_GREEN;
            timer <= 0;
        end else begin
            state <= next_state;
            if (next_state == state)
                timer <= timer + 1;
            else
                timer <= 0;
        end
    end

    // 2) Next‑state logic
    always @(*) begin
        case (state)
            A_GREEN:  next_state = (timer >= GREEN_MAX || Sa) ? A_YELLOW : A_GREEN;
            A_YELLOW: next_state = (timer >= YELLOW_MAX)       ? B_GREEN  : A_YELLOW;
            B_GREEN:  next_state = (timer >= GREEN_MAX || Sb) ? B_YELLOW : B_GREEN;
            B_YELLOW: next_state = (timer >= YELLOW_MAX)       ? A_GREEN  : B_YELLOW;
            default:  next_state = A_GREEN;
        endcase
    end

    // 3) Output logic (one‑hot per road)
    always @(*) begin
        // default: all off
        {Ra,Ya,Ga} = 3'b000;
        {Rb,Yb,Gb} = 3'b000;
        case (state)
            A_GREEN:  {Ra,Ya,Ga,Rb,Yb,Gb} = 6'b0_0_1_1_0_0;
            A_YELLOW: {Ra,Ya,Ga,Rb,Yb,Gb} = 6'b1_1_0_1_0_0;
            B_GREEN:  {Ra,Ya,Ga,Rb,Yb,Gb} = 6'b1_0_0_0_0_1;
            B_YELLOW: {Ra,Ya,Ga,Rb,Yb,Gb} = 6'b1_0_0_1_1_0;
        endcase
    end

endmodule
