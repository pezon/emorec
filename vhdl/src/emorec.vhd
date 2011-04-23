library ieee;

use ieee.std_logic_1164.all;

package emorec is
  constant HISTOGRAM_LENGTH : natural := 256;

  type histogram8_t is array(HISTOGRAM_LENGTH - 1 downto 0) of std_logic_vector(7 downto 0);
  type histogram32_t is array(HISTOGRAM_LENGTH -1 downto 0) of std_logic_vector(31 downto 0);

  constant CELL_HEIGHT : natural := 5;
  constant CELL_WIDTH  : natural := 4;
  constant PIXEL_WIDTH : natural := 8;

  type matrix_t is array(CELL_HEIGHT * CELL_WIDTH - 1 downto 0) of std_logic_vector(PIXEL_WIDTH - 1 downto 0);
end emorec;

