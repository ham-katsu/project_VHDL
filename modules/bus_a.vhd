-- mizuhara
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BUS_A is 
    port(GRA_latch : in std_logic;
        GR_O_A: in std_logic_vector(15 downto 0);
	MDR_A_latch : in std_logic;
        MDR_O_A: in std_logic_vector(15 downto 0);
	IR_latch : in std_logic;
        BUS_A_OUT : out std_logic_vector(15 downto 0);
	to_IR : out std_logic_vector(15 downto 0)
    );
end BUS_A;

architecture RTL of BUS_A is 

begin
	
    process(GRA_latch,GR_O_A,MDR_A_latch, MDR_O_A,IR_latch)
	variable tmp : std_logic_vector(15 downto 0);
	begin
	
	if (GRA_latch = '1'  and MDR_A_latch ='1') then 
		tmp :=  "0000000000000000";
	elsif (GRA_latch = '1') then
		tmp := GR_O_A;
	elsif (MDR_A_latch = '1') then
    		tmp := MDR_O_A;
	else
		tmp :=  "0000000000000000";
	end if;

	if (IR_latch = '1') then
		to_IR <= tmp;
		BUS_A_OUT <= "0000000000000000";
	else
		BUS_A_OUT <= tmp;
		to_IR <= "0000000000000000";
	end if;
    end process;

end RTL;