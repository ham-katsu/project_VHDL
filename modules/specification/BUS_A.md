# BUS_A

## 信号線

* input
  1. GR_O_A
    + GR_latch(1)
  2. MDR_O_A
    + MDR_A_latch(1)
  3. IR_latch(1)


* output
  1. BUS_A_OUT
  2. to_IR

## 処理
バスはクロックがないです．

GR_latchがハイでGR->out.
MDR_A_latchがハイでMDR->out.
両方がHIのときにはなにも出力しないようにします．

IR_latch=0で↑のoutはBUS_A_OUT．=1だと出力先がto_IRになります．


---
## 完成


```vhdl
component BUS_A  
port(GRA_latch : in std_logic;
  GR_O_A: in std_logic_vector(15 downto 0);
  MDR_A_latch : in std_logic;
  MDR_O_A: in std_logic_vector(15 downto 0);
  IR_latch : in std_logic;
  BUS_A_OUT : out std_logic_vector(15 downto 0) bus;
  to_IR : out std_logic_vector(15 downto 0) bus
);
end component;
```
