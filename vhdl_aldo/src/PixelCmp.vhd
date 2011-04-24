----------------------------------------------------------------------------------
-- Aldo Plaku
-- Peter Pezon
-- Adam Vaughn
--
-- Combanational Logic to determine Local Binary Patterns
-- Takes in current pixel values from Processing Array and gives out six LBPS per cycle
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PixelCmp is
	port(
		  -- Input array of registers from Processing block
		  Row0: in  std_logic_vector(31 downto 0);
		  Row1: in  std_logic_vector(31 downto 0);
		  Row2: in  std_logic_vector(31 downto 0);
		  Row3: in  std_logic_vector(31 downto 0);
		  Row4: in  std_logic_vector(31 downto 0);
		  -- LBPs outputed
		  LBP0: out std_logic_vector(7 downto 0);
		  LBP1: out std_logic_vector(7 downto 0);
		  LBP2: out std_logic_vector(7 downto 0);
		  LBP3: out std_logic_vector(7 downto 0);
		  LBP4: out std_logic_vector(7 downto 0);
		  LBP5: out std_logic_vector(7 downto 0)
		  );
end PixelCmp;

architecture Behavioral of PixelCmp is

--Singals for each individual pixel 
signal N0  : std_logic_vector(7 downto 0);
signal N1  : std_logic_vector(7 downto 0);
signal N2  : std_logic_vector(7 downto 0);
signal N3  : std_logic_vector(7 downto 0);
signal N4  : std_logic_vector(7 downto 0);
signal N5  : std_logic_vector(7 downto 0);
signal N6  : std_logic_vector(7 downto 0);
signal N7  : std_logic_vector(7 downto 0);
signal N8  : std_logic_vector(7 downto 0);
signal N9  : std_logic_vector(7 downto 0);
signal N10 : std_logic_vector(7 downto 0);
signal N11 : std_logic_vector(7 downto 0);
signal N12 : std_logic_vector(7 downto 0);
signal N13 : std_logic_vector(7 downto 0);
signal N14 : std_logic_vector(7 downto 0);
signal N15 : std_logic_vector(7 downto 0);
signal N16 : std_logic_vector(7 downto 0);
signal N17 : std_logic_vector(7 downto 0);
signal N18 : std_logic_vector(7 downto 0);
signal N19 : std_logic_vector(7 downto 0);

signal C0 : std_logic_vector(7 downto 0);
signal C1 : std_logic_vector(7 downto 0);
signal C2 : std_logic_vector(7 downto 0);
signal C3 : std_logic_vector(7 downto 0);
signal C4 : std_logic_vector(7 downto 0);
signal C5 : std_logic_vector(7 downto 0);

signal LBP0_s: std_logic_vector(7 downto 0) := (others => '0');
signal LBP1_s: std_logic_vector(7 downto 0) := (others => '0');
signal LBP2_s: std_logic_vector(7 downto 0) := (others => '0');
signal LBP3_s: std_logic_vector(7 downto 0) := (others => '0');
signal LBP4_s: std_logic_vector(7 downto 0) := (others => '0');
signal LBP5_s: std_logic_vector(7 downto 0) := (others => '0');

begin

--Seperate each row input into individual pixel values
N0 <= Row0(31 downto 24);
N1 <= Row0(23 downto 16);
N2 <= Row0(15 downto 8);
N3 <= Row0(7 downto 0);

N4 <= Row1(31 downto 24);
N5 <= Row1(23 downto 16);
N6 <= Row1(15 downto 8);
N7 <= Row1(7 downto 0);

N8 <= Row2(31 downto 24);
N9 <= Row2(23 downto 16);
N10 <= Row2(15 downto 8);
N11 <= Row2(7 downto 0);

N12 <= Row3(31 downto 24);
N13 <= Row3(23 downto 16);
N14 <= Row3(15 downto 8);
N15 <= Row3(7 downto 0);

N16 <= Row4(31 downto 24);
N17 <= Row4(23 downto 16);
N18 <= Row4(15 downto 8);
N19 <= Row4(7 downto 0);


--Set the Pixels under test as Ci
C0 <= Row1(23 downto 16);
C1 <= Row1(15 downto 8);
C2 <= Row2(23 downto 16);
C3 <= Row2(15 downto 8);
C4 <= Row3(23 downto 16);
C5 <= Row3(15 downto 8);

process(Row0,Row1,Row2,Row3,Row4)
begin

	--Generate C0 LBP
	if(unsigned(N4) > unsigned(C0)) then
		LBP0_s(0) <= '1';
	else
		LBP0_s(0) <= '0';
	end if;
	if(unsigned(N0) > unsigned(C0)) then
		LBP0_s(1) <= '1';
	else
		LBP0_s(1) <= '0';
	end if;
	if(unsigned(N1) > unsigned(C0)) then
		LBP0_s(2) <= '1';
	else
		LBP0_s(2) <= '0';
	end if;
	if(unsigned(N2) > unsigned(C0)) then
		LBP0_s(3) <= '1';
	else
		LBP0_s(3) <= '0';
	end if;
	if(unsigned(N6) > unsigned(C0)) then
		LBP0_s(4) <= '1';
	else
		LBP0_s(4) <= '0';
	end if;
	if(unsigned(N10) > unsigned(C0)) then
		LBP0_s(5) <= '1';
	else
		LBP0_s(5) <= '0';
	end if;
	if(unsigned(N9) > unsigned(C0)) then
		LBP0_s(6) <= '1';
	else
		LBP0_s(6) <= '0';
	end if;
	if(unsigned(N8) > unsigned(C0)) then
		LBP0_s(7) <= '1';
	else
		LBP0_s(7) <= '0';
	end if;

	--Generate C1 LBP
	if(unsigned(N5) > unsigned(C1)) then
		LBP1_s(0) <= '1';
	else
		LBP1_s(0) <= '0';
	end if;
	if(unsigned(N1) > unsigned(C1)) then
		LBP1_s(1) <= '1';
	else
		LBP1_s(1) <= '0';
	end if;
	if(unsigned(N2) > unsigned(C1)) then
		LBP1_s(2) <= '1';
	else
		LBP1_s(2) <= '0';
	end if;
	if(unsigned(N3) > unsigned(C1)) then
		LBP1_s(3) <= '1';
	else
		LBP1_s(3) <= '0';
	end if;
	if(unsigned(N7) > unsigned(C1)) then
		LBP1_s(4) <= '1';
	else
		LBP1_s(4) <= '0';
	end if;
	if(unsigned(N11) > unsigned(C1)) then
		LBP1_s(5) <= '1';
	else
		LBP1_s(5) <= '0';
	end if;
	if(unsigned(N10) > unsigned(C1)) then
		LBP1_s(6) <= '1';
	else
		LBP1_s(6) <= '0';
	end if;
	if(unsigned(N9) > unsigned(C1)) then
		LBP1_s(7) <= '1';
	else
		LBP1_s(7) <= '0';
	end if;
	
	--Generate C2 LBP
	if(unsigned(N8) > unsigned(C2)) then
		LBP2_s(0) <= '1';
	else
		LBP2_s(0) <= '0';
	end if;
	if(unsigned(N4) > unsigned(C2)) then
		LBP2_s(1) <= '1';
	else
		LBP2_s(1) <= '0';
	end if;
	if(unsigned(N5) > unsigned(C2)) then
		LBP2_s(2) <= '1';
	else
		LBP2_s(2) <= '0';
	end if;
	if(unsigned(N6) > unsigned(C2)) then
		LBP2_s(3) <= '1';
	else
		LBP2_s(3) <= '0';
	end if;
	if(unsigned(N10) > unsigned(C2)) then
		LBP2_s(4) <= '1';
	else
		LBP2_s(4) <= '0';
	end if;
	if(unsigned(N14) > unsigned(C2)) then
		LBP2_s(5) <= '1';
	else
		LBP2_s(5) <= '0';
	end if;
	if(unsigned(N13) > unsigned(C2)) then
		LBP2_s(6) <= '1';
	else
		LBP2_s(6) <= '0';
	end if;
	if(unsigned(N12) > unsigned(C2)) then
		LBP2_s(7) <= '1';
	else
		LBP2_s(7) <= '0';
	end if;

	--Generate C3 LBP
	if(unsigned(N9) > unsigned(C3)) then
		LBP3_s(0) <= '1';
	else
		LBP3_s(0) <= '0';
	end if;
	if(unsigned(N5) > unsigned(C3)) then
		LBP3_s(1) <= '1';
	else
		LBP3_s(1) <= '0';
	end if;
	if(unsigned(N6) > unsigned(C3)) then
		LBP3_s(2) <= '1';
	else
		LBP3_s(2) <= '0';
	end if;
	if(unsigned(N7) > unsigned(C3)) then
		LBP3_s(3) <= '1';
	else
		LBP3_s(3) <= '0';
	end if;
	if(unsigned(N11) > unsigned(C3)) then
		LBP3_s(4) <= '1';
	else
		LBP3_s(4) <= '0';
	end if;
	if(unsigned(N15) > unsigned(C3)) then
		LBP3_s(5) <= '1';
	else
		LBP3_s(5) <= '0';
	end if;
	if(unsigned(N14) > unsigned(C3)) then
		LBP3_s(6) <= '1';
	else
		LBP3_s(6) <= '0';
	end if;
	if(unsigned(N13) > unsigned(C3)) then
		LBP3_s(7) <= '1';
	else
		LBP3_s(7) <= '0';
	end if;


	--Generate C4 LBP
	if(unsigned(N12) > unsigned(C4)) then
		LBP4_s(0) <= '1';
	else
		LBP4_s(0) <= '0';
	end if;
	if(unsigned(N8) > unsigned(C4)) then
		LBP4_s(1) <= '1';
	else
		LBP4_s(1) <= '0';
	end if;
	if(unsigned(N9) > unsigned(C4)) then
		LBP4_s(2) <= '1';
	else
		LBP4_s(2) <= '0';
	end if;
	if(unsigned(N10) > unsigned(C4)) then
		LBP4_s(3) <= '1';
	else
		LBP4_s(3) <= '0';
	end if;
	if(unsigned(N14) > unsigned(C4)) then
		LBP4_s(4) <= '1';
	else
		LBP4_s(4) <= '0';
	end if;
	if(unsigned(N18) > unsigned(C4)) then
		LBP4_s(5) <= '1';
	else
		LBP4_s(5) <= '0';
	end if;
	if(unsigned(N17) > unsigned(C4)) then
		LBP4_s(6) <= '1';
	else
		LBP4_s(6) <= '0';
	end if;
	if(unsigned(N16) > unsigned(C4)) then
		LBP4_s(7) <= '1';
	else
		LBP4_s(7) <= '0';
	end if;


	--Generate C5 LBP
	if(unsigned(N13) > unsigned(C5)) then
		LBP5_s(0) <= '1';
	else
		LBP5_s(0) <= '0';
	end if;
	if(unsigned(N9) > unsigned(C5)) then
		LBP5_s(1) <= '1';
	else
		LBP5_s(1) <= '0';
	end if;
	if(unsigned(N10) > unsigned(C5)) then
		LBP5_s(2) <= '1';
	else
		LBP5_s(2) <= '0';
	end if;
	if(unsigned(N11) > unsigned(C5)) then
		LBP5_s(3) <= '1';
	else
		LBP5_s(3) <= '0';
	end if;
	if(unsigned(N15) > unsigned(C5)) then
		LBP5_s(4) <= '1';
	else
		LBP5_s(4) <= '0';
	end if;
	if(unsigned(N19) > unsigned(C5)) then
		LBP5_s(5) <= '1';
	else
		LBP5_s(5) <= '0';
	end if;
	if(unsigned(N18) > unsigned(C5)) then
		LBP5_s(6) <= '1';
	else
		LBP5_s(6) <= '0';
	end if;
	if(unsigned(N17) > unsigned(C5)) then
		LBP5_s(7) <= '1';
	else
		LBP5_s(7) <= '0';
	end if;
	
end process;	

LBP0 <= LBP0_s;
LBP1 <= LBP1_s;
LBP2 <= LBP2_s;
LBP3 <= LBP3_s;
LBP4 <= LBP4_s;
LBP5 <= LBP5_s;

end Behavioral;

