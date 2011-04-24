library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;
use work.emorec.all;

entity cell_buffer is
  port (
    clock  :  in  std_logic  := '0';
    reset  :  in  std_logic  := '0';
    load   :  in  std_logic  := '0';
    addr   :  in  integer range 0 to ROW_WIDTH - 1;
    data   :  in  std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0) := (others => '0');
    q      :  out std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0) := (others => '0') 
  );
end cell_buffer;

architecture a of cell_buffer is
  type memory_t is array(integer range 0 to ROW_WIDTH - 1) of std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0);
  signal memory : memory_t;
begin

  process (clock, reset)
  begin
    if clock = '1' and clock'event and load = '1' then
      memory(addr) <= data;
    end if;
  end process; 

  q <= memory(addr); 

end a;
