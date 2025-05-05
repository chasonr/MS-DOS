#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: filesys.exe

filesys.ctl filesys.cl1 filesys.cl2 filesys.cla: filesys.skl \
                $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg filesys.skl

_parse.obj:     _parse.asm              \
                $(inc)/parse.asm        \
                $(inc)/psdata.inc

_msgret.obj:    _msgret.asm             \
                filesys.ctl filesys.cl1 filesys.cl2 filesys.cla \
                $(inc)/msgserv.asm      \
                $(inc)/sysmsg.inc       \
                $(inc)/copyrigh.inc     \
                $(inc)/versiona.inc     \
                $(inc)/msgdcl.inc

filesys.obj:    FILESYS.C PARSE.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\filesys $(subst /,\,$<) $(subst /,\,$@)"

OBJS = filesys.obj _parse.obj _msgret.obj

filesys.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\filesys filesys+_parse+_msgret,filesys,, /NOI"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f filesys.cl[12a]
	rm -f filesys.ctl
	rm -f filesys.exe
	rm -f filesys.map
	rm -f resp.txt
