library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cell_datapath is
  generic (
    DATABUS_LENGTH : integer : 64;
    PIXEL_LENGTH : integer : 8;
    VERT_BUFF : integer : 5;
    HORZ_BUFF : integer : 4;
  );
  port (
    clock   :  in  std_logic  : '0';
    reset   :  in  std_logic  : '0';
    -- consolidated control signals
    -- 000 = Wait -- 010 = Load1 -- 011 = Load2 -- 100 = Calc1 -- 101 = Calc2 -- 110 = Calc3
    control : in  std_logic_vector(2 downto 0);
    -- input databusses
    u_buff  :  in  std_logic_vector(PIXEL_LENGTH * HORZ_BUFFER - 1 downto 0);
    l_buff  :  in  std_logic_vector(PIXEL_LENGTH * VERT_BUFFER - 1 downto 0);
    data    :  in  std_logic_vector(DATABUS_LENGTH - 1 downto 0);
    -- output databuses     
    r_buff  :  in  std_logic_vector(PIXEL_LENGTH * VERT_BUFFER - 1 downto 0);
    d_buff  :  in  std_logic_vector(PIXEL_LENGTH * HORZ_BUFFER - 1 downto 0);
    col0    :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0);
    col1    :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0);
    col2    :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0)
  );
end cell_datapath

architecture a for cell_datapath is

  -- process control signals
  process (clock, reset, control)
  begin
    -- load0: load edge buffers, 1st data batch
    if control = "010" then 

    -- load1: load 2nd data batch
    elsif control = "011" then

    -- row0: data loaded; compute lbps for 1st row
    elsif control = "100" then

    -- row1: compute lbps for 2nd row
    elsif control = "101" then

    -- row2: compute lbps for 3rd row
    elsif control = "110" then 
    end if;
  end process;

end a;
