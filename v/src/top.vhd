library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
  generic (
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
  -- horizontal buffer
  -- vertical buffer
  -- misc
  col0
  col1
  col2
  
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
      
  CELL0 : entity work.cell 
    port map (
      clock   =>  clock,
      reset   =>  reset,
      load0   =>  load0(0),
      load1   =>  load1(0),
      row0    =>  row0(0),
      row1    =>  row1(0),
      row2    =>  row2(0),
      u_buff  =>  u_buff(0),
      l_buff  =>  l_buff(0),
      data    =>  data(0),
      r_buff  =>  r_buff(0),
      d_buff  =>  d_buff,
      col0    =>  col0(0),
      col1    =>  col1(0),
      col2    =>  col2(0)
    );

  CELL1 : entity work.cell 
    port map (
      clock   =>  clock,
      reset   =>  reset,
      load0   =>  load0,
      load1   =>  load1,
      row0    =>  row0,
      row1    =>  row1,
      row2    =>  row2,
      u_buff  =>  u_buff,
      l_buff  =>  l_buff,
      data    =>  data,
      r_buff  =>  r_buff,
      d_buff  =>  d_buff,
      col0    =>  col0(1),
      col1    =>  col1(1),
      col2    =>  col2(1)
    );

   CELL3 : entity work.cell 
    port map (
      clock   =>  clock,
      reset   =>  reset,
      load0   =>  load0,
      load1   =>  load1,
      row0    =>  row0,
      row1    =>  row1,
      row2    =>  row2,
      u_buff  =>  u_buff,
      l_buff  =>  l_buff,
      data    =>  data,
      r_buff  =>  r_buff,
      d_buff  =>  d_buff,
      col0    =>  col0(2),
      col1    =>  col1(2),
      col2    =>  col2(2)
    );

  -- mux to direct output to histogram reg
  feature(0) <= col0(0) when active = "00"
    else col1(0) when active = "01"
    else col2(0) when active = "10";

  feature(1) <= col0(1) when active = "00"
    else col1(1) when active = "01"
    else col2(1) when active = "10";
     
  feature(2) <= col0(2) when active = "00"
    else col1(2) when active = "01"
    else col2(2) when active = "10";
   
  HISTREG : entity work.histogram_register
    port map (
      clock   =>  clock,
      reset   =>  reset,
      value0  =>  feature(0),
      value1  =>  feature(1),
      value2  =>  feature(2)
    ); 

end a;

