#************************** makefile for bios ***************************

dest = io
msg  = ../messages
inc  = ../inc

COUNTRY = usa-ms

AS = jwasm
ASFLAGS = -q -Zm -Zg -I$(inc) -Fl

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

.asm.obj:
	$(AS) $(ASFLAGS) -Fo$@ $<

SMDOSSYM_INC = \
	$(inc)/smdossym.inc \
	$(inc)/dosmac.inc \
	$(inc)/versiona.inc \
	$(inc)/bpb.inc \
	$(inc)/buffer.inc \
	$(inc)/sysvar.inc \
	$(inc)/version.inc \
	$(inc)/vector.inc \
	$(inc)/dirent.inc \
	$(inc)/dpb.inc \
	$(inc)/curdir.inc \
	$(inc)/pdb.inc \
	$(inc)/exe.inc \
	$(inc)/sf.inc \
	$(inc)/arena.inc \
	$(inc)/intnat.inc \
	$(inc)/mi.inc \
	$(inc)/syscall.inc \
	$(inc)/doscntry.inc

all: $(dest).sys

msbio.cl1: msbio.cl1.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

msbio.cl2: msbio.cl2.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

msbio.cl3: msbio.cl3.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

msbio.cl4: msbio.cl4.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

msbio.cl5: msbio.cl5.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

msload.obj: msload.asm \
	msload.inc \
	$(inc)/bootform.inc \
	$(inc)/versiona.inc \
	msbio.cl1

MSLOAD_OBJS = msload.obj

msload.com: $(MSLOAD_OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=msload.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msload.exe' >>resp.txt
	for x in $(MSLOAD_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q msload.exe msload.com

msbio1.obj: msbio1.asm \
	msgroup.inc \
	jumpmac.inc \
	pushpop.inc \
	$(inc)/devsym.inc \
	msdskpr.inc \
	msbdata.inc \
	msmacro.inc

mscon.obj: mscon.asm \
	msgroup.inc \
	jumpmac.inc \
	msequ.inc $(inc)/msbds.inc \
	msmacro.inc

msaux.obj: msaux.asm \
	msgroup.inc \
	jumpmac.inc \
	msmacro.inc

mslpt.obj: mslpt.asm \
	msgroup.inc \
	msequ.inc $(inc)/msbds.inc \
	msmacro.inc \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc $(inc)/bpb.inc

msclock.obj: msclock.asm \
	msgroup.inc \
	msmacro.inc

msdisk.obj: msdisk.asm \
	msgroup.inc \
	msequ.inc $(inc)/msbds.inc \
	pushpop.inc \
	msmacro.inc \
	$(inc)/devsym.inc \
	msdskpr.inc \
	msioctl.inc $(inc)/ioctl.inc $(inc)/bpb.inc

msinit.obj: msinit.asm \
	msgroup.inc \
	msdskpr.inc  \
	msequ.inc $(inc)/msbds.inc \
	msmacro.inc   \
	msextrn.inc \
	biostruc.inc \
	cmosequ.inc \
	$(inc)/cputype.inc \
	readcloc.inc  \
	clocksub.inc


sysinit1.obj: sysinit1.asm \
	$(SMDOSSYM_INC) \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc $(inc)/bpb.inc \
	biostruc.inc \
	$(inc)/smifssym.inc \
	defems.inc \
	devmark.inc \
	$(inc)/cputype.inc \
	$(inc)/version.inc \
	msstack.inc \
	msbio.cl5 \
	msbio.cl4 \
	stkinit.inc


sysconf.obj: sysconf.asm \
	$(SMDOSSYM_INC) \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc $(inc)/bpb.inc \
	biostruc.inc \
	$(inc)/smifssym.inc \
	devmark.inc \
	$(inc)/version.inc \
	psoption.inc \
	$(inc)/parse.asm $(inc)/psdata.inc

sysinit2.obj: sysinit2.asm \
	$(SMDOSSYM_INC) \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc $(inc)/bpb.inc \
	devmark.inc \
	$(inc)/copyrigh.inc

sysimes.obj: sysimes.asm \
	msequ.inc $(inc)/msbds.inc \
	msmacro.inc \
	msbio.cl3

msbio2.obj: msbio2.asm \
	msgroup.inc \
	msequ.inc \
	$(inc)/devsym.inc \
	pushpop.inc \
	msmacro.inc \
	msbio.cl2 \
	ms96tpi.inc msvolid.inc

mshard.obj:  mshard.asm

MSBIO_OBJS = msbio1.obj mscon.obj msaux.obj mslpt.obj msclock.obj msdisk.obj \
             msbio2.obj mshard.obj msinit.obj sysinit1.obj sysconf.obj \
             sysinit2.obj sysimes.obj

msbio.bin: $(MSBIO_OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=msbio.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msbio.exe' >>resp.txt
	for x in $(MSBIO_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q -l=0x0070 msbio.exe msbio.bin

$(dest).sys: msload.com msbio.bin
	cat msload.com msbio.bin > $@

clean:
	rm -f *.obj *.err *.lst
	rm -f io.sys
	rm -f msbio.map
	rm -f msload.exe
	rm -f msload.map
	rm -f msbio.cl1
	rm -f msbio.cl2
	rm -f msbio.cl3
	rm -f msbio.cl4
	rm -f msbio.cl5
	rm -f msload.com
	rm -f msbio.bin
	rm -f msbio.exe
	rm -f resp.txt
