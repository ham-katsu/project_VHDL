library IEEE;
use IEEE.std_logic_1164.all;

entity dec1 is
  port (input  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(7 downto 0));
end dec1;

architecture BEHAVIOR of dec is
begin
  process (input) begin
    if (input = "0000") then
      output <= "00000011";
    elsif (input = "0001") then  
      output <= "10011111";
    elsif (input = "0010") then
      output <= "00100101";
    elsif (input = "0011") then
      output <= "00001101";
    elsif (input = "0100") then
      output <= "10011001";
    elsif (input = "0101") then
      output <= "01001001";
    elsif (input = "0110") then
      output <= "01000001";
    elsif (input = "0111") then
      output <= "00011111";
    elsif (input = "1000") then
      output <= "00000001";
    elsif (input = "1001") then
      output <= "00001001";
    elsif (input = "1010") then
      output <= "00010001";
    elsif (input = "1011") then
      output <= "11000001";
    elsif (input = "1100") then
      output <= "01100011";
    elsif (input = "1101") then
      output <= "10000101";
    elsif (input = "1110") then
      output <= "01100001";
    elsif (input = "1111") then
      output <= "01110001";
    end if;
  end process;
end BEHAVIOR;