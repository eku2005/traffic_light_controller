`timescale 1ns/1ps  // Fixes the timescale warning

module traffic_light(
    input clk, Sa, Sb,
    output reg Ra, Rb, Ga, Gb, Ya, Yb
);

    reg [1:0] state;

    initial begin
        state = 2'b00;
        Ra = 0; Ga = 1; Ya = 0;
        Rb = 1; Gb = 0; Yb = 0;
    end

    always @(posedge clk) begin
        case (state)
            2'b00: begin // Default State
                Ra = 0; Ga = 1; Ya = 0;
                Rb = 1; Gb = 0; Yb = 0;
                if (Sa) state <= 2'b01;
                else if (Sb) state <= 2'b10;
            end
            2'b01: begin // Pedestrian A crossing
                Ra = 1; Ga = 0; Ya = 1;
                Rb = 1; Gb = 0; Yb = 0;
                state <= 2'b00; // Return to default
            end
            2'b10: begin // Pedestrian B crossing
                Ra = 1; Ga = 0; Ya = 0;
                Rb = 1; Gb = 0; Yb = 1;
                state <= 2'b00;
            end
        endcase
    end

endmodule
