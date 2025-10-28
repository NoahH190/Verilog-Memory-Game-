module main_game #(
    parameter clk_freq = 25000000,
    parameter game_limit = 6
)(
    input clk,
    input sw1,
    input sw1,
    input sw1,
    input sw1,
    output d1,
    output d2,
    output d3,
    output d4,
    output reg [3:0] score
);

reg  [2:0] r_sm_main;
reg  rsw1, rsw2, rsw3, rsw4;
reg  [1:0] pattern [0:10];
reg  r_toggle, r_button_dv;
wire [21:0] lfsr_data;
reg  [$clog2(game_limit) - 1:0];
reg  r_button_id;
wire w_count_en, w_toggle;

localparam start        = 3'd0;
localparam pattern_off  = 3'd1;
localparam pattern_show = 3'd2;
localparam wait_player  = 3'd3;
localparam incr_score   = 3'd4;
localparam loser        = 3'd5;
localparam winnner      = 3'd6;



