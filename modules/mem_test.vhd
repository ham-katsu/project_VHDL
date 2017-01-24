library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity memory is 
    port(read : in std_logic;
	write : in std_logic;
	SDR_o_m : in std_logic_vector(15 downto 0);
	MDR_o_m : in std_logic_vector(15 downto 0);
	SP_o_m : in std_logic_vector(15 downto 0);
	MAR_o_m : in std_logic_vector(15 downto 0);
	stack_sel : in std_logic;
	memory_out : out std_logic_vector(15 downto 0);
	CLK : in std_logic
   );
end memory;

architecture RTL of memory is
	subtype WORD is std_logic_vector(15 downto 0);
	type memarray is array (0 to 127) of WORD;
	signal memory : memarray := (X"2050",X"0000",X"2070",X"0001",X"1050",X"2040",X"0003",X"6000",X"0000",X"5072",X"6000",X"1027",X"5172",X"1357",X"2070",
X"0001",X"2040",X"0005",X"6000",X"1019",X"5072",X"6000",X"1027",X"5072",X"1057",X"2020",X"0001",X"2030",X"0001",X"2060",X"0001",X"5023",X"1036",X"3043",X"4000",
X"1026",X"4100",X"101F",X"6300",X"2020",X"0001",X"2060",X"0001",X"5020",X"0136",X"3031",X"4000",X"1032",X"4100",X"102B",X"6300",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000");
	signal addr : integer range 0 to 127; 
	begin
		process(CLK) begin
			if (CLK'event and CLK='1') then
				if stack_sel='1' then
					addr <= conv_integer(SP_o_m);
					if write='1' then
						if read='0' then
							memory(addr) <= SDR_o_m;
						elsif read='1' then
							memory_out <= "ZZZZZZZZZZZZZZZZ";
						end if;
					elsif write='0' then
						--if read='0' then
							--memory_out <= "ZZZZZZZZZZZZZZZZ";
						if read='1' then
							memory_out <= memory(addr);
						end if;
					end if;
			
				elsif stack_sel='0' then
					addr <= conv_integer(MAR_o_m);
					if write='1' then
						if read='0' then
							memory(addr) <= MDR_o_m;
						elsif read='1' then
							memory_out <= "ZZZZZZZZZZZZZZZZ";
						end if;
					elsif write='0' then
						--if read='0' then
							--memory_out <= "ZZZZZZZZZZZZZZZZ";
						if read='1' then
							memory_out <= memory(addr);
						end if;
					end if;
				end if;
			end if;
		end process;
	end RTL;
		