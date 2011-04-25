library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.emorec.all;

entity divide_tb is
end divide_tb;

architecture tb of divide_tb is
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal sim_done : std_logic := '0';
  signal dividend : unsigned(7 downto 0);
  signal divisor : unsigned(7 downto 0);
  signal quotient : unsigned(7 downto 0);
begin

  clk <= not clk after 5 ns when sim_done = '0' else clk;

  process
  begin  
    rst <= '1';
    wait until clk'event and clk = '1';
    rst <= '0';

    dividend <= to_unsigned(2, 8);
    divisor <= to_unsigned(1, 8);
    wait until clk'event and clk = '1';
    quotient <= divide(dividend, divisor);

    dividend <= to_unsigned(8, 8);
    divisor <= to_unsigned(3, 8);
    wait until clk'event and clk = '1';
    quotient <= divide(dividend, divisor);

    dividend <= to_unsigned(80, 8);
    divisor <= to_unsigned(3, 8);
    wait until clk'event and clk = '1';
    quotient <= divide(dividend, divisor);

    dividend <= to_unsigned(227, 8);
    divisor <= to_unsigned(38, 8);
    wait until clk'event and clk = '1';
    quotient <= divide(dividend, divisor);

    dividend <= to_unsigned(84, 8);
    divisor <= to_unsigned(41, 8);
    wait until clk'event and clk = '1';
    quotient <= divide(dividend, divisor);

    --dividend <= to_unsigned(84, 8);
    ---divisor <= to_unsigned(41, 8);
    ---quotient <= divide(dividend, divisor);
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';

    sim_done <= '1';
  end process;
end tb;

