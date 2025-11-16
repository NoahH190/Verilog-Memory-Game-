module debounce_top (
    input  i_clk,
    input  sw_in,
    output sw_out
);

debounce #(
    .debounce_filter(250000) // Adjust the filter value as needed
) debouncer (
    .i_clk(i_clk),
    .sw_in(sw_in),
    .sw_out(sw_out)
);

endmodule