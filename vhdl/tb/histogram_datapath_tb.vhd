library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.emorec.all;

entity histogram_datapath_tb is
end histogram_datapath_tb;

architecture a of histogram_datapath_tb is
  signal clock   : std_logic := '0';
  signal reset   : std_logic := '0';
  signal done    : std_logic := '0';
  signal data    : std_logic_vector(63 downto 0);
begin

  U_HIST_DP : entity work.histogram_datapath port map (
    clock   =>   clock,
    reset   =>   reset,
    data    =>   data
  );

  clock <= not clock after 5 ns when done = '0' else clock;

  process 
  begin

    reset <= '1';
    wait for 50 ns;
    reset <= '0';
    wait until clock'event and clock = '1';
    wait until clock'event and clock = '1';

    data <= x"0123456789abcdef";
    wait until clock'event and clock = '1';

    data <= x"1111111111111111";
    wait until clock'event and clock = '1';

    data <= x"2222222222222222";
    wait until clock'event and clock = '1';

    data <= x"3333333333333333";
    wait until clock'event and clock = '1';

    data <= x"4444444444444444";
    wait until clock'event and clock = '1';

    data <= x"5555555555555555";
    wait until clock'event and clock = '1';
 
    data <= x"6666666666666666";
    wait until clock'event and clock = '1';

    data <= x"7777777777777777";
    wait until clock'event and clock = '1';

    data <= x"8888888888888888";
    wait until clock'event and clock = '1';

    done <= '1';
  end process;

end a;
