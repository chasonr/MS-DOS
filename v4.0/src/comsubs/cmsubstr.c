/* cmsubstr.c */

#include <stddef.h> /* @#$% Microsoft C doesn't define NULL in string.h */
#include <string.h>
#include "comsub.h"
#include "compriv.h"

/* static const char *sccs_id = "@(#)cmsubstr.c	1.1 86/06/17"; */

unsigned char *
com_substr(unsigned char *str1, unsigned char *str2)
{
    size_t len1;
    size_t len2;

    com_settbl();

    len1 = strlen((char const *)str1);
    len2 = strlen((char const *)str2);

    if (len2 > len1) {
        /* A shorter string cannot include a longer one */
        return NULL;
    } else {
        size_t i1 = 0; /* Current position matching str1 to start of str2 */
        while (1) {
            if (len1 - len2 + 1 <= i1) {
                /* Not enough left in str1 for a match */
                return NULL;
            }
            /* Does the current position match the start of str2? */
            if (str1[i1] == str2[0]) {
                /* Don't match on the second half of a double-byte character */
                if (i1 == 0 || check_dbcs(str1[i1-1]) != 1) {
                    size_t i1a = i1;       /* Current position matching str1 */
                    size_t i2 = 0;         /* Current position matching str2 */
                    size_t remain = len2;  /* How much left in str2 */
                    while (remain > 0) {
                        if (str2[i2] == str1[i1a]) {
                            --remain;
                            ++i1a;
                            ++i2;
                        } else {
                            /* No match at i1 */
                            break;
                        }
                    }
                    if (remain == 0) {
                        /* All of str2 matched */
                        return str1 + i1;
                    }
                }
            }
            /* str1+i1 didn't match; try the next position */
            ++i1;
        }
    }
}
