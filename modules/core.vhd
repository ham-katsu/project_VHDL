--core
-- R.mizuhara

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;

entity TOY_CPU is
  port (
    CLK : in std_logic
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
  	GR1 : out std_logic_vector(2 downto 0)
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
	CLK : in std_logic
    );
end component;

component clock
    port(
        clk: out std_logic
    );
end clock;

component ALU
    port(latch : in std_logic;
   	BUS_C_OUT: inout std_logic_vector(15 downto 0);
	OP : in std_logic_vector(2 downto 0);
	CLK : in std_logic;
    	A_IN : in std_logic_vector(15 downto 0);
	B_IN : in std_logic_vector(15 downto 0);
	zero : out std_logic
    );
end ALU;
type STATE is (F1, F2, F3, exc, done);
signal current_state : STATE
signal S_ALUOUT, S_A_GA, S_B_GR, S_ALU_BA, S_ALU_BB, S_IR_BA, S_BB_PR, S_BB_MAR, S_MEM_MAR, S_MEM_MDR, S_BA_MDR, S_BB_MDR, S_MDR_MEM, S_SP_MEM, S_BB_SP, S_BB_SDR, S_MEM_SP, S_MEM_SDR : std_logic_vector(15 downto 0);
signal S_OPofALU, S_GR1, S_GR2 : std_logic_vector(2 downto 0);
signal S_GRALATCHofBA, S_MDRLATCHofBA, S_IRLATCHofBA, S_GRBLATCHofBB, S_MDRLATCHofBB, S_PRLATCHofBB, S_MARLATCHofBB, S_SPLATCHofBB, S_SDRLATCHofBB,  S_S_LATCHofALU, S_SEL_A, S_SEL_B, S_LATCHofGR, S_OPofGR, S_ZERO, S_LATCHofPR, S_P_INC, S_S_DCR, S_SP_L, S_SDR_L, S_LATCHofMAR, S_S_MDI, S_LATCHofMDR, S_READ, S_WRITE, S_STACL_SEL, S_CLOCK, S_ADDr, S_ADDadr, S_SUB, S_LAD, S_CALL, S_DIV, S_MLT, S_CPA, S_JZE, S_JMP, S_RET, S_LDr, S_LDadr, S_STR, S_HALT, S_AND_logic: std_logic;

COMP_MDR : MDR port map (S_CLOCK, S_S_MDI, S_LATCHofMDR, S_MDR_ALU, S_MDR_MEM, S_MEM_MDR, S_BA_MDR, S_BB_MDR);
COMP_MAR : mar port map (S_BB_MAR, S_MEM_MAR, S_LATCHofMAR, S_MAR_ALU, S_CLOCK);
COMP_SP : stack port map (S_MEM_SP, S_MEM_SDR, S_BB_SP, S_BB_SDR, S_S_DCR, S_SP_ALU, S_SP_MEM, S_S_MDI, S_SP_L, S_SDR_L, S_CLOCK);
COMP_PR : PR port map (S_PR_ALU, S_P_INC, S_CLOCK, S_LATCHofPR, S_BB_PR);
COMP_ALU : ALU port map (S_ALUOUT, S_LATCHofALU, S_OPofALU, S_CLOCK, S_BA_ALU, S_BB_ALU, S_ZERO);
COMP_MEM : memory port map (S_READ, S_WRITE, S_MEM_SDR, S_MEM_MDR, S_MEM_SP, S_MEM_MAR, S_STACK_SEL, S_MDR_MEM, S_CLOCK);
COMP_BUS_A : BUS_A port map (S_GRALATCHofBA, S_GR_A, S_MDRLATCHofBA, S_BA_MDR, S_IRLATCHofBA, S_ALU_BB, S_IR_BA);
COMP_BUS_B : BUS_B port map (S_GRBLATCHofBB, S_B_GR, S_MDRLATCHofBB, S_BB_MDR, S_PRLATCHofBB, S_BB_PR, S_MARLATCHofBB, S_BB_MAR, S_SPLATCHofBB, S_BB_SP, S_SDRLATCHofBB, S_BB_SDR, S_ALU_BB);
COMP_DECODE : decode port map (S_IR_BA, S_ADDr, S_ADDadr, S_SUB, S_LAD, S_CALL, S_DIV, S_MLT, S_CPA, S_JZE, S_JMP, S_RET, S_LDr, S_LDadr, S_STR, S_HALT, S_AND_logic, S_GR1, S_GR2);


begin
  process(CLK) begin
    if (CLK'event and CLK = '1') then
      if current_state = done then
        current_state <= F1;
      elsif current_state = F1 then
        current_state <= F2;
      elsif current_state = F2 then
        current_state <= F3;
      elsif current_state = F3 then
        current_state <= exc;
      elsif current_state = done
        current_state <= F1;
      end if;
    end if;
begin
  process(current_state) begin
    case current_state is
      when F1 =>
        S_OPofALU <= "110";
        S_P_INC <= '1';
        S_LATCHofMAR <= '1';
        S_PRLATCHofBB <= '1'

      when F2 =>
        S_READ <= '1';
        S_LATCHofMDR <= '1';
        S_S_MDI <= '1';

      when F3 =>
        S_OPofALU <= "000";
        S_P_INC <= '0';


      when exc =>

      when others =>
        null;
    end case;

end process;

end architecture;
