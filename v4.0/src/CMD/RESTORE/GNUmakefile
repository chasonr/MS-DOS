#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
comsubs = ../../comsubs
hinc	=../../H

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .c .asm .obj

CC = wcl
CFLAGS = -q -ms -os -zp=1 -I$(hinc) -wx

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

map	=../../MAPPER

all: restore.com

#-------BUILD MAPPER ----------------
$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

restore.ctl restore.cl1 restore.cl2 restore.cla:	restore.skl			\
		$(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg restore.skl

_parse.obj :	_parse.asm			\
		$(inc)/parse.asm		\
		$(inc)/psdata.inc

_msgret.obj:	_msgret.asm			\
		restore.ctl			\
		restore.cl1 restore.cl2 restore.cla \
		$(inc)/msgserv.asm		\
		$(inc)/sysmsg.inc		\
		$(inc)/copyrigh.inc		\
		$(inc)/versiona.inc		\
		$(inc)/msgdcl.inc

restore.obj :	restore.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtt1.obj :	rtt1.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtt3.obj :	rtt3.c rt.h rt1.h rt2.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtdo.obj :	rtdo.c	rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtdo1.obj :	rtdo1.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtnew.obj :	rtnew.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtnew1.obj :	rtnew1.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtold.obj :	rtold.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtold1.obj :	rtold1.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtfile.obj  :	rtfile.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

rtfile1.obj :	rtfile1.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

restpars.obj :	restpars.c rt.h rt1.h rt2.h restpars.h \
		$(hinc)/comsub.h    $(hinc)/doscalls.h	     \
		$(hinc)/error.h

OBJS = restore.obj restpars.obj rtt1.obj rtt3.obj rtdo.obj rtdo1.obj \
       rtold.obj rtold1.obj rtnew.obj rtnew1.obj rtfile.obj rtfile1.obj \
       _parse.obj _msgret.obj

restore.com: $(OBJS) $(map)/mapper.lib $(comsubs)/comsubs.lib
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=restore.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name restore.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	echo "library $(map)/mapper.lib" >>resp.txt
	echo "library $(comsubs)/comsubs.lib" >>resp.txt
	wlink @resp.txt
	../../bldtools/make-com.rb restore.exe restore.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f restore.com
	rm -f restore.exe
	rm -f restore.cl[12a]
	rm -f restore.ctl
	rm -f restore.map
	rm -f resp.txt
