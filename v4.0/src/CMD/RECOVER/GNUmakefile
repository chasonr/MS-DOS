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

all: recover.com

recover.ctl : RECOVER.SKL    \
	     $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\recover $(subst /,\,$<) $(country)"

recover.obj: RECOVER.ASM			  \
	     RECEQU.INC RECMACRO.INC   \
	     RECSEG.INC RECDATA.INC RECPARSE.INC  \
	     RECMSG.INC 			  \
	     recover.ctl recover.cl1		  \
	     recover.cl2 recover.cla		  \
	     $(inc)/dossym.inc $(inc)/syscall.inc \
	     $(inc)/SYSMSG.INC $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\recover $(subst /,\,$<) $(subst /,\,$@)"

recinit.obj: RECINIT.ASM			 \
	     RECEQU.INC RECMACRO.INC  \
	     RECSEG.INC RECDATA.INC RECPARSE.INC \
	     RECMSG.INC 			 \
	     recover.ctl recover.cl1		  \
	     recover.cl2 recover.cla		  \
	     $(inc)/dossym.inc $(inc)/syscall.inc \
	     $(inc)/SYSMSG.INC $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\recover $(subst /,\,$<) $(subst /,\,$@)"


recproc.obj: RECPROC.ASM			 \
	     RECEQU.INC RECMACRO.INC  \
	     RECSEG.INC RECDATA.INC RECPARSE.INC \
	     RECMSG.INC 			 \
	     recover.ctl recover.cl1		  \
	     recover.cl2 recover.cla		  \
	     $(inc)/dossym.inc $(inc)/syscall.inc \
	     $(inc)/SYSMSG.INC $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\recover $(subst /,\,$<) $(subst /,\,$@)"

recdisp.obj: RECDISP.ASM			 \
	     RECEQU.INC RECMACRO.INC  \
	     RECSEG.INC RECDATA.INC RECPARSE.INC \
	     RECMSG.INC 			 \
	     recover.ctl recover.cl1		  \
	     recover.cl2 recover.cla		  \
	     $(inc)/dossym.inc $(inc)/syscall.inc \
	     $(inc)/SYSMSG.INC $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\recover $(subst /,\,$<) $(subst /,\,$@)"

OBJS = recdisp.obj recinit.obj recproc.obj recover.obj

recover.com: $(OBJS) RECOVER.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\recover @recover.lnk"
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\recover\recover.exe"

clean:
	rm -f *.obj
	rm -f recover.com
	rm -f recover.cl[12a]
	rm -f recover.ctl
	rm -f recover.exe
	rm -f recover.map
	rm -f resp.txt
