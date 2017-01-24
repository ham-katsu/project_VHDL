library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

--library ieee_proposed;
--use ieee_proposed.fixed_float_types.all;
--use ieee_proposed.fixed_pkg.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

entity ALU is 
    port(A_IN : in std_logic_vector(15 downto 0);
	 B_IN : in std_logic_vector(15 downto 0);
         latch : in std_logic;
         BUS_C_OUT: out std_logic_vector(15 downto 0);
	 OP : in std_logic_vector(2 downto 0);
	 CLK : in std_logic;

	 zero : out std_logic
    );
end ALU;

architecture RTL of ALU is 


signal f_A,f_B: ufixed(7 downto -8);

begin

    --COMP: MPU port map(A_in,OP ,B_in,out_MPU);
    

	
    process(A_IN,B_IN,latch,OP,f_A,f_B)
	variable ans : std_logic_vector(15 downto 0);
    begin
	f_A <= to_ufixed(A_IN, f_A);
        f_B <= to_ufixed(B_IN, f_B);
	if (latch = '1') then
          
	    case OP is
		when "001" =>
		    BUS_C_OUT <= A_IN + B_IN;
		when "010" =>
		    ans := A_IN - B_IN;
		when "101" => 
		    BUS_C_OUT <= A_IN;
		when "110" =>
		    BUS_C_OUT <= B_IN;
		when "111" =>
		    ans := A_IN - B_IN;
		    if (ans = "0000000000000000") then
			   zero <= '1';
		    else
	    		   zero <= '0';
    		    end if;
		when "000" =>
		    BUS_C_OUT <= X"0000";
	        when "011" =>
		    BUS_C_OUT <= to_SLV(resize(f_A*f_B,7,-8));
		when "100" =>
		    BUS_C_OUT <= to_SLV(resize(f_A/f_B,7,-8));	
		when others =>
			null;	    
        end case;
	
	end if;

	
    end process;

 


	
end RTL;