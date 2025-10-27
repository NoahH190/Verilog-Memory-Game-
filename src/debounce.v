module debounce #(
    parameter debounce_filter = 250000 // Default filter value
) (
    input  clk,
    input  sw_in,
    output reg sw_out
);

reg[$clog2(debounce_filter)-1:0] counter;
reg r_state = 1'b0;
always @(posedge clk) begin
    if (sw_in !== r_state && counter < debounce_filter - 1) begin
        counter <= counter + 1;
    end else if (counter == debounce_filter - 1) begin
        r_state <= sw_in;
        counter <= 0;
    end else begin
        counter <= 0;
    end
end

assign sw_out = r_state;

endmodule