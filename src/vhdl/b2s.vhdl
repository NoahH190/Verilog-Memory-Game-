entity b2s is
  port (
    i_clk     : in std_logic;
    binary_in : in std_logic_vector(3 downto 0);
    segment_A : out std_logic;
    segment_B : out std_logic;
    segment_C : out std_logic;
    segment_D : out std_logic;
    segment_E : out std_logic;
    segment_F : out std_logic;
    segment_G : out std_logic;
  );
end b2s;

architecture Behavioral of b2s is
begin
  process (i_clk) is
  begin
    case binary_in is
      when "0000" => segment_A <= '0';
      when "0001" => segment_A <= '1';
      when "0010" => segment_A <= '2';
      when "0011" => segment_A <= '3';
      when "0100" => segment_A <= '4';
      when "0101" => segment_A <= '5';
      when "0110" => segment_A <= '6';
      when "0111" => segment_A <= '7';
      when "1000" => segment_A <= '8';
      when "1001" => segment_A <= '9';
      when "1010" => segment_A <= 'A';
      when "1011" => segment_A <= 'B';
      when "1100" => segment_A <= 'C';
      when "1101" => segment_A <= 'D';
      when "1110" => segment_A <= 'E';
      when "1111" => segment_A <= 'F';
      when others => segment_A <= '0';
    end case;
  end process;
end Behavioral;