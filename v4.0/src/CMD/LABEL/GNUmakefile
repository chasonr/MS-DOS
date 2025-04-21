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

all: label.com

labl.ctl labl.ct1 labl.ct2 labl.cta: LABL.SKL     \
  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\label $(subst /,\,$<) $(country)"

label.obj: LABEL.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\label $(subst /,\,$<) $(subst /,\,$@)"

labelm.obj: LABELM.ASM  \
  labl.ctl 		\
  $(inc)/copyrigh.inc   \
  $(inc)/SYSMSG.INC     \
  $(inc)/MSGSERV.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\label $(subst /,\,$<) $(subst /,\,$@)"

OBJS = label.obj labelm.obj

label.com: $(OBJS) LABEL.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\label @label.lnk"
	exe2bin -q label.exe label.com
	rm label.exe

clean:
	rm -f *.obj
	rm -f label.com
	rm -f labl.cl[12a]
	rm -f labl.ctl
	rm -f resp.txt
