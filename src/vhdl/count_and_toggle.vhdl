entity count_and_toggle is
  port (
    i_clk    : in std_logic;
    i_enable : in std_logic;
    o_toggle : out std_logic
  );
end count_and_toggle;

architecture Behavioral of count_and_toggle is
begin
  process (i_clk) is
  begin
    if (i_enable = '1') then
      if (r_counter = count_limit - 1) then
        o_toggle  <= '1';
        r_counter <= 0;
      else
        r_counter <= r_counter + 1;
      end if;
    else
      o_toggle  <= '0';
      r_counter <= 0;
    end if;
  end process;
end Behavioral;