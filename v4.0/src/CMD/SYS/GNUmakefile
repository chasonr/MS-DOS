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

sys1.obj: SYS1.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
    $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
    $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
    $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
    $(inc)/pdb.inc $(inc)/sf.inc $(inc)/arena.inc $(inc)/intnat.inc \
    $(inc)/error.inc $(inc)/syscall.inc $(inc)/ioctl.inc \
    $(inc)/bootform.inc $(inc)/boot.inc SYSHDR.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\sys $(subst /,\,$<) $(subst /,\,$@)"

sys2.obj: SYS2.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
    $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
    $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
    $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
    $(inc)/pdb.inc $(inc)/sf.inc $(inc)/arena.inc $(inc)/intnat.inc \
    $(inc)/error.inc $(inc)/syscall.inc $(inc)/ioctl.inc \
    $(inc)/bootform.inc $(inc)/boot.inc SYSHDR.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\sys $(subst /,\,$<) $(subst /,\,$@)"

syssr.obj: SYSSR.ASM $(inc)/parse.asm \
    $(inc)/psdata.inc $(inc)/MSGSERV.ASM $(inc)/SYSMSG.INC \
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
