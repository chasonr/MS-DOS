# Makefile for COMSUBS.LIB

LIB = comsubs.lib
INC = ../H

all: $(LIB)

.SUFFIXES: .c .obj

CC = wcl
CFLAGS = -q -ms -os -zp=1 -I$(INC) -wx

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

rctomid.obj : rctomid.c

cmdbcs.obj : cmdbcs.c compriv.h $(INC)/doscalls.h

cmrrchr.obj : cmrrchr.c compriv.h $(INC)/comsub.h

cmstrchr.obj : cmstrchr.c compriv.h $(INC)/comsub.h

cmsubstr.obj : cmsubstr.c compriv.h $(INC)/comsub.h

cmupper.obj : cmupper.c compriv.h $(INC)/comsub.h

OBJS = rctomid.obj cmdbcs.obj cmrrchr.obj \
       cmstrchr.obj cmsubstr.obj cmupper.obj

$(LIB) : $(OBJS)
	@rm -f $(LIB)
	for x in $(OBJS); do wlib -q $(LIB) +$$x; done

clean:
	@rm -f $(LIB) $(subst .lib,.bak,$(LIB)) *.obj *.err
