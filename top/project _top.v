module top(
    input  i_clk,
    input  i_sw1,
    input  i_sw2,
    input  i_sw3,
    input  i_sw4,
    output d1,
    output d2,
    output d3,
    output d4,
    output segment_A,
    output segment_B,
    output segment_C,
    output segment_D,   
    output segment_E,
    output segment_F,
    output segment_G
);

localparam game_limit = 7;
localparam clk_freq = 25000000; // 50 MHz
localparam debounce_filter = 250000; // 0.5 MHz

wire wsw1, wsw2, wsw3, wsw4;
wire w_segment_A, w_segment_B, w_segment_C, w_segment_D, w_segment_E, w_segment_F, w_segment_G;
wire [3:0] score;

debounce #(
    .debounce_filter(debounce_filter)
) debouncer1 (
    .clk(clk),
    .sw_in(sw1),
    .sw_out(wsw1)
);

debounce #(
    .debounce_filter(debounce_filter)
) debouncer2 (
    .clk(clk),
    .sw_in(sw2),
    .sw_out(wsw2)
);

debounce #(
    .debounce_filter(debounce_filter)
) debouncer3 (
    .clk(clk),
    .sw_in(sw3),
    .sw_out(wsw3)
);

debounce #(
    .debounce_filter(debounce_filter)
) debouncer4 (
    .clk(clk),
    .sw_in(sw4),
    .sw_out(wsw4)
);

main_game #(
    .game_limit(game_limit),
    .clk_freq(clk_freq)
) game_inst (
    .i_clk(clk),
    .i_sw1(wsw1),
    .i_sw2(wsw2),
    .i_sw3(wsw3),
    .i_sw4(wsw4),
    .o_led_1(o_led_1),
    .o_led_2(o_led_2),
    .o_led_3(o_led_3),
    .o_led_4(o_led_4),
    .score(score)
);

b2s b2s_inst (
    .clk(clk),
    .binary_in(score),
    .segment_A(w_segment_A),
    .segment_B(w_segment_B),
    .segment_C(w_segment_C),
    .segment_D(w_segment_D),
    .segment_E(w_segment_E),
    .segment_F(w_segment_F),
    .segment_G(w_segment_G)
);

assign segment_A = w_segment_A;
assign segment_B = w_segment_B;     
assign segment_C = w_segment_C;
assign segment_D = w_segment_D;
assign segment_E = w_segment_E;
assign segment_F = w_segment_F;
assign segment_G = w_segment_G;

endmodule
