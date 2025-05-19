/* structure of a CDS */

#define DIRSTRLEN   64+3

struct CDSType
{
        char            text[DIRSTRLEN] ;
        unsigned        flags ;
        long            pDPB ;
        long            ID ;
        unsigned        wUser ;
        unsigned        cbEnd ;
        char            type ;
        long            ifs_hdr ;
        char            fsda[2] ;
} ;

#define CDSNET          0x8000
#define CDSINUSE        0x4000
#define CDSSPLICE       0x2000
#define CDSLOCAL        0x1000

char fGetCDS(int i, struct CDSType *pLCDS);
char fPutCDS(int i, struct CDSType *pLCDS);
char fPhysical(int i);
char fNet(int i);
char fShared(int i);
