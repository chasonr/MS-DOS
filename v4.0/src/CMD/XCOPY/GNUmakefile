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

all: xcopy.exe

xcopy.ctl xcopy.cl1 xcopy.cl2 xcopy.cla: XCOPY.SKL \
   $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\xcopy $(subst /,\,$<) $(country)"

xcopy.obj: XCOPY.ASM \
   $(inc)/VERSIONA.INC \
   $(inc)/COPYRIGH.INC \
   $(inc)/SYSMSG.INC \
   $(inc)/MSGSERV.ASM \
   DOS.EQU \
   XCOPY.EQU \
   xcopy.ctl \
   xcopy.cl1 \
   xcopy.cl2 \
   xcopy.cla \
   XMAINMSG.EQU
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\xcopy $(subst /,\,$<) $(subst /,\,$@)"

xcpyinit.obj: XCPYINIT.ASM \
   $(inc)/VERSIONA.INC \
   XCOPY.EQU \
   DOS.EQU \
   XINITMSG.EQU
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\xcopy $(subst /,\,$<) $(subst /,\,$@)"

xcopypar.obj: XCOPYPAR.ASM \
   $(inc)/PSDATA.INC \
   $(inc)/PARSE.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\xcopy $(subst /,\,$<) $(subst /,\,$@)"

OBJS = xcopy.obj xcpyinit.obj xcopypar.obj

xcopy.exe: $(OBJS) XCOPY.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\xcopy @xcopy.lnk"

clean:
	rm -f *.obj
	rm -f xcopy.cl[12a]
	rm -f xcopy.ctl
	rm -f xcopy.exe
	rm -f resp.txt
