library IEEE;
use IEEE.std_logic_1164.all;

entity PR is
  port(lat, clk, rst, s_inc : in  std_logic;
       d : in  std_logic_vector(15 downto 0);
       f : out std_logic_vector(15 downto 0));
end PR;

architecture BEHAVIOR of PR is

  component ha
  port(a, b : in  std_logic;
       c, f : out std_logic);
  end component;

  component reg_pos_et_d_ff is
  port(clk, D, lat, rst : in  std_logic;
       Q : out std_logic);
  end component;

  signal S_HA_F : std_logic_vector(13 downto 0);
  signal S_C : std_logic_vector(14 downto 0);
  signal S_F,S_D : std_logic_vector(15 downto 0);

begin
  ha1 : ha port map(S_F(1), S_C(0), S_C(1), S_HA_F(0));
  ha2 : ha port map(S_F(2), S_C(1), S_C(2), S_HA_F(1));
  ha3 : ha port map(S_F(3), S_C(2), S_C(3), S_HA_F(2));
  ha4 : ha port map(S_F(4), S_C(3), S_C(4), S_HA_F(3));
  ha5 : ha port map(S_F(5), S_C(4), S_C(5), S_HA_F(4));
  ha6 : ha port map(S_F(6), S_C(5), S_C(6), S_HA_F(5));
  ha7 : ha port map(S_F(7), S_C(6), S_C(7), S_HA_F(6));
  ha8 : ha port map(S_F(8), S_C(7), S_C(8), S_HA_F(7));
  ha9 : ha port map(S_F(9), S_C(8), S_C(9), S_HA_F(8));
  ha10 : ha port map(S_F(10), S_C(9), S_C(10), S_HA_F(9));
  ha11 : ha port map(S_F(11), S_C(10), S_C(11), S_HA_F(10));
  ha12 : ha port map(S_F(12), S_C(11), S_C(12), S_HA_F(11));
  ha13 : ha port map(S_F(13), S_C(12), S_C(13), S_HA_F(12));
  ha14 : ha port map(S_F(14), S_C(13), S_C(14), S_HA_F(13));
  ff0 : reg_pos_et_d_ff port map(clk, S_D(0), lat, rst, S_F(0));
  ff1 : reg_pos_et_d_ff port map(clk, S_D(1), lat, rst, S_F(1));
  ff2 : reg_pos_et_d_ff port map(clk, S_D(2), lat, rst, S_F(2));
  ff3 : reg_pos_et_d_ff port map(clk, S_D(3), lat, rst, S_F(3));
  ff4 : reg_pos_et_d_ff port map(clk, S_D(4), lat, rst, S_F(4));
  ff5 : reg_pos_et_d_ff port map(clk, S_D(5), lat, rst, S_F(5));
  ff6 : reg_pos_et_d_ff port map(clk, S_D(6), lat, rst, S_F(6));
  ff7 : reg_pos_et_d_ff port map(clk, S_D(7), lat, rst, S_F(7));
  ff8 : reg_pos_et_d_ff port map(clk, S_D(8), lat, rst, S_F(8));
  ff9 : reg_pos_et_d_ff port map(clk, S_D(9), lat, rst, S_F(9));
  ff10 : reg_pos_et_d_ff port map(clk, S_D(10), lat, rst, S_F(10));
  ff11 : reg_pos_et_d_ff port map(clk, S_D(11), lat, rst, S_F(11));
  ff12 : reg_pos_et_d_ff port map(clk, S_D(12), lat, rst, S_F(12));
  ff13 : reg_pos_et_d_ff port map(clk, S_D(13), lat, rst, S_F(13));
  ff14 : reg_pos_et_d_ff port map(clk, S_D(14), lat, rst, S_F(14));
  ff15 : reg_pos_et_d_ff port map(clk, S_D(15), lat, rst, S_F(15));

  S_C(0) <= S_F(0);
  f <= S_F;

  process(s_inc, d, S_D, S_F, S_C, S_HA_F) begin
  if(s_inc = '1') then
    S_D(0) <= not S_F(0);
    S_D(14 downto 1) <= S_HA_F;
    S_D(15) <= S_F(15) xor S_C(14);
  else
    S_D <= d;
  end if;
  end process;

end BEHAVIOR;
