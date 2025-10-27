module binary_to_seven_segment (
    input   clk,
    input   [3:0] binary_in,
    output  segment_A;
    output  segment_B,
    output  segment_C,
    output  segment_D,
    output  segment_E,
    output  segment_F,
    output  segment_G
);

    reg  [6:0] seg_out;

    always @(posedge clk) begin
        case (binary_in)
            4'b0000: seg_out = 7'b1111110; // 0
            4'b0001: seg_out = 7'b0110000; // 1
            4'b0010: seg_out = 7'b1101101; // 2
            4'b0011: seg_out = 7'b1111001; // 3
            4'b0100: seg_out = 7'b0110011; // 4
            4'b0101: seg_out = 7'b1011011; // 5
            4'b0110: seg_out = 7'b1011111; // 6
            4'b0111: seg_out = 7'b1110000; // 7
            4'b1000: seg_out = 7'b1111111; // 8
            4'b1001: seg_out = 7'b1111011; // 9
            4'b1010: seg_out = 7'b1110111; // A
            4'b1011: seg_out = 7'b0011111; // B
            4'b1100: seg_out = 7'b1001110; // C
            4'b1101: seg_out = 7'b0111101; // D
            4'b1110: seg_out = 7'b1001111; // E
            4'b1111: seg_out = 7'b1000111; // F
            default: seg_out = 7'b0000000; // Blank
        endcase
    end

    assign segment_A = seg_out[6];
    assign segment_B = seg_out[5]; 
    assign segment_C = seg_out[4];
    assign segment_D = seg_out[3];
    assign segment_E = seg_out[2];
    assign segment_F = seg_out[1];
    assign segment_G = seg_out[0];
    
endmodule