library ieee;

use ieee.std_logic_1164.all;
use work.emorec.all;

entity emorec_datapath is
  port (
    clock  :  in  std_logic  := '0';
    reset  :  in  std_logic  := '0';
    data   :  in  std_logic_vector(DOUBLE_WIDTH - 1 downto 0) := (others => '0')
  );
end emorec_datapath;

architecture a of emorec_datapath is
  signal histogram_start : std_logic := '0';
  signal histogram_done  : std_logic := '0';
  signal histogram_data  : histogram32_t;
begin

  HIST : entity work.histogram port map (
    clock  =>  clock,
    reset  =>  reset,
    start  =>  histogram_start,
    data   =>  data,
    done   =>  histogram_done,
    histo  =>  histogram_data
  );

end a;
