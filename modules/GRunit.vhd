 
  library IEEE;
  use IEEE.std_logic_1164.all;

  entity   GRunit    is
    
    port (     op     :  in  std_logic_vector(3 downto 0);
             busC_out :  in  std_logic_vector(15 downto 0);
            GRAlatch  :  in  std_logic;
              CLK     :  in  std_logic;
 
          GRoutA,GRoutB   :  out std_logic_vector(15 downto 0)
          
          );         
  end   GRunit   ;
  
  architecture RTL of GRunit is
  component dff_legs 
      generic (WIDTH : integer := 16);
      port (CLK, EN : in std_logic;
            D       : in std_logic_vector(WIDTH - 1 downto 0);
            Q       : out std_logic_vector(WIDTH - 1 downto 0)
           );
  end component;

  signal input : std_logic_vector(WIDTH - 1 downto 0);
  signal output : std_logic_vector(WIDTH - 1 downto 0);

 
  begin
      if CLK'event and CLK = '1' then
            if GRAlatch = '1' then
                  GR0 : dff_
      GR0: dff_legs port map(D=>busC_out, Q=>output);
      GR1: dff_legs port map(D=>busC_out, Q=>output);
      GR2: dff_legs port map(D=>busC_out, Q=>output);
      GR3: dff_legs port map(D=>busC_out, Q=>output);
      GR4: dff_legs port map(D=>busC_out, Q=>output);
      GR5: dff_legs port map(D=>busC_out, Q=>output);
      GR6: dff_legs port map(D=>busC_out, Q=>output);
      GR7: dff_legs port map(D=>busC_out, Q=>output);

      
  end RTL;

 

