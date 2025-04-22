#************************** makefile for cmd/append ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: diskcomp.com

diskcomp.ctl diskcomp.cl1 diskcomp.cl2 diskcomp.cla: DISKCOMP.SKL \
   $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\diskcomp $(subst /,\,$<) $(country)"

diskcomp.obj: DISKCOMP.ASM \
   DCMPMACR.INC \
   $(inc)/bootform.inc \
   DISKCOMP.EQU
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcomp $(subst /,\,$<) $(subst /,\,$@)"

compinit.obj: COMPINIT.ASM \
   DCMPMACR.INC \
   $(inc)/bootform.inc \
   DISKCOMP.EQU
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcomp $(subst /,\,$<) $(subst /,\,$@)"

dcompp.obj: DCOMPP.ASM \
   $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcomp $(subst /,\,$<) $(subst /,\,$@)"

dcompsm.obj: DCOMPSM.ASM \
   $(inc)/sysmsg.inc \
   $(inc)/MSGHAN.INC \
   $(inc)/versiona.inc \
   diskcomp.ctl \
   diskcomp.cla \
   diskcomp.cl1 \
   diskcomp.cl2 \
   DCOMPMS.INC \
   $(inc)/copyrigh.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcomp $(subst /,\,$<) $(subst /,\,$@)"

dcomppar.obj: DCOMPPAR.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcomp $(subst /,\,$<) $(subst /,\,$@)"

OBJS = diskcomp.obj dcompsm.obj dcompp.obj dcomppar.obj compinit.obj

diskcomp.com: $(OBJS) DISKCOMP.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\diskcomp @diskcomp.lnk"
	exe2bin -q diskcomp.exe diskcomp.com
	rm diskcomp.exe

clean:
	rm -f *.obj
	rm -f diskcomp.com
	rm -f diskcomp.cl[12a]
	rm -f diskcomp.ctl
	rm -f resp.txt
