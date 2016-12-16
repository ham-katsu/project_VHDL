library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity decode is 
    port(
	BusA_o_IR : in std_logic_vector(15 downto 0);
        ADDr : out std_logic;
	ADDadr : out std_logic;
	SUB : out std_logic;
	LAD : out std_logic;
	CALL : out std_logic;
	DIV : out std_logic;
	MLT : out std_logic;
	CPA : out std_logic;
	JZE : out std_logic;
	JMP : out std_logic;
	RET : out std_logic;
	LDr : out std_logic;
	LDadr : out std_logic;
	STR : out std_logic;
	HALT : out std_logic;
	AND_logic : out std_logic;
	GR1 : out std_logic_vector(2 downto 0);
	GR2 : out std_logic_vector(2 downto 0)
);
end decode;

architecture RTL of decode is
	
	begin
		GR1 <= BusA_o_IR(6 downto 4);
		GR2 <= BusA_o_IR(2 downto 0); 
		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00010000") then
				ADDr <= '1';
			else
				ADDr <= '0';
			end if;
		end process;
		
		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00010001") then
				ADDadr <= '1';
			else
				ADDadr <= '0';
			end if;
		end process;	
		
		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00010011") then
				SUB <= '1';
			else
				SUB <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00100000") then
				LAD <= '1';
			else
				LAD <= '0';
			end if;
		end process;
				
		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01100000") then
				CALL <= '1';
			else
				CALL <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01010000") then
				DIV <= '1';
			else
				DIV <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01010001") then
				MLT <= '1';
			else
				MLT <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00110000") then
				CPA <= '1';
			else
				CPA <= '0';
			end if;
		end process;
				
		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01000000") then
				JZE <= '1';
			else
				JZE <= '0';
			end if;
		end process;	

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01000001") then
				JMP <= '1';
			else
				JMP <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01100011") then
				RET <= '1';
			else
				RET <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00100001") then
				LDr <= '1';
			else
				LDr <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00100100") then
				LDadr <= '1';
			else
				LDadr <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "00100010") then
				STR <= '1';
			else
				STR <= '0';
			end if;
		end process;
		
		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01100100") then
				HALT <= '1';
			else
				HALT <= '0';
			end if;
		end process;

		process(BusA_o_IR)
		variable OP : std_logic_vector(7 downto 0);	
		begin
			OP := BusA_o_IR(15 downto 8);
			if (OP = "01110000") then
				AND_logic <= '1';
			else
				AND_logic <= '0';
			end if;
		end process;
				
	end RTL;
			


