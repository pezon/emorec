library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.emorec.all;

entity chisquare_datapath is
  port (
    clk : in std_logic;
    rst : in std_logic;
    go : in std_logic;
    observed : in histogram8_t;
    expected : in histogram8_t;
    done : out std_logic;
    statistic : out statistic_t);
end chisquare_datapath;

architecture behavior of chisquare_datapath is
  type sum_t is array (2 * histogram_length - 2 downto 0) of std_logic_vector(15 downto 0);

  signal difference : histogram8_t;
  signal difference_delay : std_logic;
  signal square : histogram16_t;
  signal square_delay : std_logic;
  signal quotient : histogram16_t;
  signal quotient_delay : std_logic;
  signal sum : sum_t;
  signal sum_delay : std_logic_vector(integer(log2(real(histogram_length))) - 1 downto 0);
begin
  --sum(histogram_length - 1 downto 0)(15 downto 0) <= quotient(histogram_length - 1 downto 0)(15 downto 0);

  process(clk, rst)
  begin
    if rst = '1' then
      statistic <= (others => '0');
    elsif rising_edge(clk) then
      -- Difference
      for i in histogram_length - 1 downto 0 loop
        difference(i) <= std_logic_vector(unsigned(observed(i)) - unsigned(expected(i)));
      end loop;
      difference_delay <= go;

      -- Square
      for i in histogram_length - 1 downto 0 loop
        square(i) <= std_logic_vector(unsigned(difference(i)) * unsigned(difference(i)));
      end loop;
      square_delay <= difference_delay;

      -- Quotient
      for i in histogram_length - 1 downto 0 loop
        quotient(i) <= std_logic_vector(unsigned(square(i)) / unsigned(square(i)));
      end loop;
      quotient_delay <= square_delay;

      -- Sum
      for i in 0 to integer(log2(real(histogram_length))) loop
        for j in 0 to integer(log2(real(histogram_length))) - i - 1 loop
          sum(2 * histogram_length - 2 ** (integer(log2(real(histogram_length))) - i) + j) <= std_logic_vector(unsigned(sum(2 ** i + 2 * j - 1)) + unsigned(sum(2 ** i + 2 * j)));
        end loop;
      end loop;
      sum_delay(0) <= quotient_delay;
      for i in 1 to integer(sum_delay'length) - 1 loop
        sum_delay(i) <= sum_delay(i - 1);
      end loop;
    end if;
  end process;
end behavior;

