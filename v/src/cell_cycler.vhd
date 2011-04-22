-- Cell Cycler
-- Dual purpose: can determine cell state, can determine active cell select
-- Determines which cell is loading data
-- I.E.: 
-- Cell State Flow is:
-- Load1  01 0  --  Cell 1 
-- Load2  01 1  --  Cell 1
-- Calc1  10 0  --  Cell 2
-- Calc2  10 1  --  Cell 2
-- Calc3  11 0  --  Cell 3
-- Wait   11 1  --  Cell 3
-- 'Active Cell' is cell that is loading,
-- determined by upper 2 bits of counter

 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cell_cycler is
  generic (
    START_COUNTER : integer := 2;
    MAX_COUNTER   : integer := 7
  );
  port (
    clock  :  in  std_logic  := '0';
    reset  :  in  std_logic  := '0';
    start  :  in  std_logic  := '0';
    cycle  :  out std_logic_vector(2 downto 0)
  );
end cell_cycler;

architecture a of cell_cycler is
  signal counter :  integer  := START_COUNTER;
begin
  process (clock, reset, start)
  begin
    if reset = '1' the
      counter <= START_COUNTER;
    if clock = '1' and clock'event and start = '1' then
      if counter >= MAX_COUNTER - 1 then
        counter <= START_COUNTER;
      else
        counter <= counter + 1;
      end if;
    end if;
  end process;
  cycle  <= std_logic_vector(to_unsigned(counter, cycle'length));
end a;
