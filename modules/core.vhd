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

      when F2 =>

      when F3 =>

      when exc =>

      when others =>
        null;
    end case;

end process;

end architecture;
