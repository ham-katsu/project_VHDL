START   LAD $5,#0000
        LAD $7,#0100
        ADD $5,$0
        LAD $4,#0300
        CALL KAIJYO
        DIV $7,$2
        LAD $1,#0300
        CALL N_JYO
        MLT $7,$2
        SUB $5,$7
        LAD $4,#0500
        LAD $7,#0100
        CALL KAIJYO
        DIV $7,$2
        LAD $1,#0500
        CALL N_JYO
        MLT $7,$2
        ADD $5,$7
END     HALT

N_JYO   LAD $2,#0100
        LAD $6,#0100
        LAD $3,#0000
LOOP_N  MLT $2,$0
        ADD $3,$6
        CPA $3,$1
        JZE N_QUIT
        JMP LOOP_N
N_QUIT  RET

KAIJYO  LAD $2,#0100
        LAD $6,#0100
LOOP_K  MLT $2,$4
        SUB $4,$6
        CPA $4,$6
        JZE K_QUIT
        JMP LOOP_K
K_QUIT  RET
