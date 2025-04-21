#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
lib     =../../LIB

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: mem.exe


mem.ctl mem.cl1 mem.cl2 mem.cla mem.clb:        MEM.SKL                         \
                $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\mem $(subst /,\,$<) $(country)"

_parse.obj:     _PARSE.ASM                      \
                $(inc)/parse.asm                \
                $(inc)/psdata.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mem $(subst /,\,$<) $(subst /,\,$@)"

_msgret.obj:    _MSGRET.ASM                     \
                mem.ctl                         \
                $(inc)/MSGSERV.ASM              \
                $(inc)/SYSMSG.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mem $(subst /,\,$<) $(subst /,\,$@)"

mem.obj:        MEM.C                           \
                MSGDEF.H                        \
                $(hinc)/COPYRIGH.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\mem $(subst /,\,$<) $(subst /,\,$@)"

OBJS = mem.obj _msgret.obj _parse.obj

mem.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\mem mem+_msgret+_parse,,,$(subst /,\,$(lib))\mem.lib"

clean:
	rm -f *.obj
	rm -f mem.cl[12ab]
	rm -f mem.ctl
	rm -f mem.exe
	rm -f mem.map
	rm -f resp.txt
