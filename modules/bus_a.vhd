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
        BUS_A_OUT : out std_logic_vector(15 downto 0) bus;
	to_IR : out std_logic_vector(15 downto 0) bus
    );
end BUS_A;

architecture RTL of BUS_A is 
signal q : std_logic_vector(15 downto 0);
begin
	
    process(GRA_latch,GR_O_A,MDR_A_latch, MDR_O_A)
	begin
	
	if (GRA_latch = '1' and MDR_A_latch ='1') then 
		q <=  "0000000000000000";
	elsif (GRA_latch = '1') then
		q <= GR_O_A;
	elsif (MDR_A_latch = '1') then
    		q <= MDR_O_A;
	else
		q <=  "0000000000000000";
	end if;
    end process;

    process(q,IR_latch)
	begin
	    if (IR_latch = '1') then
		to_IR <= q;
		BUS_A_OUT <= "0000000000000000";
	    else
		BUS_A_OUT <= q;
	    end if;
    end process;
end RTL;