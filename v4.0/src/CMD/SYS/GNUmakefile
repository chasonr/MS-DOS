#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
boot	=../../BOOT
here	=../CMD/SYS

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: sys.com

$(inc)/boot.inc: $(boot)/msboot.asm $(msg)/$(COUNTRY).MSG
	$(MAKE) -C $(boot)

sys.ctl sys.cl1 sys.cl2 sys.cla sys.clb sys.clc sys.cld: SYS.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\sys $(subst /,\,$<) $(country)"

sys1.obj: SYS1.ASM $(inc)/DOSSYM.INC $(inc)/DOSMAC.INC \
    $(inc)/BPB.INC $(inc)/BUFFER.INC $(inc)/SYSVAR.INC \
    $(inc)/MULT.INC $(inc)/DIRENT.INC $(inc)/DPB.INC \
    $(inc)/CURDIR.INC $(inc)/CPMFCB.INC $(inc)/FIND.INC \
    $(inc)/PDB.INC $(inc)/SF.INC $(inc)/ARENA.INC $(inc)/INTNAT.INC \
    $(inc)/ERROR.INC $(inc)/SYSCALL.INC $(inc)/IOCTL.INC \
    $(inc)/BOOTFORM.INC $(inc)/boot.inc SYSHDR.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\sys $(subst /,\,$<) $(subst /,\,$@)"

sys2.obj: SYS2.ASM $(inc)/DOSSYM.INC $(inc)/DOSMAC.INC \
    $(inc)/BPB.INC $(inc)/BUFFER.INC $(inc)/SYSVAR.INC \
    $(inc)/MULT.INC $(inc)/DIRENT.INC $(inc)/DPB.INC \
    $(inc)/CURDIR.INC $(inc)/CPMFCB.INC $(inc)/FIND.INC \
    $(inc)/PDB.INC $(inc)/SF.INC $(inc)/ARENA.INC $(inc)/INTNAT.INC \
    $(inc)/ERROR.INC $(inc)/SYSCALL.INC $(inc)/IOCTL.INC \
    $(inc)/BOOTFORM.INC $(inc)/boot.inc SYSHDR.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\sys $(subst /,\,$<) $(subst /,\,$@)"

syssr.obj: SYSSR.ASM $(inc)/PARSE.ASM \
    $(inc)/PSDATA.INC $(inc)/MSGSERV.ASM $(inc)/SYSMSG.INC \
    sys.ctl sys.cl1 sys.cl2 sys.cla sys.clb sys.clc sys.cld
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\sys $(subst /,\,$<) $(subst /,\,$@)"

OBJS = sys1.obj sys2.obj syssr.obj

sys.com: sys.ctl $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\sys @sys.lnk"
	exe2bin -q sys.exe sys.com
	rm sys.exe

clean:
	rm -f *.obj
	rm -f sys.com
	rm -f sys.cl[12a-d]
	rm -f sys.ctl
	rm -f sys.map
	rm -f resp.txt
