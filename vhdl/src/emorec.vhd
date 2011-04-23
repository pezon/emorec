library ieee;

use ieee.std_logic_1164.all;

package emorec is
  constant histogram_length : natural := 256;
  constant percentile_width : natural := 32;

  type histogram8_t is array(histogram_length - 1 downto 0) of std_logic_vector(7 downto 0);
  type histogram16_t is array(histogram_length - 1 downto 0) of std_logic_vector(15 downto 0);
  type histogram32_t is array(histogram_length -1 downto 0) of std_logic_vector(31 downto 0);
  subtype percentile_t is std_logic_vector(percentile_width - 1 downto 0);

  component chisquare_datapath is
    port (
      clk : in std_logic;
      rst : in std_logic;
      go : in std_logic;
      observed : in histogram8_t;
      eigenface : in histogram8_t;
      done : out std_logic;
      percentile : out percentile_t);
  end component;

end emorec;

