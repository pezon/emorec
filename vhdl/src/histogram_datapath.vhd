library ieee;

use ieee.std_logic_1164.all;

entity histogram_datapath is
  generic (
    data_width : natural := 64);
  port (
    data : in std_logic_vector(data_width - 1 downto 0);
    histogram : out std_logic);
end histogram_datapath;

