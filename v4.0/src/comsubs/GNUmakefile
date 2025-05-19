# Makefile for COMSUBS.LIB

LIB = comsubs.lib
MLIB = comsubsm.lib
INC = ../H

all: $(LIB) $(MLIB)

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
	@rm -f $(MLIB) $(subst .lib,.bak,$(MLIB))

##############################################################################

# Version of comsubs.lib built with the Microsoft compiler, for temporary
# use while various programs still use that compiler

rctomidm.obj : rctomid.c
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\comsubs $(subst /,\,$<) $(subst /,\,$@)"

cmdbcsm.obj : cmdbcs.c compriv.h $(INC)/doscalls.h
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\comsubs $(subst /,\,$<) $(subst /,\,$@)"

cmrrchrm.obj : cmrrchr.c compriv.h $(INC)/comsub.h
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\comsubs $(subst /,\,$<) $(subst /,\,$@)"

cmstrchm.obj : cmstrchr.c compriv.h $(INC)/comsub.h
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\comsubs $(subst /,\,$<) $(subst /,\,$@)"

cmsubstm.obj : cmsubstr.c compriv.h $(INC)/comsub.h
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\comsubs $(subst /,\,$<) $(subst /,\,$@)"

cmupperm.obj : cmupper.c compriv.h $(INC)/comsub.h
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\comsubs $(subst /,\,$<) $(subst /,\,$@)"

MOBJS = rctomidm.obj cmdbcsm.obj cmrrchrm.obj \
        cmstrchm.obj cmsubstm.obj cmupperm.obj

$(MLIB) : $(MOBJS)
	@rm -f $(MLIB)
	for x in $(MOBJS); do wlib -q $(MLIB) +$$x; done
