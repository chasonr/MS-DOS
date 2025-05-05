#************************* makefile for cmd/join ************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
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

$(inc)/errtst.obj:
	$(MAKE) -C $(inc) errtst.obj

$(inc)/sysvar.obj:
	$(MAKE) -C $(inc) sysvar.obj

$(inc)/cds.obj:
	$(MAKE) -C $(inc) cds.obj

$(inc)/dpb.obj:
	$(MAKE) -C $(inc) dpb.obj

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
  $(hinc)/CDS.H          \
  $(hinc)/JOINTYPE.H     \
  $(hinc)/SYSVAR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\join $(subst /,\,$<) $(subst /,\,$@)"

OBJS = join.obj $(inc)/errtst.obj $(inc)/sysvar.obj $(inc)/cds.obj \
       $(inc)/dpb.obj _msgret.obj _parse.obj

join.exe: $(OBJS) $(map)/mapper.lib $(inc)/COMSUBS.LIB JOIN.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\join @join.lnk"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f join.cl[12a]
	rm -f join.ctl
	rm -f join.exe
	rm -f resp.txt
