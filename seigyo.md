# 命令フェッチ

前処理(F1~F3)の後に、各命令の処理を行います。

# 前処理

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
   
# 各命令の処理

# LDadr(#2100)

### 1

1. basAのMDR_latch

2. ALU(101)

3. MAR_latch

### 2

1. read

2. MDR_latch      

3. MDR s_mdi


### 3

1. alu(110)

2. GR_latch

# LDr(#2400)

1. ALU(110)

2. GR_latch



   
   
   
