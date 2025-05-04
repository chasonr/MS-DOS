#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: xcopy.exe

xcopy.ctl xcopy.cl1 xcopy.cl2 xcopy.cla: xcopy.skl \
   $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG xcopy.skl

xcopy.obj: xcopy.asm \
   $(inc)/versiona.inc \
   $(inc)/copyrigh.inc \
   $(inc)/sysmsg.inc \
   $(inc)/msgserv.asm \
   $(inc)/msgdcl.inc \
   dos.equ \
   xcopy.equ \
   xcopy.ctl \
   xcopy.cl1 \
   xcopy.cl2 \
   xcopy.cla \
   xmainmsg.equ

xcpyinit.obj: xcpyinit.asm \
   $(inc)/versiona.inc \
   $(inc)/copyrigh.inc \
   xcopy.equ \
   dos.equ \
   xinitmsg.equ

xcopypar.obj: xcopypar.asm \
   $(inc)/psdata.inc \
   $(inc)/parse.asm

OBJS = xcopy.obj xcpyinit.obj xcopypar.obj

xcopy.exe: $(OBJS) XCOPY.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=xcopy.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name xcopy.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f xcopy.cl[12a]
	rm -f xcopy.ctl
	rm -f xcopy.exe
	rm -f xcopy.map
	rm -f resp.txt
