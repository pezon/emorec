library ieee;

use ieee.std_logic_1164.all;
use work.emorec.all;

entity histogram_datapath is
  generic (
    data_width : natural := 64);
  port (
    data : in std_logic_vector(data_width - 1 downto 0);
    histogram : out histogram32_t);
end histogram_datapath;

