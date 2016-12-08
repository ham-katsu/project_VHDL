#命令セット表
  
|命令 |オペランド  | 機械語１|機械語２|めも|
| --------------- |:---------------:|:---------:|:-----------:| ------- |
|ADD  |r,r  | #10rr |------|tk|
|ADD  |r,adr| #11r0 |adress|tk|
|SUB  |r,r  | #13rr |------|tk|
|LAD  |r,adr| #20r0 |adress|tk|
|CALL |adr  | #6000 |adress|m|
|DIV  |r,r  | #50rr |------|n|
|MLT  |r,r  | #51rr |------|n|
|CPA  |r,r  | #30rr |------|n|
|JZE  |adr  | #4000 |adress|m|
|JMP  |adr  | #4100 |adress|m|
|RET  |-----| #6300 |------||
|LD   |r,adr| #21r0 |adress|done|
|LD   |r,r  | #24rr |------|done|
|STR  |r,adr| #22r0 |adress|tk|
|HALT |-----| #6400 |------||
|AND  |r,r  | #70rr |------|n|
