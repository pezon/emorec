library ieee;

use ieee.std_logic_1164.all;
use work.emorec.all;

entity histogram_datapath is
  generic (
    data_width : natural := 64);
  port (
    clock     : in  std_logic  := '0';
    reset     : in  std_logic  := '0';
    posx      : in  natural range 0 to ROW_WIDTH - 1 := 0;
    posy      : in  natural range 0 to ROW_WIDTH - 1 := 0;
    load      : in  std_logic  := '0';
    flush     : in  std_logic  := '0';
    compare   : in  std_logic  := '0';
    data      : in  std_logic_vector(data_width - 1 downto 0)  := (others => '0');
    histogram : out histogram32_t);
end histogram_datapath;

architecture a of histogram_datapath is
  signal buffin   :  std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0)  := (others => '0');
  signal buffout  :  std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0)  := (others => '0');
  signal matrix   :  matrix_t;
begin

  U_BUFFER : entity work.cell_buffer port map (
    clock  =>  clock,
    reset  =>  reset,
    load   =>  load,
    addr   =>  posx,
    data   =>  buffout,
    q      =>  buffin
  ); 

  U_LOADER : entity work.cell_loader port map (
    clock   =>  clock,
    reset   =>  reset,
    flush   =>  flush,
    load    =>  load,
    data    =>  data,
    buffin  =>  buffin,
    buffout =>  buffout,
    matrix  =>  matrix
  );

end  a;
