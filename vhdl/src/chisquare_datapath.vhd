library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.emorec.all;

entity chisquare_datapath is
  port (
    clk : in std_logic;
    rst : in std_logic;
    observed : in histogram8_t;
    eigenface : in histogram8_t;
    percentile : out percentile_t);
end chisquare_datapath;

architecture behavior of chisquare_datapath is
  signal difference : histogram8_t;
  signal square : histogram16_t;
begin
  process(clk, rst)
  begin
    if rst = '1' then
      percentile <= (others => '0');
    elsif rising_edge(clk) then
      for i in histogram_length - 1 downto 0 loop
        difference(i) <= std_logic_vector(unsigned(observed(i)) - unsigned(eigenface(i)));
      end loop;
      for i in histogram_length - 1 downto 0 loop
        square(i) <= std_logic_vector(unsigned(difference(i)) * unsigned(difference(i)));
      end loop;
    end if;
  end process;
end behavior;

