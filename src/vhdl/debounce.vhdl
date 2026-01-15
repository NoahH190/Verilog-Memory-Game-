entity debounce is
  port (
    i_clk : in std_logic;
    i_sw  : in std_logic;
    o_sw  : out std_logic
  );
end debounce;

architecture Behavioral of debounce is
begin
  process (i_clk) is
  begin
    if (i_sw = '1') then
      o_sw <= '1';
    else
      o_sw <= '0';
    end if;
  end process;
end Behavioral;