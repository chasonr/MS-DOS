#************************** makefile for cmd/append ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: diskcomp.com

diskcomp.ctl diskcomp.cl1 diskcomp.cl2 diskcomp.cla: diskcomp.skl \
   $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg diskcomp.skl

diskcomp.obj: diskcomp.asm \
   dcmpmacr.inc \
   $(inc)/pathmac.inc \
   $(inc)/bootform.inc \
   diskcomp.equ

compinit.obj: compinit.asm \
   dcmpmacr.inc \
   $(inc)/pathmac.inc \
   $(inc)/bootform.inc \
   diskcomp.equ

dcompp.obj: dcompp.asm \
   $(inc)/pathmac.inc \
   $(inc)/psdata.inc \
   $(inc)/parse.asm

dcompsm.obj: dcompsm.asm \
   $(inc)/sysmsg.inc \
   $(inc)/msghan.inc \
   $(inc)/versiona.inc \
   $(inc)/pathmac.inc \
   $(inc)/msgserv.asm \
   $(inc)/msgdcl.inc\
   diskcomp.ctl \
   diskcomp.cla \
   diskcomp.cl1 \
   diskcomp.cl2 \
   dcompms.inc \
   $(inc)/copyrigh.inc

dcomppar.obj: dcomppar.asm $(inc)/pathmac.inc

OBJS = diskcomp.obj dcompsm.obj dcompp.obj dcomppar.obj compinit.obj

diskcomp.com: $(OBJS) DISKCOMP.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=diskcomp.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name diskcomp.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q diskcomp.exe diskcomp.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f diskcomp.com
	rm -f diskcomp.exe
	rm -f diskcomp.map
	rm -f diskcomp.cl[12a]
	rm -f diskcomp.ctl
	rm -f resp.txt
