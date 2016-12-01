library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity mar  is 
   port( MARoutB: out std_logic_vector(15 downto 0);
         MAR_outMemory: out std_logic_vector(15 downto 0);
         MARlatch: in std_logic;
         busC_out: in std_logic_vector(15 downto 0);
         CLK : in std_logic
        );

end mar;
architecture RTL of mar is
   signal buf_MAR: std_logic_vector(15 downto 0);
   begin
   process(CLK) begin
       if (CLK'event and CLK = '1') then
           if(MARlatch = '1') then
              buf_MAR <= busC_out;
           else
              buf_MAR <= "0000000000000000";
           end if;
       end if;
   end process;
  
   MARoutB <= buf_MAR;
   MAR_outMemory <= buf_MAR;

end RTL; 
