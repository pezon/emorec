use work.emorec.all;

entity normalization_datapath is
  port (
    input : in histogram32_t;
    output : out histogram8_t);
end normalization_datapath;

