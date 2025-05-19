#************************ makefile for cmd/subst *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
comsubs = ../../comsubs
hinc	=../../H
map	=../../MAPPER
here	=../CMD/SUBST	  # This is the path from INC or MAP dir's to here.

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

all: subst.exe

$(inc)/errtst.obj:
	$(MAKE) -C $(inc) errtst.obj

$(inc)/sysvar.obj:
	$(MAKE) -C $(inc) sysvar.obj

$(inc)/cds.obj:
	$(MAKE) -C $(inc) cds.obj

$(inc)/dpb.obj:
	$(MAKE) -C $(inc) dpb.obj

$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

subst.ctl subst.cl1 subst.cl2 subst.cla: subst.skl    \
  $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg subst.skl

_msgret.obj: _msgret.asm \
  $(inc)/msgserv.asm    \
  $(inc)/sysmsg.inc     \
  $(inc)/copyrigh.inc   \
  $(inc)/versiona.inc   \
  $(inc)/msgdcl.inc     \
  subst.ctl             \
  subst.cla             \
  subst.cl1             \
  subst.cl2

_parse.obj: _parse.asm  \
  $(inc)/parse.asm      \
  $(inc)/psdata.inc

subst.obj: subst.c      \
  substpar.h            \
  $(hinc)/cds.h          \
  $(hinc)/dpb.h          \
  $(hinc)/jointype.h     \
  $(hinc)/sysvar.h       \
  $(hinc)/errtst.h

OBJS = subst.obj $(inc)/errtst.obj $(inc)/sysvar.obj $(inc)/cds.obj \
       $(inc)/dpb.obj _msgret.obj _parse.obj

subst.exe: $(OBJS) $(map)/mapper.lib $(comsubs)/comsubs.lib
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=subst.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name subst.exe' >>resp.txt
	echo "library $(comsubs)/comsubs.lib" >>resp.txt
	echo "library $(map)/mapper.lib" >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f subst.cl[12a]
	rm -f subst.ctl
	rm -f subst.exe
	rm -f resp.txt
