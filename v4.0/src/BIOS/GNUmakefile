#************************** makefile for bios ***************************

dest = io
msg	= ../MESSAGES
inc	= ../INC
dos = ../DOS

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

SMDOSSYM_INC = $(inc)/smdossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
               $(inc)/buffer.inc $(inc)/curdir.inc $(inc)/dirent.inc \
               $(inc)/doscntry.inc $(inc)/dosmac.inc $(inc)/dpb.inc \
               $(inc)/exe.inc $(inc)/intnat.inc $(inc)/mi.inc $(inc)/pdb.inc \
               $(inc)/sf.inc $(inc)/syscall.inc $(inc)/sysvar.inc \
               $(inc)/vector.inc $(inc)/versiona.inc $(inc)/version.inc

all: $(dest).sys

msbio.cl1 msbio.cl2 msbio.cl3 msbio.cl4 msbio.cl5: msbio.skl \
	$(msg)/$(country).msg
	../bldtools/buildmsg.rb $(msg)/$(country).msg msbio.skl

msload.obj: msload.asm \
	msbio.cl1 \
	$(inc)/bootform.inc \
	$(inc)/versiona.inc \
	msload.inc

MSLOAD_OBJS = msload.obj

msload.com: $(MSLOAD_OBJS)
	echo 'system dos com' >resp.txt
	echo 'option map=msload.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msload.com' >>resp.txt
	for x in $(MSLOAD_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

msbio1.obj: msbio1.asm \
   	msbdata.inc \
	msgroup.inc \
	jumpmac.inc \
	pushpop.inc \
	$(inc)/devsym.inc \
	msdskpr.inc \
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
	msequ.inc \
	$(inc)/msbds.inc \
	msmacro.inc \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc $(inc)/bpb.inc

msclock.obj: msclock.asm \
	msgroup.inc \
	msmacro.inc

msdisk.obj: msdisk.asm \
	msgroup.inc \
	msequ.inc \
	$(inc)/msbds.inc \
	pushpop.inc \
	msmacro.inc \
	$(inc)/devsym.inc \
	msdskpr.inc \
	biostruc.inc \
	msioctl.inc $(inc)/ioctl.inc $(inc)/bpb.inc

msinit.obj: msinit.asm \
	msgroup.inc \
	msdskpr.inc  \
	msequ.inc $(inc)/msbds.inc \
	$(inc)/cputype.inc \
	msmacro.inc   \
	readcloc.inc  \
	clocksub.inc   \
	msextrn.inc \
	biostruc.inc \
	cmosequ.inc \

sysinit1.obj: sysinit1.asm \
	msstack.inc \
	msbio.cl4 \
	msbio.cl5 \
	stkinit.inc \
	devmark.inc \
    biostruc.inc \
    defems.inc \
	$(inc)/smifssym.inc \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc \
	$(inc)/cputype.inc \
    $(SMDOSSYM_INC)

sysconf.obj: sysconf.asm \
	psoption.inc \
	devmark.inc \
	biostruc.inc \
	$(inc)/psdata.inc \
	$(inc)/parse.asm \
	$(inc)/smifssym.inc \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc \
    $(SMDOSSYM_INC)


sysinit2.obj: sysinit2.asm \
	devmark.inc \
	$(inc)/copyrigh.inc \
	$(inc)/devsym.inc \
	$(inc)/ioctl.inc \
    $(SMDOSSYM_INC)

sysimes.obj: sysimes.asm \
	msmacro.inc \
	msbio.cl3 \
	msequ.inc $(inc)/msbds.inc

msbio2.obj: msbio2.asm \
	msgroup.inc \
	msequ.inc \
	$(inc)/msbds.inc \
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
	rm -f *.obj
	rm -f *.lst
	rm -f *.err
	rm -f $(dest).sys
	rm -f msbio.cl[1-5]
	rm -f msbio.map
	rm -f msbio.exe
	rm -f msbio.bin
	rm -f msload.map
	rm -f msload.com
	rm -f resp.txt
