#************************** makefile for bios ***************************

dest = io
msg	= ../MESSAGES
inc	= ../INC
dos = ../DOS

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#.SUFFIXES: .ASM .obj .cl1 .skl
#
#.asm.obj:
#	dosemu --Fdrive_c ${root} -E "c:\src\tools\masm -Mx -t ${extasw} -I. -I${inc} -I${dos} $(subst /,\,$<),$(subst /,\,$@);"
#
#.skl.cl1:
#	dosemu --Fdrive_c ${root} -E "c:\src\tools\nosrvbld $(subst /,\,$<) $(subst /,\,${msg}/${COUNTRY}.msg)"

#
#######################	dependencies begin here. #########################
#

all: $(dest).sys

msbio.cl1 msbio.cl2 msbio.cl3 msbio.cl4 msbio.cl5: MSBIO.SKL \
	$(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../.. -E "src\domsg1.bat src\bios $(subst /,\,$<) $(country);"

msload.obj: MSLOAD.ASM \
	msbio.cl1 \
	$(inc)/BOOTFORM.INC \
	$(inc)/VERSIONA.INC \
	MSLOAD.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

MSLOAD_OBJS = msload.obj

msload.com: $(MSLOAD_OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=msload.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msload.exe' >>resp.txt
	for x in $(MSLOAD_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q msload.exe msload.com

msbio1.obj: MSBIO1.ASM \
   	MSBDATA.INC \
	MSGROUP.INC \
	JUMPMAC.INC \
	PUSHPOP.INC \
	$(inc)/DEVSYM.INC \
	MSDSKPR.INC \
	MSMACRO.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

mscon.obj: MSCON.ASM \
	MSGROUP.INC \
	JUMPMAC.INC \
	MSMACRO.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

msaux.obj: MSAUX.ASM \
	MSGROUP.INC \
	JUMPMAC.INC \
	MSMACRO.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

mslpt.obj: MSLPT.ASM \
	MSGROUP.INC \
	MSEQU.INC \
	$(inc)/MSBDS.INC \
	MSMACRO.INC \
	$(inc)/DEVSYM.INC \
	$(inc)/IOCTL.INC $(inc)/BPB.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

msclock.obj: MSCLOCK.ASM \
	MSGROUP.INC \
	MSMACRO.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

msdisk.obj: MSDISK.ASM \
	MSGROUP.INC \
	MSEQU.INC \
	$(inc)/MSBDS.INC \
	PUSHPOP.INC \
	MSMACRO.INC \
	$(inc)/DEVSYM.INC \
	MSDSKPR.INC \
	MSIOCTL.INC $(inc)/IOCTL.INC $(inc)/BPB.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

msinit.obj: MSINIT.ASM \
	MSGROUP.INC \
	MSDSKPR.INC  \
	MSEQU.INC $(inc)/MSBDS.INC \
	$(inc)/CPUTYPE.INC \
	MSMACRO.INC   \
	READCLOC.INC  \
	CLOCKSUB.INC   \
	MSEXTRN.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"


sysinit1.obj: SYSINIT1.ASM \
	MSSTACK.INC \
	msbio.cl4 \
	msbio.cl5 \
	STKINIT.INC \
	DEVMARK.INC \
	$(inc)/SMIFSSYM.INC \
	$(inc)/DEVSYM.INC \
	$(inc)/IOCTL.INC \
	$(inc)/CPUTYPE.INC \
	$(inc)/SMDOSSYM.INC $(inc)/DOSMAC.INC $(inc)/BPB.INC $(inc)/BUFFER.INC \
	$(inc)/SYSVAR.INC $(inc)/VECTOR.INC $(inc)/DIRENT.INC \
	$(inc)/DPB.INC $(inc)/CURDIR.INC \
	$(inc)/PDB.INC $(inc)/EXE.INC $(inc)/SF.INC $(inc)/ARENA.INC \
	$(inc)/INTNAT.INC $(inc)/MI.INC \
	$(inc)/SYSCALL.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"


sysconf.obj: SYSCONF.ASM \
	PSOPTION.INC \
	DEVMARK.INC \
	$(inc)/PSDATA.INC \
	$(inc)/PARSE.ASM \
	$(inc)/SMIFSSYM.INC \
	$(inc)/DEVSYM.INC \
	$(inc)/IOCTL.INC \
	$(inc)/SMDOSSYM.INC $(inc)/DOSMAC.INC $(inc)/BPB.INC $(inc)/BUFFER.INC \
	$(inc)/SYSVAR.INC $(inc)/VECTOR.INC $(inc)/DIRENT.INC \
	$(inc)/DPB.INC $(inc)/CURDIR.INC \
	$(inc)/PDB.INC $(inc)/EXE.INC $(inc)/SF.INC $(inc)/ARENA.INC \
	$(inc)/INTNAT.INC $(inc)/MI.INC \
	$(inc)/SYSCALL.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

sysinit2.obj: SYSINIT2.ASM \
	DEVMARK.INC \
	$(inc)/COPYRIGH.INC \
	$(inc)/SMIFSSYM.INC \
	$(inc)/DEVSYM.INC \
	$(inc)/IOCTL.INC \
	$(inc)/SMDOSSYM.INC $(inc)/DOSMAC.INC $(inc)/BPB.INC $(inc)/BUFFER.INC \
 	$(inc)/SYSVAR.INC $(inc)/VECTOR.INC $(inc)/DIRENT.INC \
	$(inc)/DPB.INC $(inc)/CURDIR.INC \
	$(inc)/PDB.INC $(inc)/EXE.INC $(inc)/SF.INC $(inc)/ARENA.INC \
	$(inc)/INTNAT.INC $(inc)/MI.INC \
	$(inc)/SYSCALL.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

sysimes.obj: SYSIMES.ASM \
	MSMACRO.INC \
	msbio.cl3 \
	MSEQU.INC $(inc)/MSBDS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

msbio2.obj: MSBIO2.ASM \
	MSGROUP.INC \
	MSEQU.INC \
	$(inc)/MSBDS.INC \
	$(inc)/DEVSYM.INC \
	PUSHPOP.INC \
	MSMACRO.INC \
	msbio.cl2 \
	MS96TPI.INC MSVOLID.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

mshard.obj:  MSHARD.ASM $(inc)/POSTEQU.INC $(inc)/DSEG.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\bios $(subst /,\,$<) $(subst /,\,$@);"

MSBIO_OBJS = msbio1.obj mscon.obj msaux.obj mslpt.obj msclock.obj msdisk.obj \
             msbio2.obj mshard.obj msinit.obj sysinit1.obj sysconf.obj \
             sysinit2.obj sysimes.obj

msbio.bin: $(MSBIO_OBJS)
	dosemu -t --Fdrive_c ../.. -E "src\dolink src\bios @msbio.lnk"
#	echo 'system dos' >resp.txt
#	echo 'option map=msbio.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name msbio.exe' >>resp.txt
#	for x in $(MSBIO_OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt
	exe2bin -q -l=0x0070 msbio.exe msbio.bin

$(dest).sys: msload.com msbio.bin
	cat msload.com msbio.bin > $@

clean:
	rm -f *.obj
	rm -f $(dest).sys
	rm -f msbio.cl[1-5]
	rm -f msbio.map
	rm -f msbio.exe
	rm -f msbio.bin
	rm -f msload.map
	rm -f msload.exe
	rm -f msload.com
	rm -f resp.txt
