entity lfsr is
  port (
    i_clk       : in std_logic;
    i_rst       : in std_logic;
    o_lfsr_data : out std_logic_vector(21 downto 0)
  );
end lfsr;

architecture Behavioral of lfsr is
  signal feedback : std_logic;
begin
  process (i_clk) is
  begin
    if (i_rst) o_lfsr_data <= 22'b00001;
    else
      o_lfsr_data <= {o_lfsr_data(20 : 0), feedback};
    end process;
  end Behavioral;
