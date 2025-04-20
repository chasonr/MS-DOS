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

all: nlsfunc.exe

nlsfunc.ctl nlsfunc.cl1 nlsfunc.cl2 nlsfunc.cla: NLSFUNC.SKL	\
	     $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\nlsfunc $(subst /,\,$<) $(country)"


nlsfunc.obj: NLSFUNC.ASM	  \
	     FUNCDBCS.INC	  \
	     MSG2NLS.INC	  \
	     FUNCPARM.INC	  \
	     nlsfunc.ctl	  \
	     nlsfunc.cla	  \
	     nlsfunc.cl1	  \
	     nlsfunc.cl2	  \
	     DOESMAC.INC       \
	     $(inc)/MULT.INC     \
	     $(inc)/MSGSERV.ASM   \
	     $(inc)/DOSCNTRY.INC \
	     $(inc)/DEVSYM.INC   \
	     $(inc)/STRUC.INC    \
	     $(inc)/COPYRIGH.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\nlsfunc $(subst /,\,$<) $(subst /,\,$@)"

nlsparm.obj:  NLSPARM.ASM	  \
	      $(inc)/PARSE.ASM \
	      $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\nlsfunc $(subst /,\,$<) $(subst /,\,$@)"

OBJS = nlsfunc.obj nlsparm.obj

nlsfunc.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\nlsfunc nlsfunc+nlsparm,nlsfunc,,,"

clean:
	rm -f *.obj
	rm -f nlsfunc.cl[12a]
	rm -f nlsfunc.ctl
	rm -f nlsfunc.exe
	rm -f nlsfunc.map
	rm -f resp.txt
