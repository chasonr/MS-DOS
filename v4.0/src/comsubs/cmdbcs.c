/* cmdbcs.c */

#include <stdlib.h>
#include "doscalls.h"
#include "compriv.h"

#define NUM_RANGES 5

unsigned char dbcsvec[NUM_RANGES*2];
unsigned char *casemap_lo;
unsigned char *casemap_up;

int
com_settbl(void)
{
    static int table_set = 0;
    struct countrycode ccode;
    int rc;
    unsigned char *cptr;
    int i;

    ccode.codepage = 0;
    ccode.country = 0;

    if (table_set == 1) {
        return 0;
    }

    casemap_lo = malloc(256);
    casemap_up = malloc(256);

    rc = DOSGETDBCSEV(NUM_RANGES, &ccode, dbcsvec);
    if (rc != 0) {
        return rc;
    }

    i = 0;
    do {
        casemap_lo[i] = i;
        casemap_up[i] = i;
        ++i;
    } while (i < 256);

    rc = DOSCASEMAP(256, &ccode, casemap_up);
    if (rc != 0) {
        return rc;
    }

    cptr = casemap_up;
    i = 0;
    do {
        if (i != *cptr) {
            casemap_lo[*cptr] = i;
        }
        ++i;
        ++cptr;
    } while (i < 256);
    table_set = 1;
    return 0;
}

int
check_dbcs(unsigned char byte)
{
    unsigned var02;

    var02 = 0;
    do {
        if (dbcsvec[var02*2] == 0 && dbcsvec[var02*2+1] == 0) {
            return 0;
        }
        if (dbcsvec[var02*2] <= byte && byte <= dbcsvec[var02*2+1]) {
            return 1;
        }
        ++var02;
    } while (var02 < NUM_RANGES);
    return -1;
}
