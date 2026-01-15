module count_and_toggle #(count_limit = 10)
(
    input i_clk,
    input i_enable,
    output reg o_toggle
);

reg [$clog2(count_limit):0] r_counter;

always @(posedge i_clk) begin 
    if(i_enable == 1'b1) begin //if enable is active begin counting
        if(r_counter == count_limit -1) begin   
            o_toggle <= 1'b1;
            r_counter <= 0;
        end
        else r_counter <= r_counter + 1;  //if not at limit keep counting
    end 
    else begin
        o_toggle <= 1'b0;
        r_counter <= 0;
    end 
end 

endmodule 
