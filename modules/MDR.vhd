library ieee;
use ieee.std_logic_1164.all;

entity MDR is
	port(	clk,S_mdi,lat : in std_logic;
		BusC_out,MDBus : in std_logic_vector(15 downto 0);
		MDR_out,MDRoutA,MDRoutB : out std_logic_vector(15 downto 0));
end MDR;

architecture RTL of MDR is
	signal S : std_logic_vector(15 downto 0);
	begin
	process (clk,MDBus,BusC_out,S_mdi,lat) begin
	if (clk='1') then
		if (S_mdi='1' and lat='1') then
			S <= MDBus;
		elsif (S_mdi='0' and lat='1') then
			S <= BusC_out;
		end if;
	end if;

	end process;
		
	MDRoutA <= S;
	MDRoutB <= S;
	MDR_out <= S;

end RTL;