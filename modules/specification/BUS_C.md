# BUS_C

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
