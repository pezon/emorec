library ieee;

use ieee.std_logic_1164.all;
use work.emorec.all;

entity histogram_controller is
  port (
    clock    :  in  std_logic  :=  '0';
    reset    :  in  std_logic  :=  '0';
    start    :  in  std_logic  :=  '0';
    posx     :  out natural range 0 to ROW_WIDTH - 1 := 0;
    posy     :  out natural range 0 to ROW_WIDTH - 1 := 0;
    load     :  out std_logic  :=  '0'; -- start loading cell registers
    flush    :  out std_logic  :=  '0'; -- flush loading cell registers
    compare  :  out std_logic  :=  '0'; -- start creating lbp
    done     :  out std_logic  :=  '0'  -- histogram datapath is done
  );
end histogram_controller;

architecture a of histogram_controller is
  signal position_x : natural range 0 to ROW_WIDTH - 1 := 0;
  signal position_y : natural range 0 to ROW_WIDTH - 1 := 0;
begin
  
  -- index position of cell on the image
  -- set necessary control bits
  process (clock, reset)
  begin
    flush   <= '0';
    load    <= '0';
    compare <= '0';
    done    <= '0';
 
    if reset = '1' then
      flush   <= '1';
      load    <= '0';
      compare <= '0';
      done    <= '0';

      position_x <= 0;
      position_y <= 0;
    elsif clock = '1' and clock'event and start = '1' then
      load    <= '1';
      compare <= '0';

      if position_y > 0 or position_x > 0 then
        compare <= '1'; -- cell rdy to compare a cycle after load
      end if;

      if position_y < ROW_WIDTH - 1 then
        if position_x < ROW_WIDTH - 1 then
          position_x <= position_x + 1;
        else
          flush <= '1';
          position_x <= 0;
          position_y <= position_y + 1;
        end if;
      else
        load    <= '0';
        compare <= '0';
        done    <= '1';
      end if;
    end if;
  end process;

  posx <= position_x;
  posy <= position_y;

end a;
