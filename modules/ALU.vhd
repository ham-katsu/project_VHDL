library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

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
component MPU
    port(A_in: in std_logic_vector(15 downto 0);
         OP: in std_logic_vector(2 downto 0);
         B_in: in std_logic_vector(15 downto 0);
         C_OUT: out std_logic_vector(15 downto 0)
);
end component;

signal MPU_A: std_logic_vector(15 downto 0) := X"0000";
signal MPU_OP: std_logic_vector(2 downto 0);
signal MPU_B: std_logic_vector(15 downto 0):= X"0000";
signal MPU_z: std_logic;
signal out_MPU :std_logic_vector(15 downto 0):= X"0000";

signal for_zero : std_logic_vector(15 downto 0);


begin

    COMP: MPU port map(A_in,OP ,B_in,out_MPU);
    

	
    process(CLK)
	variable ans : std_logic_vector(15 downto 0);
    begin
    if(CLK'event and CLK = '1') then
	if (latch = '1') then
          
	    case OP is
		when "001" =>
		    ans := A_IN + B_IN;
		when "010" =>
		    ans := A_IN - B_IN;
		when "101" => 
		    ans := A_IN;
		when "110" =>
		    ans := B_IN;
		when "111" =>
		    ans := A_IN and B_IN;
		when "000" =>
		    ans := X"0000";
	        when others =>
		    ans := out_MPU;
        end case;
	BUS_C_OUT <= ans;
	
	if (ans = "0000000000000000") then
	    zero <= '1';
	else
	    zero <= '0';
    	end if;
	
	end if;
    end if;
    end process;

 


	
end RTL;