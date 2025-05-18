/* cmstrchr.c */

#include <stddef.h>
#include "compriv.h"

static const char *sccs_id = "@(#)cmstrchr.c	1.1 86/06/17";

char *
com_strchr(
        unsigned char *str, /* a source string */
        unsigned char chr)  /* a character to be searched */
{
    size_t i = 0;

    com_settbl();
    while (1) {
        unsigned char chr2 = str[i];
        if (chr2 == '\0') {
            /* End of string */
            break;
        }
        if (chr2 == chr) {
            /* Match found */
            return str + i;
        }
        if (check_dbcs(chr2) == 1) {
            /* Don't match on second byte of double byte character */
            ++i;
        }
        ++i;
    }

    /* If we get here, we reached the end of the string */
    if (chr == '\0') {
        /* Return end of string if searching for '\0' */
        return str + i;
    } else {
        /* Else no match */
        return NULL;
    }
}
