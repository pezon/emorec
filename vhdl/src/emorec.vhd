package emorec is
  constant HISTOGRAM_LENGTH : natural := 256;

  type histogram8_t is array(HISTOGRAM_LENGTH - 1 downto 0) of std_logic_vector(7 downto 0);
  type histogram32_t is array(HISTOGRAM_LENGTH -1 downto 0) of std_logic_vector(31 downto 0);
end emorec;

