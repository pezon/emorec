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
    clock  :  in  std_logic  : '0';
    reset  :  in  std_logic  : '0';
    -- control signals, activate states
    load0  :  in  std_logic  : '0';
    load1  :  in  std_logic  : '0';
    row0   :  in  std_logic  : '0';
    row1   :  in  std_logic  : '0'; 
    row2   :  in  std_logic  : '0';
    -- input databusses
    u_buff :  in  std_logic_vector(PIXEL_LENGTH * HORZ_BUFFER - 1 downto 0);
    l_buff :  in  std_logic_vector(PIXEL_LENGTH * VERT_BUFFER - 1 downto 0);
    data   :  in  std_logic_vector(DATABUS_LENGTH - 1 downto 0);
    -- output databuses     
    r_buff :  in  std_logic_vector(PIXEL_LENGTH * VERT_BUFFER - 1 downto 0);
    d_buff :  in  std_logic_vector(PIXEL_LENGTH * HORZ_BUFFER - 1 downto 0);
    col0   :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0);
    col1   :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0);
    col2   :  out std_logic_vector(PIXEL_LENGTH - 1 downto 0)
  );
end cell_datapath

architecture a for cell_datapath is

  -- process control signals
  process (clock, reset, load0, load1, row0, row1, row2)
  begin
    -- load0: load edge buffers, 1st data batch
    if load0 = '1' then

    -- load1: load 2nd data batch
    elsif load1 = '1' then

    -- row0: data loaded; compute lbps for 1st row
    elsif row0 = '1' then

    -- row1: compute lbps for 2nd row
    elsif row1 = '1' then

    -- row2: compute lbps for 3rd row
    elsif row2 = '1' then
    end if;
  end process;

end a;
