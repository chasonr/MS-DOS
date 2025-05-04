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

all: fastopen.exe

fastopen.ctl fastopen.cl1 fastopen.cl2 fastopen.cla: fastopen.skl  $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG fastopen.skl

fastopen.obj: fastopen.asm \
	$(inc)/fastopen.inc \
	$(inc)/dosmac.inc \
	$(inc)/dirent.inc \
	fastsegs.inc \
	$(inc)/version.inc

fastseek.obj: fastseek.asm \
	$(inc)/fastopen.inc \
	$(inc)/dosmac.inc \
	$(inc)/dirent.inc \
	fastsegs.inc

fastinit.obj: fastinit.asm \
	$(inc)/fastopen.inc \
	$(inc)/dosmac.inc \
	$(inc)/vector.inc \
	$(inc)/filemode.inc \
	$(inc)/mult.inc \
	$(inc)/version.inc \
	fastsegs.inc $(inc)/syscall.inc

fastp.obj: fastp.asm \
	$(inc)/psdata.inc \
	$(inc)/parse.asm

fastsm.obj: fastsm.asm \
	$(inc)/versiona.inc \
	$(inc)/copyrigh.inc \
	$(inc)/sysmsg.inc \
	$(inc)/msgserv.asm \
	$(inc)/msgdcl.inc \
	fastopen.ctl \
	fastopen.cl1 \
	fastopen.cl2 \
	fastopen.cla

OBJS = fastopen.obj fastseek.obj fastinit.obj fastp.obj fastsm.obj

fastopen.exe: $(OBJS) FASTOPEN.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=fastopen.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name fastopen.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f fastopen.cl[12a]
	rm -f fastopen.ctl
	rm -f fastopen.exe
	rm -f fastopen.map
	rm -f resp.txt
