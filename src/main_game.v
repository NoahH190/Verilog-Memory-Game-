module main_game #(
    parameter clk_freq = 25000000,
    parameter game_limit = 6
)(
    input clk,
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    output d1,
    output d2,
    output d3,
    output d4,
    output reg [3:0] o_score
);

reg  [2:0] r_sm_main;
reg  rsw1, rsw2, rsw3, rsw4;
reg  [1:0] r_pattern [0:10];
reg  r_toggle, r_button_dv;
wire [21:0] lfsr_data;
reg  [$clog2(game_limit) - 1:0] r_index;
reg  r_button_id;
wire w_count_en, w_toggle; 

localparam start        = 3'd0;     //bit encoding for the states
localparam pattern_off  = 3'd1;
localparam pattern_show = 3'd2;
localparam wait_player  = 3'd3;
localparam incr_score   = 3'd4;
localparam loser        = 3'd5;
localparam winnner      = 3'd6;

always @(posedge clk) begin
    if(sw1 & sw2) 
        r_sm_main <= start;
    else begin 
        case (r_sm_main)
            start:           //reset cleared -> pattern off
            begin 
                if (!i_switch_1 & !i_switch_2 & r_button_dv) begin 
                    o_score <= 0; 
                    r_index <= 0; 
                    r_sm_main <= pattern_off; 
                end
            end       
            pattern_off:   //timeout -> pattern show, 
            begin
                if (!w_toggle & r_toggle) // falling edge is detected, move onto next state
                    r_sm_main <= pattern_show;  
            end
            pattern_show:  // if pattern completed -> pattern off, else, -> wait player  
            begin 
                if(!w_toggle & r_toggle) begin 
                    if(o_score == r_index) begin 
                        r_index <= 0;
                        r_sm_main <= wait_player; 
                    end 
                    else begin 
                        r_index <= r_index + 1; 
                        r_sm_main <= pattern off; 
                    end 
                end 
            end 
            wait_player:  //incorect pattern -> loser, correct not complete -> wait player, pattern complete -> incr score
            begin
                if(r_button_dv)   //Indicates player has pressed and released a switch 
                    if(r_pattern[r_index] == r_Button _ID && r_index == o_score) begin //Checks if button is corret and we are at the end of the pattern
                            r_index <= 0; 
                            r_sm_main <= o_score; 
                        end 
                    else if (r_pattern[r_index] != r_button_ID) //Checks if button that was pressed is supposed to be pressed
                        r_sm_main <= loser; 
                    else
                        r_index <= r_index + 1; 
            end
            incr_score:  //score not at limit -> pattern off, game over -> winner
            begin
                o_score < o_score  + 1;
                if(o_score == game_limit - 1)
                    if(o_score == game_limit)
                        r_sm_main <= winner;
                    else
                        r_sm_main <= pattern_off;
            end
            loser:
            winner:
        endcase 
    end
end

