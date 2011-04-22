-- Cell 
-- Holds pixel data
-- Currently assuming 8 x 8 cell. LOADING state would need to be adjusted to support different dimensions.
-- this is n + 1 x n + 1 matrix. extra padding holds context of previous adjacent cells for LBPs
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cell is
  generic (
    PIXEL_WIDTH  : integer                                    := 8;
    DOUBLE_WIDTH : integer                                    := 64;
    CELL_HEIGHT  : integer                                    := 8;
    CELL_WIDTH   : integer                                    := 8;
    LBP_WIDTH    : integer                                    := 8
  );
  port (
    clock  : in  std_logic                                    := '0';
    reset  : in  std_logic                                    := '0';
    -- init start cell state (loads buffers)
    start  : in  std_logic                                    := '0';
    -- init load cell state
    load   : in  std_logic                                    := '0';
    -- init calculate lbp state 
    calc   : in  std_logic                                    := '0';
    data   : in  std_logic_vector(DOUBLE_WIDTH - 1 downto 0)  := (others => '0');
    -- status bit
    ready  : out std_logic                                    := '0';
    histo  : out std_logic_vector(LBP_WIDTH - 1 downto 0)     := (others => '0');
    -- dn_edge is transfered to vertically adjacent cell's up_edge, for lbp context 
    up_edge : in  std_logic_vector(DOUBLE_WIDTH - 1 downto 0) := (others => '0');
    dn_edge : out std_logic_vector(DOUBLE_WIDTH - 1 downto 0) := (others => '0');
    -- rt_edge is transfered to horizontaly adjacent cell's lf_edge, for lbp context
    lf_edge : in  std_logic_vector(DOUBLE_WIDTH - 1 downto 0) := (others => '0');
    rt_edge : out std_logic_vector(DOUBLE_WIDTH - 1 downto 0) := (others => '0')
  );
end cell;

architecture a of cell is
  subtype pixel is std_logic_vector(PIXEL_WIDTH - 1 downto 0);
  type matrix is array(integer range 0 to CELL_HEIGHT, integer range 0 to CELL_WIDTH) of pixel;
  signal pixels : matrix;
  type fvector is array(integer range 0 to (CELL_HEIGHT - 2) * (CELL_WIDTH - 2)) of pixel;
  signal feature : fvector;
  type hvector is array(integer range 0 to 256) of integer;
  signal histogram : hvector;

  -- state variables
  type STATE_TYPE is (INIT, LOADING, LOADING2, CALCULATING, DONE);
  signal CS, NS : STATE_TYPE;

  signal dn_edge_reg : std_logic_vector(DOUBLE_WIDTH - 1 downto 0);
  signal rt_edge_reg : std_logic_vector(DOUBLE_WIDTH - 1 downto 0);

begin

  -- finite state logic
  process (clock, start, load, calc)
 
    -- variables used for LOADING, CALCULATING states.
    variable feature : integer := 0; 
    variable counter : integer := 0;
 
  begin
    -- start: initialize cell variables, load edge buffers
    if start = '1' then
      report "STATE: init"; 
      counter := 0;
      -- load left context
      for n in CELL_HEIGHT - 1 downto 0 loop
        pixels(0, CELL_HEIGHT - n) <= lf_edge((n + 1) * 8 - 1 downto n * 8); 
      end loop;
      -- load top context
      for n in CELL_WIDTH - 1 downto 0 loop
        pixels(CELL_WIDTH - n, 0) <= up_edge((n + 1) * 8 - 1 downto n * 8);
      end loop;
      ready <= '1';
 
    -- load: load cell with pipeline data
    elsif load = '1' then
      report "STATE: loading. column = " & integer'image(counter);
      -- assuming 8 x 8 pixel cell, there will be 4 loading states, held by column.
      -- load pixels(col)(n) = data(n), pixels(col+1)(n) = data(n+8), col += 2
      for n in CELL_HEIGHT - 1 downto 0 loop
        report "matrix col = " & integer'image(counter) & " row = " & integer'image(CELL_HEIGHT - n) & " => data "  
          & integer'image((n + 1) * PIXEL_WIDTH - 1) & " downto " & integer'image(n * PIXEL_WIDTH)
          & " = " & integer'image(to_integer(unsigned(data((n + 1) * PIXEL_WIDTH - 1 downto n * 8)))); 
        pixels(counter, CELL_HEIGHT - n) <= data((n + 1) * PIXEL_WIDTH - 1 downto n * PIXEL_WIDTH);
        --report integer'image((n + 1) * 8 - 1 + 32) & " downto " & integer'image(n * 8 + 32);
        --pixels(column + 1, n) <= data((n) *  8 - 1 + 32 downto (n - 1) * 8 + 32);
      end loop;
      -- load edge registers
      report "dn_edge_reg " & integer'image(counter * PIXEL_WIDTH - 1) & " downto " & integer'image((counter - 1) * PIXEL_WIDTH) & " = "
        & integer'image(CELL_HEIGHT * PIXEL_WIDTH - 1) & " downto " & integer'image((CELL_HEIGHT - 1) * PIXEL_WIDTH);
      -- @TODO: dn_edge_reg assignment might need to be reversed? 
      dn_edge_reg(counter * PIXEL_WIDTH - 1 downto (counter - 1) * PIXEL_WIDTH) <= data(CELL_HEIGHT * PIXEL_WIDTH - 1 downto (CELL_HEIGHT - 1) * PIXEL_WIDTH);
      if counter >= CELL_WIDTH then
        rt_edge_reg <= data;
      end if;
      -- if col > CELL_WIDTH, go to next state
      counter := coutner + 1;
      report "column = " & integer'image(counter) & " >= CELL_WIDTH " & integer'image(CELL_WIDTH);
      if counter >= CELL_WIDTH then
        ready <= '1';
      end if;

    elsif calc = '1' then
      report "STATE: calculating lbps.";
      counter := 0;
      for n in CELL_WIDTH - 1 downto 1 loop
        for m in CELL_HEIGHT - 1 downto 1 loop
          -- calculate feature vector
          feature(counter)(0) <= '1' whenpixels(m - 1, n - 1) >= pixels(m, n) else '0';  
          feature(counter)(1) <= '1' when pixels(m - 0, n - 1) >= pixels(m, n) else '0';  
          feature(counter)(2) <= '1' when pixels(m + 1, n - 1) >= pixels(m, n) else '0';  
          feature(counter)(3) <= '1' when pixels(m - 1, n - 0) >= pixels(m, n) else '0';  
          feature(counter)(4) <= '1' when pixels(m + 1, n - 0) >= pixels(m, n) else '0';  
          feature(counter)(5) <= '1' when pixels(m - 1, n + 1) >= pixels(m, n) else '0';  
          feature(counter)(6) <= '1' when pixels(m - 0, n + 1) >= pixels(m, n) else '0';  
          feature(counter)(7) <= '1' when pixels(m + 1, n + 1) >= pixels(m, n) else '0';  
          counter := counter + 1;
          -- histogram
          if histogram(to_integer(unsigned(feature(counter - 1)))) > 0 then -- is init/set?
            histogram(to_integer(unsigned(feature(counter - 1)))) <= histogram(to_integer(unsigned(feature(counter - 1)))) + 1;
          else
            histogram(to_integer(unsigned(feature(counter - 1)))) <= 1;
          end if;
        end loop; 
      end loop;
      histo <= std_logic_vector(unsigned(histogram));

    end if;

  end process;  
 
end a;
