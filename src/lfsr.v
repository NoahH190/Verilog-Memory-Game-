module lfsr(
    input i_clk,
    input i_rst,
    output reg [21:0] o_lfsr_data
);

wire feedback = o_lfsr_data[21] ^ o_lfsr_data[20];

always @(posedge i_clk or posedge i_rst) begin
        if(i_rst) o_lfsr_data[21:0] <= 22'b00001;
        else o_lfsr_data <= {o_lfsr_data[20:0], feedback};
end

endmodule