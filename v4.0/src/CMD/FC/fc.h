struct lineType {
    int     line;                       /* line number                       */
    unsigned char    text[MAXARG];              /* body of line                      */
};

#define byte  unsigned char
#define word  unsigned short

#define LOWVERSION   0x0300 + 10
#define HIGHVERSION  0x0400 + 00

#define ISSPACE(c)     isspace((c) & 0xFF)
