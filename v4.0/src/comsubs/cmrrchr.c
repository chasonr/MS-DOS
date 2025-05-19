/* cmrrchr.c */

#include <stddef.h> /* @#$% Microsoft C doesn't define NULL in string.h */
#include <string.h>
#include "comsub.h"
#include "compriv.h"

/* static const char *sccs_id = "@(#)cmrrchr.c	1.1 86/06/17"; */

unsigned char *
com_strrchr(unsigned char *str1, unsigned char chr)
{
    char str2[2];
    size_t len1;
    size_t len2;

    com_settbl();

    str2[0] = chr;
    str2[1] = '\0';

    len1 = strlen(str1);
    len2 = strlen(str2);

    if (len2 > len1) {
        /* A shorter string cannot include a longer one */
        return NULL;
    } else {
        size_t i1 = len1 - len2; /* Current position matching str1 to start of str2 */
        while (1) {
            /* Does the current position match the start of str2? */
            if (str2[0] == str1[i1]) {
                /* Don't match on the second half of a double-byte character */
                if (i1 == 0 || check_dbcs(str1[i1-1]) != 1) {
                    size_t i1a = i1;       /* Current position matching str1 */
                    size_t i2 = 0;         /* Current position matching str2 */
                    size_t remain = len2;  /* How much left in str2 */
                    while (remain > 0) {
                        if (str1[i1a] == str2[i2]) {
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
            if (i1 == 0) {
                /* No match */
                return NULL;
            }
            --i1;
        }
    }
}
