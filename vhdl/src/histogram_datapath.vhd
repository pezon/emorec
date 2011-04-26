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
  signal row0     :  std_logic_vector(PIXEL_WIDTH * CELL_WIDTH - 1 downto 0)  := (others => '0');
  signal row1     :  std_logic_vector(PIXEL_WIDTH * CELL_WIDTH - 1 downto 0)  := (others => '0');
  signal row2     :  std_logic_vector(PIXEL_WIDTH * CELL_WIDTH - 1 downto 0)  := (others => '0');
  signal row3     :  std_logic_vector(PIXEL_WIDTH * CELL_WIDTH - 1 downto 0)  := (others => '0');
  signal row4     :  std_logic_vector(PIXEL_WIDTH * CELL_WIDTH - 1 downto 0)  := (others => '0');
  signal lbp0     : lbp_t;
  signal lbp1     : lbp_t;
  signal lbp2     : lbp_t;
  signal lbp3     : lbp_t;
  signal lbp4     : lbp_t;
  signal lbp5     : lbp_t;
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

  row0 <= matrix(0) & matrix(1) & matrix(2) & matrix(3);
  row1 <= matrix(4) & matrix(5) & matrix(6) & matrix(7);
  row2 <= matrix(8) & matrix(9) & matrix(10) & matrix(11);
  row3 <= matrix(12) & matrix(13) & matrix(14) & matrix(15);
  row4 <= matrix(16) & matrix(17) & matrix(18) & matrix(19);

  U_COMPARE : entity work.PixelCmp port map (
    Row0  =>  row0,
    Row1  =>  row1,
    Row2  =>  row2,
    Row3  =>  row3,
    Row4  =>  row4,
    LBP0  =>  lbp0,
    LBP1  =>  lbp1,
    LBP2  =>  lbp2,
    LBP3  =>  lbp3,
    LBP4  =>  lbp4,
    LBP5  =>  lbp5
  );

  



end  a;
