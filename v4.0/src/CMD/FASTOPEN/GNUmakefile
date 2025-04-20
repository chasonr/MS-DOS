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

all: fastopen.exe

fastopen.ctl fastopen.cl1 fastopen.cl2 fastopen.cla: FASTOPEN.SKL  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\fastopen $(subst /,\,$<) $(country)"

fastopen.obj: FASTOPEN.ASM $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fastopen $(subst /,\,$<) $(subst /,\,$@)"

fastseek.obj: FASTSEEK.ASM $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fastopen $(subst /,\,$<) $(subst /,\,$@)"

fastinit.obj: FASTINIT.ASM $(inc)/DOSSYM.INC $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fastopen $(subst /,\,$<) $(subst /,\,$@)"

fastp.obj: FASTP.ASM \
	$(inc)/PSDATA.INC \
	$(inc)/PARSE.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fastopen $(subst /,\,$<) $(subst /,\,$@)"

fastsm.obj: FASTSM.ASM \
	$(inc)/VERSIONA.INC \
	$(inc)/COPYRIGH.INC \
	$(inc)/SYSMSG.INC \
	$(inc)/MSGSERV.ASM \
	fastopen.ctl \
	fastopen.cl1 \
	fastopen.cl2 \
	fastopen.cla
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fastopen $(subst /,\,$<) $(subst /,\,$@)"

OBJS = fastopen.obj fastseek.obj fastinit.obj fastp.obj fastsm.obj

fastopen.exe: $(OBJS) FASTOPEN.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\fastopen @fastopen.lnk"

clean:
	rm -f *.obj
	rm -f fastopen.cl[12a]
	rm -f fastopen.ctl
	rm -f fastopen.exe
	rm -f fastopen.map
	rm -f resp.txt
