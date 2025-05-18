/* cmupper.c */

#include "comsub.h"
#include "compriv.h"

static const char *sccs_id = "@(#)cmupper.c	1.1 86/06/17";

int
com_toupper(unsigned char ch)
{
    com_settbl();
    return casemap_up[ch];
}
