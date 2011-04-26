
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.emorec.all;

entity histogram_register is
  port (
    clock  :  in  std_logic  := '0';
    reset  :  in  std_logic  := '0';
    lbp0   :  in  lbp_t;
    lbp1   :  in  lbp_t;
    lbp2   :  in  lbp_t;
    lbp3   :  in  lbp_t;
    lbp4   :  in  lbp_t;
    lbp5   :  in  lbp_t
  );
end histogram_register;

architecture a of histogram_register is
  signal hist : histogram32_t;
begin

  process (clock, reset)
    variable l0, l1, l2, l3, l4, l5 : integer := 0;
    variable h0, h1, h2, h3, h4, h5 : integer := 0;
  begin
    if clock = '1' and clock'event then

    if l0 +

      l0 := to_integer(unsigned(lbp0));
      h0 := to_integer(unsigned(hist(l0)));
      hist(l0) <= std_logic_vector(to_unsigned(h0 + 1, 32));

      l1 := to_integer(unsigned(lbp1));
      h1 := to_integer(unsigned(hist(l1)));
      hist(l1) <= std_logic_vector(to_unsigned(h1 + 1, 32));

      l2 := to_integer(unsigned(lbp2));
      h2 := to_integer(unsigned(hist(l2)));
      hist(l2) <= std_logic_vector(to_unsigned(h2 + 1, 32));

      l3 := to_integer(unsigned(lbp3));
      h3 := to_integer(unsigned(hist(l3)));
      hist(l3) <= std_logic_vector(to_unsigned(h3 + 1, 32));

      l4 := to_integer(unsigned(lbp4));
      h4 := to_integer(unsigned(hist(l4)));
      hist(l4) <= std_logic_vector(to_unsigned(h4 + 1, 32));

      l5 := to_integer(unsigned(lbp5));
      h5 := to_integer(unsigned(hist(l5)));
      hist(l5) <= std_logic_vector(to_unsigned(h5 + 1, 32));

    end if;
  end process;

end a;

