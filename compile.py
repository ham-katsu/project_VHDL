import sys
KEYWORDS =(
        "ADD",
        "SUB",
        "LAD",
        "CALL",
        "DIV",
        "MLT",
        "CPA",
        "JZE",
        "JMP",
        "RET",
        "LD",
        "STR",
        "HALT",
)
COMDICT ={
        "ADD" : ("10","11"),
        "SUB" : ("13",),
        "LAD" : ("","20"),
        "CALL":("60",),
        "DIV" : ("50",),
        "MLT" : ("51",),
        "CPA" : ("30",),
        "JZE" : ("40",),
        "JMP" :( "41",),
        "RET" : ("63",),
        "LD" : ("24","21"),
        "STR" : ("","22"),
        "HALT" : ("64",),
}


if __name__ == '__main__':
    # file open
    try:
        argv = sys.argv
        if len(argv) < 2:
                raise SyntaxError("arg should have asmfile.")
        f = open(argv[-1])
        raw = f.read()
        pgm = raw.split()
        f.close()

    except :
        print("file cant open!")
        sys.exit(-1)
        #pass
    result = []
    labels ={"START":0,}
    #print(pgm)
    current_adr = 0
    i = 0
    token_num = len(pgm)

    while i < token_num:
        # memo label
        if not pgm[i] in KEYWORDS:
            labels[pgm[i]] = current_adr
            i += 1

        if pgm[i] == "HALT" or pgm[i] == "RET" :
            result.append(COMDICT[pgm[i]][0] + "00")
            current_adr += 1
        else:
            com = pgm[i]
            i += 1
            token = pgm[i]
            # r,r
            if token.count("$") == 2:
                gr1,gr2 = token.replace("$", "").split(",")
                result.append(COMDICT[com][0] + gr1 + gr2)
                current_adr += 1
            # r,adr or r,label
            elif token.count("$") == 1:
                gr1,gr2 = token.replace("$", "").split(",")
                result.append(COMDICT[com][1] + gr1 + "0")
                if gr2[0] == "#":
                    result.append(gr2[1:])
                else:
                    result.append(gr2)
                current_adr += 2
            # adr
            elif token.find("#") >= 0 :
                result.append(COMDICT[com][0] +"00")
                result.append(token[1:])
                current_adr += 2
            # label
            else:
                result.append(COMDICT[com][0] +"00")
                result.append(token)
                current_adr += 2

        i += 1

    # conv label to addr
    for (i, word) in enumerate(result):
        if not word.isdigit():
            try:
                addr_dec = labels[word]
                addr_hex = hex(addr_dec)[3:].zfill(4)
                result[i] = addr_hex
            except KeyError as e:
                print("cant convert label to addres!\n")
                print(e)
                sys.exit(-1)

    result_text = ""
    for word in result:
        result_text += '''X"'''
        result_text += word
        result_text += '''",'''
    result_text = result_text[:-1]
    f = open("out.txt",'w')
    f.write(result_text)
    f.close()
    print("コンパイルおっけー😎 😎 😎 \n")
