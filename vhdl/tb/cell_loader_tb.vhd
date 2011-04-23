library STD;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use work.emorec.all;

entity cell_loader_tb is
end cell_loader_tb;

architecture a of cell_loader_tb is
  signal clock   : std_logic := '0';
  signal reset   : std_logic := '0';
  signal done    : std_logic := '0';
  signal load    : std_logic := '0';
  signal data    : std_logic_vector(63 downto 0);
  signal buffin  : std_logic_vector(15 downto 0);
  signal buffout : std_logic_vector(15 downto 0);
  signal matrix  : matrix_t;
begin

  U_CELL_LOADER : entity work.cell_loader port map (
    clock    =>  clock,
    reset    =>  reset,
    load     =>  load,
    data     =>  data,
    buffin   =>  buffin,
    buffout  =>  buffout,
    matrix   =>  matrix
  ); 

  clock <= not clock after 5 ns when done = '0' else clock;

  process 
    variable l : line;
  begin
   
    report "helo";
    report integer'image(matrix(0)'length);


    reset <= '1';
    wait for 50 ns;
    reset <= '0';
    wait until clock'event and clock = '1';
    wait until clock'event and clock = '1';

    data <= x"1234123412341234";
    buffin <= x"3333";
    load <= '1';
    wait until clock'event and clock = '1';

    write(l, "hello"); 
    writeline(OUTPUT, l);

    --report integer'image(to_integer(unsigned(matrix(0))))
    --  & "\t" & integer'image(to_integer(unsigned(matrix(1))))
    --  & "\t" & integer'image(to_integer(unsigned(matrix(2))))
    --  & "\t" & integer'image(to_integer(unsigned(matrix(3))))
    --  & "\t" & integer'image(to_integer(unsigned(matrix(4))));
     

    done <= '1';
  end process;

end a;
