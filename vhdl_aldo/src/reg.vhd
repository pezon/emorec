-- Greg Stitt
--
-- File: reg.vhd
-- Entity: REG
--
-- Description: This entity implements a generic register
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-------------------------------------------------------------------------------
-- Generic
-- width: width of the register
-- init: initialization value (all bits will be reset to this value)

-- Port
-- clk: clock
-- rst (active hi): reset
-- en (active hi): enables the register (doesn't store if 0)
-- input: input to the register
-- output: output from the register
-------------------------------------------------------------------------------

entity REG is
  generic (width : positive  := 32;
           init  : std_logic := '0');
  port(clk    : in  std_logic;
       rst    : in  std_logic;
       en     : in  std_logic;
       input  : in  std_logic_vector(width-1 downto 0);
       output : out std_logic_vector(width-1 downto 0));
end REG;

architecture bhv of REG is
begin
  process(clk, rst)
  begin
    if rst = '1' then
      output <= (others => init);
    elsif (clk = '1' and clk'event) then
      if (en = '1') then
        output <= input;
      end if;
    end if;
  end process;
end bhv;
