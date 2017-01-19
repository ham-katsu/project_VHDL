-- mizuhara
-- GR 
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity PR is 
    port(
        input: in std_logic_vector(15 downto 0);
	p_inc: in std_logic;
	CLK : in std_logic;
        latch: in std_logic;
	output : out std_logic_vector(15 downto 0)
    );
end PR;

architecture RTL of PR is 
signal p : std_logic_vector(15 downto 0) := "0000000000000000";


begin
	
    process(CLK)  begin
	if(CLK'event and CLK = '1') then
            if((latch = '0') and (p_inc = '1')) then
              p <= p + 1;
              output <= p + 1;
            elsif((p_inc = '0') and (latch = '1')) then
              p <= input + 1;
              output <= input;
            else
              output <= p;
            end if;	
    	end if;
    end process;
end RTL;