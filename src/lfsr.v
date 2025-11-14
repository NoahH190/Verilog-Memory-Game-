module lfsr(
    input i_clk,
    input i_rst,
    output [21:0] o_lfsr_data
)

always @(posedge clk) begin
        if(reset)
            o_lfsr_data[21:0] <= 22'b00001;
        else begin
            o_lfsr_data[0]  <= o_lfsr_data[1];
            o_lfsr_data[1]  <= o_lfsr_data[2];
            o_lfsr_data[2]  <= o_lfsr_data[3];
            o_lfsr_data[3]  <= o_lfsr_data[4];
            o_lfsr_data[4]  <= o_lfsr_data[5];
            o_lfsr_data[5]  <= o_lfsr_data[6];
            o_lfsr_data[6]  <= o_lfsr_data[7];
            o_lfsr_data[7]  <= o_lfsr_data[8];
            o_lfsr_data[8]  <= o_lfsr_data[9];
            o_lfsr_data[9]  <= o_lfsr_data[10];
            o_lfsr_data[10] <= o_lfsr_data[11];
            o_lfsr_data[11] <= o_lfsr_data[12];
            o_lfsr_data[12] <= o_lfsr_data[13];
            o_lfsr_data[13] <= o_lfsr_data[14];
            o_lfsr_data[14] <= o_lfsr_data[15];
            o_lfsr_data[15] <= o_lfsr_data[16];
            o_lfsr_data[16] <= o_lfsr_data[17];
            o_lfsr_data[17] <= o_lfsr_data[18];
            o_lfsr_data[18] <= o_lfsr_data[19];
            o_lfsr_data[19] <= o_lfsr_data[20];
            o_lfsr_data[20] <= o_lfsr_data[21];
            o_lfsr_data[21] <= o_lfsr_data[21] ^ o_lfsr_data[20];  
        end
end

endmodule