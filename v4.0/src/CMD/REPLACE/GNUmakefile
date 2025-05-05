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

map	=../../MAPPER

all: replace.exe

replace.ctl replace.cl1 replace.cl2 replace.cla: replace.skl \
  $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg replace.skl

_msgret.obj: _msgret.asm \
  $(inc)/msgserv.asm    \
  $(inc)/sysmsg.inc     \
  $(inc)/copyrigh.inc   \
  $(inc)/versiona.inc   \
  $(inc)/msgdcl.inc     \
  replace.ctl           \
  replace.cla           \
  replace.cl1           \
  replace.cl2

_parse.obj: _parse.asm  \
  $(inc)/parse.asm      \
  $(inc)/psdata.inc

_replace.obj: _replace.asm

replace.obj: REPLACE.C  \
  REPLACEP.H            \
  $(hinc)/COMSUB.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\replace $(subst /,\,$<) $(subst /,\,$@)"

OBJS = replace.obj _replace.obj _msgret.obj _parse.obj

replace.exe: $(OBJS) \
  $(map)/mapper.lib     \
  $(inc)/COMSUBS.LIB    \
  REPLACE.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\replace /map @replace.lnk"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f replace.cl[12a]
	rm -f replace.ctl
	rm -f replace.exe
	rm -f replace.map
	rm -f resp.txt
