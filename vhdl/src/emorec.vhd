library ieee;

use ieee.std_logic_1164.all;

package emorec is
  constant histogram_length : natural := 256;
  constant statistic_width : natural := 32;

  type histogram8_t is array(histogram_length - 1 downto 0) of std_logic_vector(7 downto 0);
  type histogram16_t is array(histogram_length - 1 downto 0) of std_logic_vector(15 downto 0);
  type histogram32_t is array(histogram_length -1 downto 0) of std_logic_vector(31 downto 0);
  subtype statistic_t is std_logic_vector(statistic_width - 1 downto 0);

  component chisquare_datapath is
    port (
      clk : in std_logic;
      rst : in std_logic;
      go : in std_logic;
      observed : in histogram8_t;
      eigenface : in histogram8_t;
      done : out std_logic;
      statistic : out statistic_t);
  end component;

  constant CELL_HEIGHT : natural := 5;
  constant CELL_WIDTH  : natural := 4;
  constant PIXEL_WIDTH : natural := 8;
  constant ROW_WIDTH   : natural := 128; 

  type matrix_t is array(CELL_HEIGHT * CELL_WIDTH - 1 downto 0) of std_logic_vector(PIXEL_WIDTH - 1 downto 0);
end emorec;

