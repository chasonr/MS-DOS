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

all: replace.exe

replace.ctl replace.cl1 replace.cl2 replace.cla: replace.skl \
  $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg replace.skl

_msgret.obj: _msgret.asm \
  $(inc)/msgserv.asm    \
  $(inc)/sysmsg.inc     \
  $(inc)/copyrigh.inc   \
  $(inc)/versiona.inc   \
  $(inc)/msgdcl.inc     \
  replace.ctl           \
  replace.cla           \
  replace.cl1           \
  replace.cl2

_parse.obj: _parse.asm  \
  $(inc)/parse.asm      \
  $(inc)/psdata.inc

_replace.obj: _replace.asm

replace.obj: replace.c  \
  replacep.h            \
  $(hinc)/comsub.h

OBJS = replace.obj _replace.obj _msgret.obj _parse.obj

replace.exe: $(OBJS) \
  $(map)/mapper.lib     \
  $(comsubs)/comsubs.lib
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=replace.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name replace.exe' >>resp.txt
	echo "library $(comsubs)/comsubs.lib" >>resp.txt
	echo "library $(map)/mapper.lib" >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f replace.cl[12a]
	rm -f replace.ctl
	rm -f replace.exe
	rm -f replace.map
	rm -f resp.txt
