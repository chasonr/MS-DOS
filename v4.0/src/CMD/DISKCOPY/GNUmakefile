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

all: diskcopy.com

diskcopy.ctl diskcopy.cl1 diskcopy.cl2 diskcopy.cla: diskcopy.skl \
   $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg diskcopy.skl

diskcopy.obj: diskcopy.asm \
   dcpymacr.inc \
   diskcopy.equ \
   $(inc)/pathmac.inc \
   $(inc)/bootform.inc

copyinit.obj: copyinit.asm \
   dcpymacr.inc \
   $(inc)/pathmac.inc \
   diskcopy.equ

dcopyp.obj: dcopyp.asm \
   $(inc)/psdata.inc \
   $(inc)/parse.asm $(inc)/psdata.inc

dcopysm.obj: dcopysm.asm \
   $(inc)/pathmac.inc \
   $(inc)/sysmsg.inc \
   $(inc)/msgserv.asm \
   $(inc)/msghan.inc \
   $(inc)/versiona.inc \
   diskcopy.ctl \
   diskcopy.cla \
   diskcopy.cl1 \
   diskcopy.cl2 \
   dcopyms.inc \
   $(inc)/copyrigh.inc

dcopypar.obj: dcopypar.asm $(inc)/pathmac.inc

OBJS = diskcopy.obj dcopysm.obj dcopyp.obj dcopypar.obj copyinit.obj

diskcopy.com: $(OBJS) DISKCOPY.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=diskcopy.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name diskcopy.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q diskcopy.exe diskcopy.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f diskcopy.com
	rm -f diskcopy.exe
	rm -f diskcopy.map
	rm -f diskcopy.cl[12a]
	rm -f diskcopy.ctl
	rm -f resp.txt
