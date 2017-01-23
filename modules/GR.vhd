library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity GR is
    port(latch : in std_logic;
        From_BUS_C: in std_logic_vector(15 downto 0);
        OP : in std_logic_vector(2 downto 0);
        sel_A, sel_B : in std_logic_vector(2 downto 0);
        CLK : in std_logic;
        BUS_A_OUT : out std_logic_vector(15 downto 0);
        BUS_B_OUT : out std_logic_vector(15 downto 0);
        GR0_IN : in std_logic_vector(15 downto 0);
        GR0_OUT : out std_logic_vector(15 downto 0);
        in_sw : in std_logic
    );
end GR;

architecture RTL of GR is
signal gr0 : std_logic_vector(15 downto 0):="0000000011001001";
signal gr1 : std_logic_vector(15 downto 0);
signal gr2 : std_logic_vector(15 downto 0);
signal gr3 : std_logic_vector(15 downto 0);
signal gr4 : std_logic_vector(15 downto 0);
signal gr5 : std_logic_vector(15 downto 0);
signal gr6 : std_logic_vector(15 downto 0);
signal gr7 : std_logic_vector(15 downto 0);

begin
  process(CLK)
	begin
	if(CLK'event and CLK = '1') then
	    if (latch = '1'and in_sw = '0') then
		case OP is
		    when "000" => gr0 <= From_BUS_C ;
		    when "001" => gr1 <= From_BUS_C ;
		    when "010" => gr2 <= From_BUS_C ;
		    when "011" => gr3 <= From_BUS_C ;
		    when "100" => gr4 <= From_BUS_C ;
		    when "101" => gr5 <= From_BUS_C ;
		    when "110" => gr6 <= From_BUS_C ;
		    when "111" => gr7 <= From_BUS_C ;
		    when others => gr1<= "ZZZZZZZZZZZZZZZZ";
		end case;
	    end if;
		case sel_A is
		    when "000" => BUS_A_OUT <= gr0;
		    when "001" => BUS_A_OUT <= gr1;
		    when "010" => BUS_A_OUT <= gr2;
		    when "011" => BUS_A_OUT <= gr3;
		    when "100" => BUS_A_OUT <= gr4;
		    when "101" => BUS_A_OUT <= gr5;
		    when "110" => BUS_A_OUT <= gr6;
		    when "111" => BUS_A_OUT <= gr7;
		    when others => BUS_A_OUT<= "ZZZZZZZZZZZZZZZZ";
		end case;

		case sel_B is
		    when "000" => BUS_B_OUT <= gr0;
		    when "001" => BUS_B_OUT <= gr1;
		    when "010" => BUS_B_OUT <= gr2;
		    when "011" => BUS_B_OUT <= gr3;
		    when "100" => BUS_B_OUT <= gr4;
		    when "101" => BUS_B_OUT <= gr5;
		    when "110" => BUS_B_OUT <= gr6;
		    when "111" => BUS_B_OUT <= gr7;
		    when others => BUS_B_OUT<= "ZZZZZZZZZZZZZZZZ";
		end case;
            if (in_sw = '1' and latch = '0') then
                gr0 <= GR0_IN;
            end if;

    end if;
    end process;

	GR0_OUT <= gr0;

end RTL;
