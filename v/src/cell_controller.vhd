library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cell is
  generic (
    DATABUS_LENGTH : integer := 64;
    PIXEL_LENGTH   : integer := 8;
    VERT_BUFF      : integer := 5;
    HORZ_BUFF      : integer := 4
  );
  port 
    clock  :  in  std_logic  := '0';
    reset  :  in  std_logic  := '0';
    start  :  in  std_logic  := '0';
    -- input databusses
    u_buff  :  in  std_logic_vector(PIXEL_LENGTH * HORZ_BUFFER - 1 downto 0);
    l_buff  :  in  std_logic_vector(PIXEL_LENGTH * VERT_BUFFER - 1 downto 0);
    data    :  in  std_logic_vector(DATABUS_LENGTH - 1 downto 0);
    -- output databuses     
    r_buff  :  in  std_logic_vector(PIXEL_LENGTH * VERT_BUFFER - 1 downto 0);
    d_buff  :  in  std_logic_vector(PIXEL_LENGTH * HORZ_BUFFER - 1 downto 0);
    col0    :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0);
    col1    :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0);
    col2    :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0)
  );
end cell;

architecture a for cell is
  signal running  :  std_logic  :=  '0'; 
  signal state    :  std_logic_vector(2 downto 0)  :=  (others => '0');
is

  -- start cell
  process (clock, reset) 
  begin
    if reset = '1' then
      running <= '0';
    elsif clock = '1' and clock'event and start = '1' then
      running <= '1'; -- will be running forever...until reset
    end if;
  end process;

  CELL_PATH : entity work.cell_datapath is
    port map (
      clock   =>  clock,
      reset   =>  reset,
      control =>  state,
      u_buff  =>  u_buff,
      l_buff  =>  l_buff,
      r_buff  =>  r_buff,
      d_buff  =>  d_buff,
      data    =>  data,
      col0    =>  col0,
      col1    =>  col1,
      col2    =>  col2
    );
 
  CELL_STATE : entity work.cell_cycler is
    port map(
      clock  =>  clock,
      reset  =>  reset,
      start  =>  running,
      cycle  =>  state
    );

end a;
