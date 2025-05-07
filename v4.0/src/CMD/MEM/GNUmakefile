#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
lib     =../../LIB

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: mem.exe


mem.ctl mem.cl1 mem.cl2 mem.cla mem.clb:        mem.skl                         \
                $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg mem.skl

_parse.obj:     _parse.asm                      \
                $(inc)/parse.asm                \
                $(inc)/psdata.inc

_msgret.obj:    _msgret.asm                     \
                mem.ctl mem.cl1 mem.cl2 mem.cla mem.clb \
                $(inc)/msgserv.asm              \
                $(inc)/sysmsg.inc               \
                $(inc)/copyrigh.inc             \
                $(inc)/versiona.inc             \
                $(inc)/msgdcl.inc

mem.obj:        mem.c                           \
                msgdef.h                        \
                parse.h
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\mem $(subst /,\,$<) $(subst /,\,$@)"

OBJS = mem.obj _msgret.obj _parse.obj

mem.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\mem mem+_msgret+_parse,mem.exe,,,;"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f mem.cl[12ab]
	rm -f mem.ctl
	rm -f mem.exe
	rm -f mem.map
	rm -f resp.txt
