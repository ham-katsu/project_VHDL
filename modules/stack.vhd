library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity stack is
    port(SP_o_m : out std_logic_vector(15 downto 0);
	SDR_o_m : out std_logic_vector(15 downto 0);
	SP_o_B : out std_logic_vector(15 downto 0);
	SDR_o_B : out std_logic_vector(15 downto 0);
	S_dcr : in std_logic;
	BUS_C : in std_logic_vector(15 downto 0);
	memory_out : in std_logic_vector(15 downto 0);
	S_sdi : in std_logic;
	SP_latch : in std_logic;
	SDR_latch : in std_logic;
	CLK : in std_logic;
	s_inc : in std_logic
    );
end stack;
architecture RTL of stack is
    signal buf_SP: std_logic_vector(15 downto 0) := x"007F";
    signal buf_SDR: std_logic_vector(15 downto 0);
    begin
    process(CLK) begin
        if (CLK'event and CLK = '1') then
	-- stack pointer
	    if(S_dcr = '1') then
		buf_SP <= buf_SP - 1;
	    elsif (SP_latch  = '1') then
		buf_SP <= BUS_C;
	    elsif (s_inc = '1') then
		buf_SP <= buf_SP + 1;
	    end if;

	-- stack
	    if (SDR_latch = '1') then
	        if(S_sdi = '1') then
		    buf_SDR <= memory_out;
		else
		    buf_SDR <= BUS_C;
		end if;
	    end if;
	end if;
    end process;

    SP_o_m <= buf_SP;
    SP_o_B <= buf_SP;

    SDR_o_m <= buf_SDR;
    SDR_o_B <= buf_SDR;

end RTL;
