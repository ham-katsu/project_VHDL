library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;

entity MPU is 
    port(
        A_in: in std_logic_vector(15 downto 0);
	OP : in std_logic_vector(2 downto 0);
        B_in : in std_logic_vector(15 downto 0);
       	C_OUT : out std_logic_vector(15 downto 0)
    );
end MPU;

architecture RTL of MPU is 
    signal f_A,f_B: ufixed(7 downto -8);

    begin
        f_A <= to_ufixed(A_in, f_A);
        f_B <= to_ufixed(B_in, f_B);

	process(f_A,f_B,OP) begin
	    if(OP = "100") then
	        C_OUT <= to_SLV(resize(f_A/f_B,7,-8));
	    elsif(OP = "011") then
		C_OUT <= to_SLV(resize(f_A*f_B,7,-8));
	    else
		C_OUT <= "ZZZZZZZZZZZZZZZZ";
	end if;
	end process;
end RTL;