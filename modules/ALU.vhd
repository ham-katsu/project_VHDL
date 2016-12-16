library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ALU is 
    port(A_IN : in std_logic_vector(15 downto 0);
	 B_IN : in std_logic_vector(15 downto 0);
         latch : in std_logic;
         BUS_C_OUT: inout std_logic_vector(15 downto 0);
	 OP : in std_logic_vector(2 downto 0);
	 CLK : in std_logic;

	 zero : out std_logic
    );
end ALU;

architecture RTL of ALU is 
component MPU
    port(A_in: in std_logic_vector(15 downto 0);
         OP: in std_logic_vector(2 downto 0);
         CLK: in std_logic;
         B_in: in std_logic_vector(15 downto 0);
         zero: out std_logic;
         C_OUT: out std_logic_vector(15 downto 0)
);
end component;

signal MPU_A: std_logic_vector(15 downto 0);
signal MPU_OP: std_logic_vector(2 downto 0);
signal MPU_B: std_logic_vector(15 downto 0);
signal MPU_z: std_logic;


begin

    COMP: MPU port map(MPU_A,MPU_OP ,CLK ,MPU_B,MPU_z ,BUS_C_OUT);
    

	
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
		when "000" =>
		    BUS_C_OUT <= X"0000";
	        when others =>
                    MPU_A <= A_IN;
                    MPU_OP <= OP;
                    MPU_B <= B_IN;
                    zero <= MPU_Z;
               
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