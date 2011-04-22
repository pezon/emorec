library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity histogram_register is
  generic (
    PATTERN_LENGTH  : integer  : 8;
    FEATURE_LENGTH  : integer  : 256
  );
  port (
    clock   :  in  std_logic   : '0';
    reset   :  in  std_logic   : '0';
    load    :  in  std_logic   : '0';
    value0    :  in  std_logic_vector(PATTERN_LENGTH - 1 downto 0);
    value1    :  in  std_logic_vector(PATTERN_LENGTH - 1 downto 0);
    value2    :  in  std_logic_vector(PATTERN_LENGTH - 1 downto 0)
  );
end histogram_register; 

architecture a for histogram_register is
  type histogram is array (natural range <>) of integer;
  signal histogram_reg : histogram(FEATURE_LENGTH - 1 downto 0);
begin 
  process (clock, load, reset)
    variable c0 : integer := 0;
    variable c2 : integer := 1;
    variable c3 : integer := 2;
  begin
    if reset = '1' then
      -- reset everything
      for i in PATTERN_LENGTH - 1 downto 0 loop
        histogram_reg(i) <= 0;
      end loop;
    elsif clock = '1' and clock'event and load = '1' then
      -- column 0 lbp
      c0 := to_integer(unsigned(value0));
      if histogram_reg(c0) >= 1 then
        histogram_reg(c0) <= histogram_reg(c0) + 1;
      else
        histogram_reg(c0) <= 1;
      end if;

      -- column 1 lbp
      c1 := to_integer(unsigned(value1));
      if histogram_reg(c1) >= 1 then
        histogram_reg(c1) <= histogram_reg(c1) + 1;
      else
        histogram_reg(c1) <= 1;
      end if;

      -- column 2 lbp
      c2 := to_integer(unsigned(value2));
      if histogram_reg(c2) >= 1 then
        histogram_reg(c2) <= histogram_reg(c2) + 1;
      else
        histogram_reg(c2) <= 1;
      end if;
    end if;
  end process;
end a;
