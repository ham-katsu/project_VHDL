# 命令フェッチ

## F1

`
 MAR <= PR; PR <= PR + 1;
`

 pr -> B -> ALU(B) -> C -> MAR
 
 1. busb : prlatch
 
 2. alu （110）
 
 3. pr_inc
 
 4. MAR_latc
 
## F2
 
 `
  MDR <= mem(MAR); MAR <= PR; PR <= PR+1
 `
 
  MAR -> メモリのアドレス; メモリのデータ -> C -> MDR 
  pr -> B -> ALU(B) -> C -> MAR
  
   1. busb : prlatch  
   
   2. alu （110）  
   
   3. pr_inc  
   
   4. MAR_latc
   
   5. READ
   
   6. MDR_latch
   
   7. MDR s_mdi
   
## F3
 
 `
   IR <= MDR; MDR <- MEM(MAR); MAR <= PR
 `
 
   MDR -> A -> IR
   
   1. IR_latch
   
   2. MAR_latc      
   
   3. READ      
   
   4. MDR_latch      
   
   5. MDR s_mdi
   
   
   
   
