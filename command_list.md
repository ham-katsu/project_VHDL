#命令セット表
  
|命令 |オペランド  | 機械語１|機械語２|めも|
| --------------- |:---------------:|:---------:|:-----------:| ------- |
|ADD  |r,r  | #10rr |------||
|ADD  |r,adr| #10rr |adress||
|SUB  |r,r  | #13rr |------||
|LAD  |r,adr| #20r0 |adress||
|CALL |adr  | #600r |adress||
|DIV  |r,r  | #50rr |------||
|MLT  |r,r  | #51rr |------||
|CPA  |r,r  | #30rr |------||
|JZE  |adr  | #400r |adress||
|JMP  |adr  | #410r |adress||
|RET  |-----| #6300 |------||
|LD   |r,adr| #21rr |adress||
|LD   |r,r  | #24rr |------||
|STR  |r,adr| #22rr |adress||
|HALT |-----| #6400 |------||

