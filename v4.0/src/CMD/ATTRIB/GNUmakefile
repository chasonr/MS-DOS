#************************** makefile for cmd/append ***************************

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

all: attrib.exe

attrib.ctl attrib.cl1 attrib.cl2 attrib.cla attrib.clb: attrib.skl \
	$(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg attrib.skl

_parse.obj: _parse.asm \
	$(inc)/parse.asm \
	$(inc)/psdata.inc

_msgret.obj: _msgret.asm \
	$(inc)/msgserv.asm \
	$(inc)/sysmsg.inc  \
	$(inc)/copyrigh.inc \
	attrib.ctl \
	attrib.cl1 \
	attrib.cl2 \
	attrib.cla \
	attrib.clb

attriba.obj: attriba.asm

attrib.obj: attrib.c \
	attrib.h \
	parse.h \
	msgret.h

OBJS = attriba.obj attrib.obj _parse.obj _msgret.obj

attrib.exe: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=attrib.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name attrib.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f attrib.cl[12ab]
	rm -f attrib.ctl
	rm -f attrib.exe
	rm -f attrib.map
	rm -f resp.txt
