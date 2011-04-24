library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.emorec.all;

entity chisquare_tb is
end chisquare_tb;

architecture tb of chisquare_tb is
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal sim_done : std_logic := '0';
  signal calc_done : std_logic;
  signal go : std_logic := '0';
  signal observed : histogram8_t;
  signal expected : histogram8_t;
begin

  clk <= not clk after 5 ns when sim_done = '0' else clk;

  process
  begin  
    for i in histogram_length - 1 downto 0 loop
      observed(i) <= std_logic_vector(to_unsigned(157, 8));
      expected(i) <= std_logic_vector(to_unsigned(112, 8));
    end loop;

    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    go <= '1';
    wait until clk'event and clk = '1';
    go <= '0';

    for i in 0 to 40 loop
      wait until clk'event and clk = '1';
    end loop;

    sim_done <= '1';
  end process;


  UUT : entity work.chisquare_datapath
    port map (
      clk => clk,
      rst => rst,
      go => go,
      observed => observed,
      expected => expected,
      done => calc_done,
      statistic => open);
end tb;

