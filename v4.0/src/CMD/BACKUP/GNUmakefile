#************************** makefile for cmd/backup ***************************

cflags	= -AS -Od -Zp $(extcsw)
msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
comsubs = ../../comsubs
hinc	=../../H
map	=../../MAPPER

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

all: backup.com

$(map)/mapper.lib:
	$(MAKE) -C $(map)/mapper.lib

backup.ctl backup.cl1 backup.cl2 backup.cla:	backup.skl			\
		$(msg)/$(country).msg		
	../../bldtools/buildmsg.rb $(msg)/$(country).msg backup.skl

_parse.obj:	_parse.asm			\
		$(inc)/parse.asm		\
		$(inc)/psdata.inc       \
		$(inc)/version.inc

_msgret.obj:	_msgret.asm			\
		backup.ctl backup.cl1 backup.cl2 backup.cla \
		$(inc)/msgserv.asm		\
		$(inc)/sysmsg.inc		\
		$(inc)/msgdcl.inc		\
		$(inc)/versiona.inc		\
		$(inc)/copyrigh.inc

backup.obj:  backup.c  backpars.h backup.h  \
	     $(hinc)/comsub.h $(hinc)/doscalls.h $(hinc)/version.h

OBJS = backup.obj _parse.obj _msgret.obj

backup.com: $(OBJS) $(map)/mapper.lib $(comsubs)/comsubs.lib
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=backup.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name backup.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	echo "library $(comsubs)/comsubs.lib" >>resp.txt
	echo "library $(map)/mapper.lib" >>resp.txt
	wlink @resp.txt
	../../bldtools/make-com.rb backup.exe backup.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f backup.com
	rm -f backup.exe
	rm -f backup.cl[12a]
	rm -f backup.ctl
	rm -f backup.map
	rm -f resp.txt
