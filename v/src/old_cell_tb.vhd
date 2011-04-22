-- Cell test bench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;

entity cell_tb is
end cell_tb; 

architecture tb of cell_tb is 
  signal clock : std_logic := '0';
  signal reset : std_logic := '0';
  signal load  : std_logic := '0';
  signal data  : std_logic_vector(63 downto 0);
  signal sim_done : std_logic := '0';
begin

  UUT : entity work.cell port map (

    clock   =>  clock,
    reset   =>  reset,
    load    =>  load,
    data    =>  data
  );

  clock <= not clock after 5 ns when sim_done = '0' else clock;

  process
  begin

    wait for 20 ns;
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 20 ns;

    report "begin";

    -- need a cycle for state to position correctly
    load <= '1';
    wait until clock'event and clock = '1';

    data <= x"0001020304050607";
    wait until clock'event and clock = '1';

    data <= x"08090a0b0c0d0e0f";
    wait until clock'event and clock = '1';

    data <= x"c1c2c3c4c5c6c7c8";
    wait until clock'event and clock = '1'; 

    data <= x"a1a2a3a4a5a6a7a8";
    wait until clock'event and clock = '1';

    report "end";

    wait for 20 ns;
    sim_done <= '1'; 

  end process;

end tb;
