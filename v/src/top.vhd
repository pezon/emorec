library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
  generic (
    NUM_CELLS  :  integer  :=  3;
  );
  port (
    clock
    reset
    active
  );
end datapath;

architecture a for datapath is
  -- SRAM address and data bus
  signal address : std_logic_vector(ADDRBUS_LENGTH - 1 downto 0);
  signal data    : std_logic_vector(DATABUS_LENGTH - 1 downto 0);
  -- active cell (cell loading data)
  signal cell_select  : std_logic_vector(1 downto 0);
  signal cell_active  : std_logic_vector(NUM_CELLS downto 0);
  -- vertical buffer -- carries from prev cell to next cell
  
begin

  ADDRGEN : entity work.address_generator
    port map (
      clock    => clock,
      reset    => reset,
      address  => address
    );

  SRAM : entity work.ram
    port map (
      clock    => clock,
      reset    => reset,
      address  => address,
      data     => data
    );

  -- cell select
  CYCLER : entity work.cell_cycler
    port map (
      clock   =>  clock,
      reset   =>  reset,
      start   =>  start,
      cycle   =>  cell_select(2 downto 1)
    );

  cell_active(1) <= '1' when cell_select = "01" else '0';
  cell_active(2) <= '1' when cell_select = "10" else '0';
  cell_active(3) <= '1' when cell_select = "11" else '0';
      
  -- cells
  CELL1 : entity work.cell 
    port map (
      clock   =>  clock,
      reset   =>  reset,
      start   =>  cell_active(1),
      u_buff  =>  u_buff,
      l_buff  =>  l_buff,
      r_buff  =>  r_buff,
      d_buff  =>  d_buff,
      data    =>  data,
      col0    =>  col0(0),
      col1    =>  col1(0),
      col2    =>  col2(0)
    );

  CELL2 : entity work.cell 
    port map (
      clock   =>  clock,
      reset   =>  reset,
      start   =>  cell_active(2),
      u_buff  =>  u_buff,
      l_buff  =>  l_buff,
      r_buff  =>  r_buff,
      d_buff  =>  d_buff,
      data    =>  data,
      col0    =>  col0(0),
      col1    =>  col1(0),
      col2    =>  col2(0)
    );

  CELL3 : entity work.cell 
    port map (
      clock   =>  clock,
      reset   =>  reset,
      start   =>  cell_active(3),
      u_buff  =>  u_buff,
      l_buff  =>  l_buff,
      r_buff  =>  r_buff,
      d_buff  =>  d_buff,
      data    =>  data,
      col0    =>  col0(0),
      col1    =>  col1(0),
      col2    =>  col2(0)
    );


  HISTREG : entity work.histogram_register
    port map (
      clock   =>  clock,
      reset   =>  reset,
      value0  =>  feature(0),
      value1  =>  feature(1),
      value2  =>  feature(2)
    ); 

end a;

