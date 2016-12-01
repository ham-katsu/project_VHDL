-- mizuhara
-- ALU 
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ALU is 
    port(latch : in std_logic;
    BUS_C_OUT: inout std_logic_vector(15 downto 0);
	OP : in std_logic_vector(2 downto 0);
	CLK : in std_logic;
    A_IN : in std_logic_vector(15 downto 0);
	B_IN : in std_logic_vector(15 downto 0);
	zero : out std_logic
    );
end ALU;

architecture RTL of ALU is 
begin
	
    process(CLK)
    begin
    if(CLK'event and CLK = '1') then
	if (latch = '1') then
	    case OP is
		when "001" =>
		    BUS_C_OUT <= A_IN + B_IN;
		when "010" =>
		    BUS_C_OUT <= A_IN - B_IN;
		when "101" => 
		    BUS_C_OUT <= A_IN;
		when "110" =>
		    BUS_C_OUT <= B_IN;
		when "111" =>
		    BUS_C_OUT <= A_IN and B_IN;
		when others =>
		    BUS_C_OUT <= X"0000";	
        end case;
	end if;
    end if;
    end process;

    process(BUS_C_OUT) 
    begin
	if (BUS_C_OUT = "0000000000000000") then
	    zero <= '1';
	else
	    zero <= '0';
    end if;
    end process;
	
end RTL;