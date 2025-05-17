#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .c .asm .obj

CC = wcl
CFLAGS = -q -ms -os -zp=1 -I. -wx

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: filesys.exe

filesys.ctl filesys.cl1 filesys.cl2 filesys.cla: filesys.skl \
                $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg filesys.skl

_parse.obj:     _parse.asm              \
                $(inc)/parse.asm        \
                $(inc)/psdata.inc

_msgret.obj:    _msgret.asm             \
                filesys.ctl filesys.cl1 filesys.cl2 filesys.cla \
                $(inc)/msgserv.asm      \
                $(inc)/sysmsg.inc       \
                $(inc)/copyrigh.inc     \
                $(inc)/versiona.inc     \
                $(inc)/msgdcl.inc

filesys.obj:    filesys.c parse.h msgret.h

OBJS = filesys.obj _parse.obj _msgret.obj

filesys.exe: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=filesys.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name filesys.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f filesys.cl[12a]
	rm -f filesys.ctl
	rm -f filesys.exe
	rm -f filesys.map
	rm -f resp.txt
