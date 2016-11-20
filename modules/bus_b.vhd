-- mizuhara
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BUS_B is 
    port(GRB_latch : in std_logic;
        GR_O_B: in std_logic_vector(15 downto 0);
	MDR_B_latch : in std_logic;
        MDR_O_B: in std_logic_vector(15 downto 0);
        PR_latch: in std_logic;
        PR_O:in std_logic_vector(15 downto 0);
        MAR_latch: in std_logic;
        MAR_O: in std_logic_vector(15 downto 0);
        SP_latch: in std_logic;
        SP_O: in std_logic_vector(15 downto 0);
        SDR_latch: in std_logic;
        SDR_O: in std_logic_vector(15 downto 0);
        BUS_B_OUT : out std_logic_vector(15 downto 0)
);
        
	
end BUS_B;

architecture RTL of BUS_B is 
signal q : std_logic_vector(15 downto 0);	
begin
    
    process(GRB_latch,GR_O_B,MDR_B_latch, MDR_O_B,PR_latch,PR_O,MAR_latch,MAR_O,SP_latch,SP_O,SDR_latch,SDR_O)
	
	begin
	
	if (not(GRB_latch = '1' xor MDR_B_latch ='1' xor PR_latch = '1' xor MAR_latch = '1' xor SP_latch = '1' xor SDR_latch = '1'))  then 
		q <=  "0000000000000000";
	elsif (GRB_latch = '1') then
		q <= GR_O_B;
	elsif (MDR_B_latch = '1') then
    		q <= MDR_O_B;
	elsif (PR_latch = '1') then
    		q <= PR_O;
	elsif (MAR_latch = '1') then
    		q <= MAR_O;
        elsif (SP_latch = '1') then
    	       q <= SP_O;
       	elsif (SDR_latch = '1') then
    	       q <= SDR_O;
	else
		q <=  "0000000000000000";
	end if;
    end process;
	BUS_B_OUT <= q;


end RTL;
