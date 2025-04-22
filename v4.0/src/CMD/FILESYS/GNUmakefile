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

all: filesys.exe

filesys.ctl filesys.cl1 filesys.cl2 filesys.cla: FILESYS.SKL \
                $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\filesys $(subst /,\,$<) $(country)"

_msgret.obj:    _MSGRET.ASM             \
                filesys.ctl             \
                $(inc)/msgserv.asm      \
                $(inc)/sysmsg.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\filesys $(subst /,\,$<) $(subst /,\,$@)"

_parse.obj:     _PARSE.ASM              \
                $(inc)/parse.asm        \
                $(inc)/psdata.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\filesys $(subst /,\,$<) $(subst /,\,$@)"

filesys.obj:    FILESYS.C PARSE.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\filesys $(subst /,\,$<) $(subst /,\,$@)"

OBJS = filesys.obj _parse.obj _msgret.obj

filesys.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\filesys filesys+_parse+_msgret,filesys,, /NOI"

clean:
	rm -f *.obj
	rm -f filesys.cl[12a]
	rm -f filesys.ctl
	rm -f filesys.exe
	rm -f filesys.map
	rm -f resp.txt
