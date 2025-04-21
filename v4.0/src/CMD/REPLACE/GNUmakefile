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

map	=../../MAPPER

all: replace.exe

replace.ctl replace.cl1 replace.cl2 replace.cla: REPLACE.SKL \
  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\replace $(subst /,\,$<) $(country)"

_msgret.obj: _MSGRET.ASM \
  $(inc)/MSGSERV.ASM    \
  $(inc)/SYSMSG.INC     \
  replace.ctl           \
  replace.cla           \
  replace.cl1           \
  replace.cl2           \
  REPLACE.SKL
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\replace $(subst /,\,$<) $(subst /,\,$@)"

_parse.obj: _PARSE.ASM  \
  $(inc)/parse.asm      \
  $(inc)/psdata.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\replace $(subst /,\,$<) $(subst /,\,$@)"

_replace.obj: _REPLACE.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\replace $(subst /,\,$<) $(subst /,\,$@)"

replace.obj: REPLACE.C  \
  REPLACEP.H            \
  $(hinc)/COMSUB.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\replace $(subst /,\,$<) $(subst /,\,$@)"

OBJS = replace.obj _replace.obj _msgret.obj _parse.obj

replace.exe: $(OBJS) \
  $(map)/mapper.lib     \
  $(inc)/COMSUBS.LIB    \
  REPLACE.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\replace @replace.lnk"

clean:
	rm -f *.obj
	rm -f replace.cl[12a]
	rm -f replace.ctl
	rm -f replace.exe
	rm -f resp.txt
