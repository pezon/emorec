library ieee;

use ieee.std_logic_1164.all;
use work.emorec.all;

entity histogram is
  port (
    clock  :  in  std_logic  := '0';
    reset  :  in  std_logic  := '0';
    start  :  in  std_logic  := '0';
    data   :  in  std_logic_vector(DOUBLE_WIDTH - 1 downto 0) := (others => '0');
    done   :  out std_logic  := '0';
    histo  :  out histogram32_t
  );
end histogram;

architecture a of histogram is
  signal posx    :  natural range 0 to ROW_WIDTH - 1 := 0;
  signal posy    :  natural range 0 to ROW_WIDTH - 1 := 0;
  signal load    :  std_logic := '0';
  signal flush   :  std_logic := '0';
  signal compare :  std_logic := '0';
begin

  DP : entity work.histogram_datapath port map (
    clock      =>  clock,
    reset      =>  reset,
    posx       =>  posx,
    posy       =>  posy,
    load       =>  load,
    flush      =>  flush,
    compare    =>  compare,
    data       =>  data,
    histogram  =>  histo
  );

  CTRL : entity work.histogram_cotnroller port map (
    clock      =>  clock,
    reset      =>  start,
    posx       =>  posx,
    posy       =>  posy,
    load       =>  load,
    flush      =>  flush,
    compare    =>  compare,
    done       =>  done
  );

end a;

