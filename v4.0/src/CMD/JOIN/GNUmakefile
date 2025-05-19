#************************* makefile for cmd/join ************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
comsubs = ../../comsubs
hinc	=../../H
map	=../../MAPPER
# This is the path from INC or MAP dir's to here.
here	=../CMD/JOIN

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

all: join.exe

$(inc)/errtst.obj:
	$(MAKE) -C $(inc) errtst.obj

$(inc)/sysvar.obj:
	$(MAKE) -C $(inc) sysvar.obj

$(inc)/cds.obj:
	$(MAKE) -C $(inc) cds.obj

$(inc)/dpb.obj:
	$(MAKE) -C $(inc) dpb.obj

$(inc)/comsubs.lib:
	$(MAKE) -C $(inc) comsubs.lib

$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

join.ctl join.cl1 join.cl2 join.cla: join.skl      \
  $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg join.skl

_msgret.obj: _msgret.asm \
  $(inc)/msgserv.asm    \
  $(inc)/sysmsg.inc     \
  $(inc)/versiona.inc   \
  $(inc)/copyrigh.inc   \
  $(inc)/msgdcl.inc     \
  join.ctl              \
  join.cla              \
  join.cl1              \
  join.cl2

_parse.obj: _parse.asm  \
  $(inc)/parse.asm      \
  $(inc)/psdata.inc

join.obj: join.c        \
  joinpars.h            \
  $(hinc)/cds.h          \
  $(hinc)/jointype.h     \
  $(hinc)/sysvar.h       \
  $(hinc)/errtst.h

OBJS = join.obj $(inc)/errtst.obj $(inc)/sysvar.obj $(inc)/cds.obj \
       $(inc)/dpb.obj _msgret.obj _parse.obj

join.exe: $(OBJS) $(map)/mapper.lib $(comsubs)/comsubs.lib
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=join.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name join.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	echo "library $(comsubs)/comsubs.lib" >>resp.txt
	echo "library $(map)/mapper.lib" >>resp.txt
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f join.cl[12a]
	rm -f join.ctl
	rm -f join.exe
	rm -f resp.txt
