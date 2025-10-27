module debounce_top (
    input  clk,
    input  sw_in,
    output sw_out
);

wire sw_out;

debounce #(
    .debounce_filter(250000) // Adjust the filter value as needed
) debouncer (
    .clk(clk),
    .sw_in(sw_in),
    .sw_out(sw_out)
);

endmodule