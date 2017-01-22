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
	process(BusA_o_IR) 
		variable OP : std_logic_vector(7 downto 0);	
	begin
		GR1 <= BusA_o_IR(6 downto 4);
		GR2 <= BusA_o_IR(2 downto 0); 
		OP := BusA_o_IR(15 downto 8);
		ADDr <= '0';
	ADDadr <= '0';
	SUB <= '0';
	LAD <= '0';
	CALL<= '0';
	DIV <= '0';
	MLT <= '0';
	CPA <= '0';
	JZE<= '0';
	JMP <= '0';
	RET<= '0';
	LDr <= '0';
	LDadr<= '0';
	STR <= '0';
	HALT <= '0';
	AND_logic <= '0';

		case OP is
			when "00010000" =>
				ADDr <= '1';
			when "00010001" =>
				ADDadr <= '1';
			when "00010011" => 
				SUB <= '1';
			when "00100000" =>
				LAD <= '1';
			when "01100000"=>
				CALL <= '1';
			when "01010000" =>
				DIV <= '1';
			when "01010001" =>
				MLT <= '1';
			when "00110000" => 
				CPA <= '1';
			when  "01000000" =>
				JZE <= '1';
			when "01000001" =>
				JMP <= '1';
			when "01100011" =>
				RET <= '1';
			when "00100001" =>
				LDr <= '1';
			when "00100100"  =>
				LDadr <= '1';
			when  "00100010" =>
				STR <= '1';
			when "01100100" =>
				HALT <= '1';
			when "01110000" => 
				AND_logic <= '1';
			when others =>
				ADDadr <= '0';
				SUB <= '0';
				LAD <= '0';
				CALL<= '0';
				DIV <= '0';
				MLT <= '0';
				CPA <= '0';
				JZE<= '0';
				JMP <= '0';
				RET<= '0';
				LDr <= '0';
				LDadr<= '0';
				STR <= '0';
				HALT <= '0';
				AND_logic <= '0';
			end case;

		
		end process;
				
	end RTL;
			


