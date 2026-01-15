entity main_game is
  generic (
    clk_freq   : integer := 25000000;
    game_limit : integer := 6
  );
  port (
    i_clk   : in std_logic;
    i_sw1   : in std_logic;
    i_sw2   : in std_logic;
    i_sw3   : in std_logic;
    i_sw4   : in std_logic;
    o_led_1 : out std_logic;
    o_led_2 : out std_logic;
    o_led_3 : out std_logic;
    o_led_4 : out std_logic;
    o_score : out std_logic_vector(3 downto 0)
  );
end main_game;

architecture Behavioral of main_game is

  signal r_sm_main                  : std_logic_vector(2 downto 0);
  signal r_sw1, r_sw2, r_sw3, r_sw4 : std_logic;
  signal r_pattern                  : std_logic_vector(21 downto 0);
  signal r_toggle, r_button_dv      : std_logic;
  signal lfsr_data                  : std_logic_vector(21 downto 0);
  signal r_index                    : integer range 0 to game_limit - 1;
  signal r_button_id                : std_logic_vector(1 downto 0);
  signal w_count_en, w_toggle       : std_logic;

  constant start        : std_logic_vector(2 downto 0) := "000";
  constant pattern_off  : std_logic_vector(2 downto 0) := "001";
  constant pattern_show : std_logic_vector(2 downto 0) := "010";
  constant wait_player  : std_logic_vector(2 downto 0) := "011";
  constant incr_score   : std_logic_vector(2 downto 0) := "100";
  constant loser        : std_logic_vector(2 downto 0) := "101";
  constant winner       : std_logic_vector(2 downto 0) := "110";

begin

  process (i_clk) is
  begin
    if rising_edge(i_clk) then
      if (i_sw1 = '1' and i_sw2 = '1') then
        r_sm_main <= start;
      else
        case (r_sm_main) is

          when start =>
            if (i_sw1 = '0' and i_sw2 = '0' and r_button_dv = '1') then
              o_score   <= "0000";
              r_index   <= 0;
              r_sm_main <= pattern_off;
            end if;

          when pattern_off =>
            if (w_toggle = '0' and r_toggle = '1') then
              r_sm_main <= pattern_show;
            end if;

          when pattern_show =>
            if (w_toggle = '0' and r_toggle = '1') then
              if (unsigned(o_score) = r_index) then
                r_index   <= 0;
                r_sm_main <= wait_player;
              else
                r_index   <= r_index + 1;
                r_sm_main <= pattern_off;
              end if;
            end if;

          when wait_player =>
            if (r_button_dv = '1') then
              if (r_pattern(r_index) = r_button_id and r_index = unsigned(o_score)) then
                r_index   <= 0;
                r_sm_main <= incr_score;
              elsif (r_pattern(r_index) /= r_button_id) then
                r_sm_main <= loser;
              else
                r_index <= r_index + 1;
              end if;
            end if;

          when incr_score =>
            o_score <= std_logic_vector(unsigned(o_score) + 1);
            if (unsigned(o_score) = game_limit - 1) then
              r_sm_main <= winner;
            else
              r_sm_main <= pattern_off;
            end if;
          when loser =>
            o_score <= "1111";

          when winner =>
            o_score <= "1111";

          when others =>
            r_sm_main <= start;

        end case;
      end if;
    end if;
  end process;

  process (i_clk) is
  begin
    if rising_edge(i_clk) then
      if (r_sm_main == start) then
        r_pattern(0)  <= lfsr_data(1 downto 0);
        r_pattern(1)  <= lfsr_data(3 downto 2);
        r_pattern(2)  <= lfsr_data(5 downto 4);
        r_pattern(3)  <= lfsr_data(7 downto 6);
        r_pattern(4)  <= lfsr_data(9 downto 8);
        r_pattern(5)  <= lfsr_data(11 downto 10);
        r_pattern(6)  <= lfsr_data(13 downto 12);
        r_pattern(7)  <= lfsr_data(15 downto 14);
        r_pattern(8)  <= lfsr_data(17 downto 16);
        r_pattern(9)  <= lfsr_data(19 downto 18);
        r_pattern(10) <= lfsr_data(21 downto 20);
      end if;
    end if;
  end process;
  o_led_1 <= '1' when (r_sm_main = pattern_show and r_pattern(r_index) = "00") else
    i_sw1;
  o_led_2 <= '1' when (r_sm_main = pattern_show and r_pattern(r_index) = "01") else
    i_sw2;
  o_led_3 <= '1' when (r_sm_main = pattern_show and r_pattern(r_index) = "10") else
    i_sw3;
  o_led_4 <= '1' when (r_sm_main = pattern_show and r_pattern(r_index) = "11") else
    i_sw4;

  process (i_clk) is
  begin
    r_toggle <= w_toggle;
    r_sw1    <= i_sw1;
    r_sw2    <= i_sw2;
    r_sw3    <= i_sw3;
    r_sw4    <= i_sw4;

    if (r_sw1 and not i_sw1) then
      r_button_dv <= '1';
      r_button_id <= "00";
    elsif (r_sw2 and not i_sw2) then
      r_button_dv <= '1';
      r_button_id <= "01";
    elsif (r_sw3 and not i_sw3) then
      r_button_dv <= '1';
      r_button_id <= "10";
    elsif (r_sw4 and not i_sw4) then
      r_button_dv <= '1';
      r_button_id <= "11";
    else
      r_button_dv <= '0';
      r_button_id <= "00";
    end if;
  end process;

  w_count_en <= (r_sm_main = pattern_show or r_sm_main = pattern_off);

  count_and_toggle_inst : entity work.count_and_toggle
    generic map(
      count_limit => clk_freq / 4
    )
    port map
    (
      i_clk    => i_clk,
      i_enable => w_count_en,
      o_toggle => w_toggle
    );

  lsfr_inst : entity work.lfsr
    port map
    (
      i_clk       => i_clk,
      i_rst       => '0',
      o_lfsr_data => lfsr_data
    );

end Behavioral;
