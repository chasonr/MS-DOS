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

all: diskcopy.com

diskcopy.ctl diskcopy.cl1 diskcopy.cl2 diskcopy.cla: DISKCOPY.SKL \
   $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\diskcopy $(subst /,\,$<) $(country)"

diskcopy.obj: DISKCOPY.ASM \
   DCPYMACR.INC \
   DISKCOPY.EQU \
   $(inc)/bootform.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcopy $(subst /,\,$<) $(subst /,\,$@)"

copyinit.obj: COPYINIT.ASM \
   DCPYMACR.INC \
   DISKCOPY.EQU
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcopy $(subst /,\,$<) $(subst /,\,$@)"

dcopyp.obj: DCOPYP.ASM \
   $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcopy $(subst /,\,$<) $(subst /,\,$@)"

dcopysm.obj: DCOPYSM.ASM \
   $(inc)/SYSMSG.INC \
   $(inc)/MSGHAN.INC \
   $(inc)/versiona.inc \
   diskcopy.ctl \
   diskcopy.cla \
   diskcopy.cl1 \
   diskcopy.cl2 \
   DCOPYMS.INC \
   $(inc)/copyrigh.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcopy $(subst /,\,$<) $(subst /,\,$@)"

dcopypar.obj: DCOPYPAR.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\diskcopy $(subst /,\,$<) $(subst /,\,$@)"

OBJS = diskcopy.obj dcopysm.obj dcopyp.obj dcopypar.obj copyinit.obj

diskcopy.com: $(OBJS) DISKCOPY.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\diskcopy @diskcopy.lnk"
	exe2bin -q diskcopy.exe diskcopy.com
	rm diskcopy.exe

clean:
	rm -f *.obj
	rm -f diskcopy.com
	rm -f diskcopy.cl[12a]
	rm -f diskcopy.ctl
	rm -f resp.txt
