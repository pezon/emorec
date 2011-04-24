library ieee;

use ieee.std_logic_1164.all;
use work.emorec.all;

entity histogram_datapath is
  generic (
    data_width : natural := 64);
  port (
    clock     : in  std_logic  := '0';
    reset     : in  std_logic  := '0';
    data      : in  std_logic_vector(data_width - 1 downto 0)  := (others => '0');
    histogram : out histogram32_t);
end histogram_datapath;

architecture a of histogram_datapath is
  signal flush    :  std_logic  := '0';
  signal buffin   :  std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0)  := (others => '0');
  signal buffout  :  std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0)  := (others => '0');
  signal matrix   :  matrix_t;
  signal position :  integer range 0 to ROW_WIDTH - 1 := 0; 
begin

  -- index position of cell on the image
  process (clock, reset) 
  begin
    flush <= '0';
    if reset = '1' then
      position <= 0;
    elsif clock = '1' and clock'event then
      position <= position + 1;
      if position >= ROW_WIDTH then
        position <= 0;
        flush <= '1';
      end if;
    end if;
  end process;

  BUFF : entity work.cell_buffer port map (
    clock  =>  clock,
    reset  =>  reset,
    load   =>  '1',
    addr   =>  position,
    data   =>  buffout,
    q      =>  buffin
  ); 

  LOAD : entity work.cell_loader port map (
    clock   =>  clock,
    reset   =>  reset,
    flush   =>  flush,
    load    =>  '1',
    data    =>  data,
    buffin  =>  buffin,
    buffout =>  buffout,
    matrix  =>  matrix
  );

end a;
