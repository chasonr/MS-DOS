#************************* makefile for cmd/join ************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
comsubs = ../../comsubs
hinc	=../../H
map	=../../MAPPER
# This is the path from INC or MAP dir's to here.
here	=../CMD/JOIN

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: join.exe

$(inc)/errtstm.obj:
	$(MAKE) -C $(inc) errtstm.obj

$(inc)/sysvarm.obj:
	$(MAKE) -C $(inc) sysvarm.obj

$(inc)/cdsm.obj:
	$(MAKE) -C $(inc) cdsm.obj

$(inc)/dpbm.obj:
	$(MAKE) -C $(inc) dpbm.obj

$(inc)/comsubs.lib:
	$(MAKE) -C $(inc) comsubs.lib

$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

join.ctl join.cl1 join.cl2 join.cla: join.skl      \
  $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg join.skl

_msgret.obj: _msgret.asm \
  $(inc)/msgserv.asm    \
  $(inc)/sysmsg.inc     \
  $(inc)/versiona.inc   \
  $(inc)/copyrigh.inc   \
  $(inc)/msgdcl.inc     \
  join.ctl              \
  join.cla              \
  join.cl1              \
  join.cl2

_parse.obj: _parse.asm  \
  $(inc)/parse.asm      \
  $(inc)/psdata.inc

join.obj: JOIN.C        \
  JOINPARS.H            \
  $(hinc)/cds.h          \
  $(hinc)/jointype.h     \
  $(hinc)/sysvar.h
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\join $(subst /,\,$<) $(subst /,\,$@)"

OBJS = join.obj $(inc)/errtstm.obj $(inc)/sysvarm.obj $(inc)/cdsm.obj \
       $(inc)/dpbm.obj _msgret.obj _parse.obj

join.exe: $(OBJS) $(map)/mapper.lib $(comsubs)/comsubsm.lib JOIN.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\join @join.lnk"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f join.cl[12a]
	rm -f join.ctl
	rm -f join.exe
	rm -f resp.txt
