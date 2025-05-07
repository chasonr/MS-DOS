/* error.c - return text of error corresponding to the most recent DOS error */

#include <stdlib.h>
#include "tools.h"

extern char UnKnown[];

char *error ()
{
    if (errno < 0 || errno >= sys_nerr)
	return UnKnown;
    else
	return sys_errlist[errno];
}
