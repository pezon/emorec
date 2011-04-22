library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cell_controller is
  generic (
  );
  port 
  );
end cell_controller;

architecture a for cell_controller is
is

  CELL_PATH : entity work.cell_datapath is
    port map (
      clock   =>  clock,
      reset   =>  reset,
    );

end a;
