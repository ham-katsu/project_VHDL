library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MPU2 is 
    port(
        A_in: in std_logic_vector(15 downto 0);
		OP : in std_logic_vector(2 downto 0);
		CLK : in std_logic;
        B_in : in std_logic_vector(15 downto 0);
	
		zero : out std_logic;
       	C_OUT : out std_logic_vector(15 downto 0)
    );
end MPU2;

architecture RTL of MPU2 is 
	--signal gr0 : std_logic_vector(15 downto 0);
	--signal x : std_logic_vector(7 downto 0);
	--signal y : std_logic_vector(8 downto 0);
	--signal s : std_logic_vector(15 downto 0);

begin
	process(CLK, OP)

	variable int_a, int_x, int_y, ans : Integer;
	variable x : std_logic_vector(7 downto 0);
	variable y : std_logic_vector(8 downto 0);
	variable s : std_logic_vector(15 downto 0);

	begin

	x(7) := B_in(15);
	x(6) := B_in(14);
	x(5) := B_in(13);
	x(4) := B_in(12);
	x(3) := B_in(11);
	x(2) := B_in(10);
	x(1) := B_in(9);
	x(0) := B_in(8);

	y(8) := B_in(0);
	y(7) := B_in(1);
	y(6) := B_in(2);
	y(5) := B_in(3);
	y(4) := B_in(4);
	y(3) := B_in(5);
	y(2) := B_in(6);
	y(1) := B_in(7);
	y(0) := '0';

	--x := B_in(15 downto 8);
	--y := B_in(0 to 8);

	if(CLK'event and CLK = '1') then
		int_a := CONV_INTEGER(A_in); 
		int_x := CONV_INTEGER(x);
		int_y := CONV_INTEGER(y);		
			if (OP="011") then
				if (y="000000000") then
					ans := int_a * int_x;
				else
			 		ans := int_a * int_x + int_a / int_y;
				end if;
			elsif (OP="100") then
				if (x="00000000") then
			 		ans := int_a * int_y;
				else
					ans := int_a / int_x + int_a * int_y;
				end if;
			end if;
		s := CONV_std_logic_vector(ans,16);
    end if;

	C_OUT <= s;

	end process;
	
end RTL;