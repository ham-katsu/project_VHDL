--core

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;

entity TOY_CPU is
  port (
    CLK : in std_logic;
    busy : out std_logic
  );
end entity;

architecture RTL of TOY_CPU is
  component BUS_A
      port(GRA_latch : in std_logic;
          GR_O_A: in std_logic_vector(15 downto 0);
          MDR_A_latch : in std_logic;
          MDR_O_A: in std_logic_vector(15 downto 0);
          IR_latch : in std_logic;
          BUS_A_OUT : out std_logic_vector(15 downto 0);
          to_IR : out std_logic_vector(15 downto 0)
      );
  end component;
  component BUS_B
      port(GRB_latch : in std_logic;
          GR_O_B: in std_logic_vector(15 downto 0);
          MDR_B_latch : in std_logic;
          MDR_O_B: in std_logic_vector(15 downto 0);
          PR_latch: in std_logic;
          PR_O:in std_logic_vector(15 downto 0);
          MAR_latch: in std_logic;
          MAR_O: in std_logic_vector(15 downto 0);
          SP_latch: in std_logic;
          SP_O: in std_logic_vector(15 downto 0);
          SDR_latch: in std_logic;
          SDR_O: in std_logic_vector(15 downto 0);
          BUS_B_OUT : out std_logic_vector(15 downto 0)
        );
  end component;
  component decode
  port(
  BusA_o_IR : in std_logic_vector(15 downto 0);
  ADDr : out std_logic;
  ADDadr : out std_logic;
  SUB : out std_logic;
  LAD : out std_logic;
  CALL : out std_logic;
  DIV : out std_logic;
  MLT : out std_logic;
  CPA : out std_logic;
  JZE : out std_logic;
  JMP : out std_logic;
  RET : out std_logic;
  LDr : out std_logic;
  LDadr : out std_logic;
  STR : out std_logic;
  HALT : out std_logic;
  AND_logic : out std_logic;
  GR1,GROP : out std_logic_vector(2 downto 0);
  GR2 : out std_logic_vector(2 downto 0)
  );
end component;

component mar
   port( MARoutB: out std_logic_vector(15 downto 0);
         MAR_outMemory: out std_logic_vector(15 downto 0);
         MARlatch: in std_logic;
         busC_out: in std_logic_vector(15 downto 0);
         CLK : in std_logic
        );
end component;

component MDR
  port(	clk,S_mdi,lat : in std_logic;
  BusC_out,MDBus : in std_logic_vector(15 downto 0);
  MDR_out,MDRoutA,MDRoutB : out std_logic_vector(15 downto 0));
end component;

component memory
  port(read : in std_logic;
  write : in std_logic;
  SDR_o_m : in std_logic_vector(15 downto 0);
  MDR_o_m : in std_logic_vector(15 downto 0);
  SP_o_m : in std_logic_vector(15 downto 0);
  MAR_o_m : in std_logic_vector(15 downto 0);
  stack_sel : in std_logic;
  memory_out : out std_logic_vector(15 downto 0);
  CLK : in std_logic
  
   );
end component;

component PR
    port(
        input: in std_logic_vector(15 downto 0);
        p_inc: in std_logic;
        CLK : in std_logic;
        latch: in std_logic;
        output : out std_logic_vector(15 downto 0)
    );
end component;


component stack
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
end component;

component ALU
    port(latch : in std_logic;
   	BUS_C_OUT: inout std_logic_vector(15 downto 0);
    OP : in std_logic_vector(2 downto 0);
    CLK : in std_logic;
    A_IN : in std_logic_vector(15 downto 0);
    B_IN : in std_logic_vector(15 downto 0);
    zero : out std_logic
    );
end component;

component GR
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
end component;

type STATE_t is (F0,F1, F2,F0_F2, F3, exc, STR1, STR2, STR3, SUBadr1, SUBadr2, SUBadr3, ADDadr1, ADDadr2, ADDadr3, SUBr1, ADDr1,  LDadd1, LDadd2, LDadd3,LDr1,DIV1,MLT1,LAD1,JMP1,JZE,CALL1,CALL2,CALL3,RET1,RET2,RET3,CPA1);
signal current_state : STATE_t;
signal next_state : STATE_t;
signal S_GR_IN,S_GR_OUT,S_ALUOUT, S_A_GR, S_B_GR, S_ALU_BA, S_ALU_BB, S_IR_BA, S_BB_PR, S_BB_MAR, S_MEM_MAR, S_MEM_MDR, S_BA_MDR, S_BB_MDR, S_MDR_MEM, S_SP_MEM, S_BB_SP, S_BB_SDR, S_MEM_SP, S_MEM_SDR : std_logic_vector(15 downto 0) := X"0000";
signal S_OPofALU, S_SEL_A, S_SEL_B, S_OPofGR : std_logic_vector(2 downto 0);
signal S_S_INC, S_GRLATCH, S_MDRLATCHofBA, S_IRLATCHofBA, S_GRALATCHofBA,S_GRBLATCHofBB, S_MDRLATCHofBB, S_PRLATCHofBB, S_MARLATCHofBB, S_SPLATCHofBB, S_SDRLATCHofBB,  S_LATCHofALU,S_LATCHofGR, S_LATCHofPR, S_P_INC, S_S_DCR, S_SP_L, S_SDR_L, S_LATCHofMAR, S_S_MDI, S_LATCHofMDR, S_READ, S_WRITE, S_STACK_SEL, S_CLOCK, S_ADDr, S_ADDadr, S_SUB, S_LAD, S_CALL, S_DIV, S_MLT, S_CPA, S_JZE, S_JMP, S_RET, S_LDr, S_LDadr, S_STR, S_HALT, S_IN_SW, S_AND_logic: std_logic ;
signal S_ZERO :std_logic := '0' ;
begin
COMP_MDR : MDR port map (CLK, S_S_MDI, S_LATCHofMDR, S_ALUOUT, S_MDR_MEM, S_MEM_MDR, S_BA_MDR, S_BB_MDR);
COMP_MAR : mar port map (S_BB_MAR, S_MEM_MAR, S_LATCHofMAR, S_ALUOUT, CLK);
COMP_SP : stack port map (S_MEM_SP, S_MEM_SDR, S_BB_SP, S_BB_SDR, S_S_DCR, S_ALUOUT, S_MDR_MEM, S_S_MDI, S_SP_L, S_SDR_L, CLK,S_S_INC);
COMP_PR : PR port map (S_ALUOUT, S_P_INC, CLK, S_LATCHofPR, S_BB_PR);
COMP_ALU : ALU port map (S_LATCHofALU,S_ALUOUT,  S_OPofALU, CLK, S_ALU_BA, S_ALU_BB, S_ZERO);
COMP_MEM : memory port map (S_READ, S_WRITE, S_MEM_SDR, S_MEM_MDR, S_MEM_SP, S_MEM_MAR, S_STACK_SEL, S_MDR_MEM, CLK);
COMP_BUS_A : BUS_A port map (S_GRALATCHofBA, S_A_GR, S_MDRLATCHofBA, S_BA_MDR, S_IRLATCHofBA, S_ALU_BA, S_IR_BA);
COMP_BUS_B : BUS_B port map (S_GRBLATCHofBB, S_B_GR, S_MDRLATCHofBB, S_BB_MDR, S_PRLATCHofBB, S_BB_PR, S_MARLATCHofBB, S_BB_MAR, S_SPLATCHofBB, S_BB_SP, S_SDRLATCHofBB, S_BB_SDR, S_ALU_BB);
COMP_DECODE : decode port map (S_IR_BA, S_ADDr, S_ADDadr, S_SUB, S_LAD, S_CALL, S_DIV, S_MLT, S_CPA, S_JZE, S_JMP, S_RET, S_LDr, S_LDadr, S_STR, S_HALT, S_AND_logic, S_SEL_A,S_OPofGR,S_SEL_B);
COMP_GR : GR port map (S_GRLATCH,S_ALUOUT ,S_OPofGR ,S_SEL_A,S_SEL_B ,CLK,S_A_GR,S_B_GR,S_GR_IN,S_GR_OUT,S_IN_SW);


 process (CLK) begin
    if (CLK'event and CLK = '1') then
      current_state <= next_state;
    end if;
  end process;

  process(current_state) begin
    case current_state is
      when F0 =>
        S_S_INC <= '0'; S_GRALATCHofBA<= '0'; S_MDRLATCHofBA<= '0'; S_IRLATCHofBA<= '0'; S_GRBLATCHofBB<= '0';  S_MDRLATCHofBB<= '0';
        S_PRLATCHofBB<= '0'; S_MARLATCHofBB<= '0'; S_SPLATCHofBB<= '0'; S_SDRLATCHofBB<= '0'; S_LATCHofALU<= '0';
        S_GRLATCH<= '0'; S_LATCHofPR<= '0';S_P_INC<= '0';S_S_DCR<= '0'; S_SP_L<= '0'; S_SDR_L<= '0';
        S_LATCHofMAR<= '0'; S_S_MDI<= '0'; S_LATCHofMDR<= '0'; S_READ<= '0'; S_WRITE<= '0'; S_STACK_SEL<= '0'; 
	 S_IN_SW<= '0'; S_LATCHofGR <='0';
        busy <= '1';
        next_state <= F1;

      when F0_F2 =>
	S_S_INC <= '0'; S_GRALATCHofBA<= '0'; S_MDRLATCHofBA<= '0'; S_IRLATCHofBA<= '0'; S_GRBLATCHofBB<= '0';  S_MDRLATCHofBB<= '0';
        S_PRLATCHofBB<= '0'; S_MARLATCHofBB<= '0'; S_SPLATCHofBB<= '0'; S_SDRLATCHofBB<= '0'; S_LATCHofALU<= '0';
        S_GRLATCH<= '0'; S_LATCHofPR<= '0';S_P_INC<= '0';S_S_DCR<= '0'; S_SP_L<= '0'; S_SDR_L<= '0';
        S_LATCHofMAR<= '0'; S_S_MDI<= '0'; S_LATCHofMDR<= '0'; S_READ<= '0'; S_WRITE<= '0'; S_STACK_SEL<= '0';
        S_OPofALU <= "000";
	 S_IN_SW<= '0'; S_LATCHofGR <='0';
	S_P_INC <= '1'; 

	
	next_state <= F3;


      when F1 =>
        S_LATCHofALU <= '1';
        S_OPofALU <= "110";
        S_P_INC <= '1';
        S_LATCHofMAR <= '1';
        S_PRLATCHofBB <= '1';
        next_state <= F2;

      when F2 =>
        S_READ <= '1';
        S_LATCHofMDR <= '1';
        S_S_MDI <= '1';
        next_state <= F3;

      when F3 =>
	S_LATCHofALU <= '1';
        S_OPofALU <= "110";
        S_LATCHofMAR <= '1';
        S_PRLATCHofBB <= '1';
        S_READ <= '1';
        S_LATCHofMDR <= '1';
        S_S_MDI <= '1';
	S_P_INC <= '0';
        
	S_IRLATCHofBA <= '1';
	S_MDRLATCHofBA <='1';
        next_state <= exc;

      when exc =>
        S_READ <= '0';
        S_LATCHofMDR <= '0';
        S_S_MDI <= '0';
        S_LATCHofALU <= '0';
        S_LATCHofMAR <= '0';
	S_IRLATCHofBA <= '0';
	S_MDRLATCHofBA <='0';
	S_PRLATCHofBB <= '0';
  if S_ADDr = '1' then
    next_state <= ADDr1;
  elsif S_STR = '1' then
    next_state <= STR1;

  elsif S_LAD = '1' then
    next_state <= LAD1;

  elsif S_ADDadr = '1' then
    next_state <= ADDadr1;

  elsif S_CALL = '1' then
    next_state <= CALL1;

  elsif S_DIV = '1' then
    next_state <= DIV1;

  elsif S_MLT = '1' then
    next_state <= MLT1;

  elsif S_JZE = '1' then
    next_state <= JZE;

  elsif S_JMP = '1' then
    next_state <= JMP1;

  elsif S_RET = '1' then
    next_state <= RET1;

  elsif S_LDr = '1' then
    next_state <= LDr1;

  elsif S_LDadr = '1' then
    next_state <= LDadd1;

  --elsif S_AND_logic = '1' then
    --next_state <= AND1;

  elsif S_SUB = '1' then
    next_state <= SUBr1;
  elsif S_CPA = '1' then
    next_state <= CPA1;

  elsif S_HALT = '1' then
    busy <= '0';
  end if;


  when  STR1 =>
    S_LATCHofALU <= '1';
    S_MDRLATCHofBA <= '1';
    S_GRBLATCHofBB <= '1';
    S_OPofALU <= "001";
    S_LATCHofMAR <= '1';
    next_state <= STR2;

  when   STR2 =>
    S_MDRLATCHofBA <= '0';
    S_GRBLATCHofBB <= '0';
    S_LATCHofMAR <= '0';
    S_GRALATCHofBA <= '1';
    S_OPofALU <= "101";
    S_LATCHofMDR <= '1';
    next_state <= STR3;

  when   STR3 =>
    S_GRALATCHofBA <= '0';
    S_OPofALU <= "000";
    S_LATCHofMDR <= '0';
    S_WRITE <= '1';
    next_state <= F0;
  

  when   SUBadr1 =>
    S_LATCHofALU <= '1';
    S_MDRLATCHofBA <= '1';
    S_GRBLATCHofBB <= '1';
    S_OPofALU <= "001";
    S_LATCHofMAR <= '1';
    next_state <= SUBadr2;

  when  SUBadr2 =>
    S_MDRLATCHofBA <= '0';
    S_GRBLATCHofBB <= '0';
    S_OPofALU <= "000";
    S_LATCHofMAR <= '0';
    S_S_MDI <= '1';
    S_READ <= '1';
    S_LATCHofMDR <= '1';
    next_state <= SUBadr3;

  when   SUBadr3 =>
    S_S_MDI <= '0';
    S_READ <= '0';
    S_LATCHofMDR <= '0';
    S_GRBLATCHofBB <= '1';
    S_MDRLATCHofBB <= '1';
    S_OPofALU <= "010";
    S_GRLATCH <= '1';
    next_state <= F0;
  

 when   SUBr1 =>
    S_LATCHofALU <= '1';
    S_GRALATCHofBA <= '1';
    S_GRBLATCHofBB <= '1';
    S_OPofALU <= "010";
    S_GRLATCH <= '1';
    next_state <= F0_F2;
 

  when   ADDadr1 =>
    S_LATCHofALU <= '1';
    S_MDRLATCHofBA <= '1';
    S_GRBLATCHofBB <= '1';
    S_OPofALU <= "001";
    S_LATCHofMAR <= '1';
    next_state <= ADDadr2;

 when   ADDadr2=>
    S_MDRLATCHofBA <= '0';
    S_GRBLATCHofBB <= '0';
    S_OPofALU <= "000";
    S_LATCHofMAR <= '0';
    S_S_MDI <= '1';
    S_READ <= '1';
    S_LATCHofMDR <= '1';
    next_state <= ADDadr3;

 when   ADDadr3 =>
    S_S_MDI <= '0';
    S_READ <= '0';
    S_LATCHofMDR <= '0';
    S_GRALATCHofBA <= '1';
    S_MDRLATCHofBB <= '1';
    S_OPofALU <= "001";
    S_GRLATCH <= '1';
    next_state <= F0;
  

 when   ADDr1 =>
    S_LATCHofALU <= '1';
    S_GRALATCHofBA <= '1';
    S_GRBLATCHofBB <= '1';
    S_OPofALU <= "001";
    S_GRLATCH <= '1';
    next_state <= F0_F2;
 

   when   LDadd1=>
      S_MDRLATCHofBA <= '1';
      S_LATCHofALU <= '1';
      S_OPofALU <= "101";
      S_LATCHofMAR <= '1';
      next_state <= LDadd2;

   when   LDadd2=>
      S_MDRLATCHofBA <= '0';
      S_LATCHofALU <= '0';
      S_OPofALU <= "000";
      S_LATCHofMAR <= '0';

      S_READ <= '1';
      S_LATCHofMDR <= '1';
      S_S_MDI <= '1';
      next_state <= LDadd3;

   when   LDadd3=>
      S_READ <= '0';
      S_LATCHofMDR <= '0';
      S_S_MDI <= '0';

      S_LATCHofALU <= '1';
      S_OPofALU <= "110";
      S_MDRLATCHofBB <='1';
      S_GRLATCH <= '1';
      next_state <= F0;
    

   when   LDr1=>
  S_LATCHofALU <= '1';
  S_OPofALU <= "110";
  S_GRLATCH <= '1';
  S_GRBLATCHofBB <= '1';
  next_state <= F0_F2;
    

  when   DIV1=>
  S_LATCHofALU <= '1';
  S_OPofALU <= "100";
  S_GRLATCH <= '1';
  S_GRALATCHofBA <= '1';
  S_GRBLATCHofBB <= '1';
  next_state <= F0_F2;

   when   MLT1=>
  S_LATCHofALU <= '1';
  S_OPofALU <= "011";
  S_GRLATCH <= '1';
  S_GRALATCHofBA <= '1';
  S_GRBLATCHofBB <= '1';
  next_state <= F0_F2;



  when   LAD1=>
    S_LATCHofALU <= '1';
    S_OPofALU <= "110";
    S_MDRLATCHofBB <= '1';
   S_GRLATCH <= '1';
    next_state <= F0;


  when   JMP1=>
    S_LATCHofALU <= '1';
    S_OPofALU <= "110";
    S_LATCHofPR <= '1';
    S_MDRLATCHofBB <= '1';

    next_state <= F0;


 when   JZE=>
   if (S_ZERO = '1') then
    S_LATCHofALU <= '1';
    S_OPofALU <= "110";
    S_LATCHofPR <= '1';
    S_MDRLATCHofBB <= '1';
   end if;
    next_state <= F0;
  

 when   CALL1=>
      --S_MDRLATCHofBA <= '1';
      --S_LATCHofALU <= '1';
      --S_OPofALU <= "101";
      --S_LATCHofMAR <= '1';
	S_MDRLATCHofBA <= '0';
      S_LATCHofMAR <= '0';
      S_LATCHofALU <= '1';
      S_S_DCR <= '1';
      S_PRLATCHofBB <= '1';
      S_OPofALU <= "110";
      S_SDR_L <= '1';
      S_S_MDI <= '0';
      next_state <= CALL2;

    when   CALL2 =>
      S_S_DCR <= '0';
      S_PRLATCHofBB <= '0';
      S_SDR_L <= '0';
      S_STACK_SEL <= '1';
      S_MDRLATCHofBB <= '1';
      S_LATCHofPR <= '1';

      next_state <= CALL3;

   when   CALL3=>
     
     
      S_WRITE <= '1';
      --S_MARLATCHofBB <= '1';
      
      next_state <= F0;
  

 when  RET1 =>
    --S_READ <= '1';
    S_STACK_SEL <= '1';
    S_SDR_L <= '0';
    S_S_INC <= '1';
    next_state <= RET2;

  when  RET2 =>
    S_READ <= '1';
    --S_STACK_SEL <= '0';
    S_SDR_L <= '1';
    S_S_INC <= '0';
    --S_S_INC <= '1';
    S_S_MDI <= '1';
    
    next_state <= RET3;

  when RET3 =>
    S_READ <= '0';
    S_STACK_SEL <= '1';
    --S_S_MDI <= '0';
    --S_SDR_L <= '0';
    --S_S_INC <= '0';

    S_LATCHofPR <= '1';
    S_SDRLATCHofBB <= '1';
    S_LATCHofALU <= '1';
    S_OPofALU <= "110";
    next_state <= F0;

   when   CPA1 =>
    S_LATCHofALU <= '1';
    S_GRALATCHofBA <= '1';
    S_GRBLATCHofBB <= '1';
    S_OPofALU <= "111";
    next_state <= F0_F2;
end case;
end process;
end RTL;
