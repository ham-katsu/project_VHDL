#命令セット表
  
|命令 |オペランド  | 機械語１|機械語２|めも|
| --------------- |:---------------:|:---------:|:-----------:| ------- |
|ADD  |r,r  | #10rr |------||
|ADD  |r,adr| #11r0 |adress||
|SUB  |r,r  | #13rr |------||
|LAD  |r,adr| #20r0 |adress||
|CALL |adr  | #6000 |adress||
|DIV  |r,r  | #50rr |------||
|MLT  |r,r  | #51rr |------||
|CPA  |r,r  | #30rr |------||
|JZE  |adr  | #4000 |adress||
|JMP  |adr  | #4100 |adress||
|RET  |-----| #6300 |------||
|LD   |r,adr| #21r0 |adress||
|LD   |r,r  | #24rr |------||
|STR  |r,adr| #22r0 |adress||
|HALT |-----| #6400 |------||
|AND  |r,r  | #70rr |------||
