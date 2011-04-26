library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.emorec.all;

entity histogram_register_tb is
end histogram_register_tb;

architecture a of histogram_register_tb is
  signal clock : std_logic := '0';
  signal reset : std_logic := '0';
  signal sim_done : std_logic := '0';
  signal lbp0 : lbp_t;
  signal lbp1 : lbp_t;
  signal lbp2 : lbp_t;
  signal lbp3 : lbp_t;
  signal lbp4 : lbp_t;
  signal lbp5 : lbp_t;
begin

  U_HIST_REG : entity work.histogram_register port map (
    clock => clock,
    reset => reset,
    lbp0  => lbp0,
    lbp1  => lbp1,
    lbp2  => lbp2,
    lbp3  => lbp3,
    lbp4  => lbp4,
    lbp5  => lbp5
  );

  clock <= not clock after 5 ns when sim_done = '0' else clock;

  process 
  begin
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait until clock = '1' and clock'event;
    wait until clock = '1' and clock'event;

    lbp0 <= x"03";
    lbp1 <= x"04";
    lbp2 <= x"05";
    lbp3 <= x"03";
    lbp4 <= x"04";
    lbp5 <= x"03"; 

    wait until clock = '1' and clock'event;
    wait until clock = '1' and clock'event;
    wait until clock = '1' and clock'event;
    
    sim_done <= '1';
  end process;

end a;
