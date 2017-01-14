library IEEE;
use IEEE.std_logic_1164.all;

entity dec_4bit is
  port (in1  : in  std_logic_vector(15 downto 0);
        out1, out2, out3, out4 : out std_logic_vector(7 downto 0);
        point  : out std_logic);
end dec_4bit;

architecture STRUCTURE of dec_4bit is
component dec1
  port(input  : in  std_logic_vector(3 downto 0);
       output : out std_logic_vector(7 downto 0));
end component;

signal S_out1, S_out2, S_out3, S_out4 : std_logic_vector(7 downto 0);

begin
  dec_1 : dec1 port map (in1(15 downto 12), S_out1);
  dec_2 : dec1 port map (in1(11 downto 8), S_out2);
  dec_3 : dec1 port map (in1(7 downto 4), S_out3);
  dec_4 : dec1 port map (in1(3 downto 0), S_out4);

  point <= '0';

  out1 <= S_out1;
  out2 <= S_out2;
  out3 <= S_out3;
  out4 <= S_out4;

end STRUCTURE;