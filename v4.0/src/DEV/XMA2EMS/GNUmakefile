#************************ makefile for dev/xma2ems************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: xma2ems.sys

xma2ems.ctl xma2ems.cl1: XMA2EMS.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg1.bat src\dev\xma2ems $(subst /,\,$<) $(country)"

xma2ems.obj:	XMA2EMS.ASM XMA1DIAG.INC xma2ems.cl1 $(inc)/COPYRIGH.INC \
		PARMPARS.INC LIM40.INC PS2_5060.INC \
		EMSINIT.INC GENIOCTL.INC XMA2EMSP.INC LIM40B.INC ROMSCAN.INC \
		$(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xma2ems $(subst /,\,$<) $(subst /,\,$@)"

xma2ems.sys: xma2ems.obj
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\xma2ems xma2ems.obj,xma2ems.exe,,,"
	exe2bin xma2ems.exe xma2ems.sys
	rm xma2ems.exe

clean:
	rm -f *.obj
	rm -f xma2ems.cl1
	rm -f xma2ems.sys
	rm -f xma2ems.map
	rm -f resp.txt
