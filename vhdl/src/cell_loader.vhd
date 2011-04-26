-- Emorec
-- Cell Loader
-- Loads cell with incoming data. 

-- streaming data must be in format:
-- 00 01 02      00 01 08 09
-- 10 11 12  =>  02 03 10 11
-- 20 21 22  =>  04 05 12 13
-- 30 31 32      06 07 14 15

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.emorec.all;

entity cell_loader is
  generic (
    DOUBLE_WIDTH  :  natural  := 64
  );
  port (
    clock   :  in  std_logic  :=  '0';
    reset   :  in  std_logic  :=  '0'; 
    flush   :  in  std_logic  :=  '0';
    load    :  in  std_logic  :=  '0';
    data    :  in  std_logic_vector(DOUBLE_WIDTH - 1 downto 0)     :=  (others => '0');
    buffin  :  in  std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0)  :=  (others => '0');
    buffout :  out std_logic_vector(PIXEL_WIDTH * 2 - 1 downto 0)  :=  (others => '0');
    matrix  :  out matrix_t
  );
end cell_loader;

architecture a of cell_loader is 
  type rows_t is array(natural range 0 to CELL_HEIGHT - 1) of std_logic_vector(PIXEL_WIDTH * CELL_WIDTH - 1 downto 0);
  signal rows : rows_t;
  signal edge : std_logic_vector(PIXEL_WIDTH * CELL_WIDTH - 1 downto 0);
begin

  process (clock, reset)
  begin
    if reset = '1' then
      edge <= (others => '0');
      rows(1) <= (others => '0');
      rows(2) <= (others => '0');
      rows(3) <= (others => '0');
      rows(4) <= (others => '0');
    -- on load, data is shifted two cells to the left.
    elsif clock = '1' and clock'event and load = '1' then
      if flush = '1' then 
        -- flush out existing data from registers,
        -- specifically when indexing a new row.
        edge <= (others => '0');
        rows(1) <= (others => '0');
        rows(2) <= (others => '0');
        rows(3) <= (others => '0');
        rows(4) <= (others => '0');
      end if;
      -- data from buffer register
      edge <= std_logic_vector(shift_left(unsigned(edge), PIXEL_WIDTH * 2));  
      edge(PIXEL_WIDTH * 2 - 1 downto 0) <= buffin(PIXEL_WIDTH * 2 - 1 downto 0);
      -- streaming data
      rows(1) <= std_logic_vector(shift_left(unsigned(rows(1)), PIXEL_WIDTH * 2));  
      rows(1)(PIXEL_WIDTH * 2 - 1 downto 0) <= data(PIXEL_WIDTH * 8 - 1 downto PIXEL_WIDTH * 6);
      rows(2) <= std_logic_vector(shift_left(unsigned(rows(2)), PIXEL_WIDTH * 2));  
      rows(2)(PIXEL_WIDTH * 2 - 1 downto 0) <= data(PIXEL_WIDTH * 6 - 1 downto PIXEL_WIDTH * 4);
      rows(3) <= std_logic_vector(shift_left(unsigned(rows(3)), PIXEL_WIDTH * 2));  
      rows(3)(PIXEL_WIDTH * 2 - 1 downto 0) <= data(PIXEL_WIDTH * 4 - 1 downto PIXEL_WIDTH * 2);
      rows(4) <= std_logic_vector(shift_left(unsigned(rows(4)), PIXEL_WIDTH * 2));  
      rows(4)(PIXEL_WIDTH * 2 - 1 downto 0) <= data(PIXEL_WIDTH * 2 - 1 downto PIXEL_WIDTH * 0);
    end if;
  end process;

  row(0) <= edge(PIXEL_WIDTH * 4 - 1 downto PIXEL_WIDTH * 2) & buffin(PIXEL_WIDTH * 2 - 1 downto 0);
  
 
  -- output scheme -- assemble row registers into an array
  --  00  01  02  03   
  --  04  05  06  07
  --  08  09  10  11
  --  12  13  14  15
  --  16  17  18  19 


  matrix(0)  <= rows(0)(PIXEL_WIDTH * 4 - 1 downto PIXEL_WIDTH * 3);
  matrix(1)  <= rows(0)(PIXEL_WIDTH * 3 - 1 downto PIXEL_WIDTH * 2);
  matrix(2)  <= rows(0)(PIXEL_WIDTH * 2 - 1 downto PIXEL_WIDTH * 1);
  matrix(3)  <= rows(0)(PIXEL_WIDTH * 1 - 1 downto PIXEL_WIDTH * 0);

  matrix(4)  <= rows(1)(PIXEL_WIDTH * 4 - 1 downto PIXEL_WIDTH * 3);
  matrix(5)  <= rows(1)(PIXEL_WIDTH * 3 - 1 downto PIXEL_WIDTH * 2);
  matrix(6)  <= rows(1)(PIXEL_WIDTH * 2 - 1 downto PIXEL_WIDTH * 1);
  matrix(7)  <= rows(1)(PIXEL_WIDTH * 1 - 1 downto PIXEL_WIDTH * 0);
 
  matrix(8)  <= rows(2)(PIXEL_WIDTH * 4 - 1 downto PIXEL_WIDTH * 3);
  matrix(9)  <= rows(2)(PIXEL_WIDTH * 3 - 1 downto PIXEL_WIDTH * 2);
  matrix(10) <= rows(2)(PIXEL_WIDTH * 2 - 1 downto PIXEL_WIDTH * 1);
  matrix(11) <= rows(2)(PIXEL_WIDTH * 1 - 1 downto PIXEL_WIDTH * 0);

  matrix(12) <= rows(3)(PIXEL_WIDTH * 4 - 1 downto PIXEL_WIDTH * 3);
  matrix(13) <= rows(3)(PIXEL_WIDTH * 3 - 1 downto PIXEL_WIDTH * 2);
  matrix(14) <= rows(3)(PIXEL_WIDTH * 2 - 1 downto PIXEL_WIDTH * 1);
  matrix(15) <= rows(3)(PIXEL_WIDTH * 1 - 1 downto PIXEL_WIDTH * 0);

  matrix(16) <= rows(4)(PIXEL_WIDTH * 4 - 1 downto PIXEL_WIDTH * 3);
  matrix(17) <= rows(4)(PIXEL_WIDTH * 3 - 1 downto PIXEL_WIDTH * 2);
  matrix(18) <= rows(4)(PIXEL_WIDTH * 2 - 1 downto PIXEL_WIDTH * 1);
  matrix(19) <= rows(4)(PIXEL_WIDTH * 1 - 1 downto PIXEL_WIDTH * 0);
 
  buffout    <= rows(4)(PIXEL_WIDTH * 2 - 1 downto PIXEL_WIDTH * 0);

end a;
