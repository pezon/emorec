library ieee;

use ieee.std_logic_1164.all;

package emorec is
  constant histogram_length : natural := 256;
  constant statistic_width : natural := 32;

  type histogram8_t is array(histogram_length - 1 downto 0) of std_logic_vector(7 downto 0);
  type histogram16_t is array(histogram_length - 1 downto 0) of std_logic_vector(15 downto 0);
  type histogram32_t is array(histogram_length -1 downto 0) of std_logic_vector(31 downto 0);
  subtype statistic_t is std_logic_vector(statistic_width - 1 downto 0);

  constant CELL_HEIGHT : natural := 5;
  constant CELL_WIDTH  : natural := 4;
  constant PIXEL_WIDTH : natural := 8;
  constant ROW_WIDTH   : natural := 4; -- 128;  -- 4 for testing purposes only

  type matrix_t is array(CELL_HEIGHT * CELL_WIDTH - 1 downto 0) of std_logic_vector(PIXEL_WIDTH - 1 downto 0);
end emorec;

