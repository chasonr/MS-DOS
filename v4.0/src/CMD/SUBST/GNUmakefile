#************************ makefile for cmd/subst *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
comsubs = ../../comsubs
hinc	=../../H
map	=../../MAPPER
here	=../CMD/SUBST	  # This is the path from INC or MAP dir's to here.

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: subst.exe

$(inc)/errtstm.obj:
	$(MAKE) -C $(inc) errtstm.obj

$(inc)/sysvarm.obj:
	$(MAKE) -C $(inc) sysvarm.obj

$(inc)/cdsm.obj:
	$(MAKE) -C $(inc) cdsm.obj

$(inc)/dpbm.obj:
	$(MAKE) -C $(inc) dpbm.obj

$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

subst.ctl subst.cl1 subst.cl2 subst.cla: subst.skl    \
  $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg subst.skl

_msgret.obj: _msgret.asm \
  $(inc)/msgserv.asm    \
  $(inc)/sysmsg.inc     \
  $(inc)/copyrigh.inc   \
  $(inc)/versiona.inc   \
  $(inc)/msgdcl.inc     \
  subst.ctl             \
  subst.cla             \
  subst.cl1             \
  subst.cl2

_parse.obj: _parse.asm  \
  $(inc)/parse.asm      \
  $(inc)/psdata.inc

subst.obj: SUBST.C      \
  SUBSTPAR.H            \
  $(hinc)/cds.h          \
  $(hinc)/jointype.h     \
  $(hinc)/sysvar.h
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\subst $(subst /,\,$<) $(subst /,\,$@)"

OBJS = subst.obj $(inc)/errtstm.obj $(inc)/sysvarm.obj $(inc)/cdsm.obj \
       $(inc)/dpbm.obj _msgret.obj _parse.obj

subst.exe: $(OBJS) $(map)/mapper.lib $(comsubs)/comsubsm.lib SUBST.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\subst @subst.lnk"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f subst.cl[12a]
	rm -f subst.ctl
	rm -f subst.exe
	rm -f resp.txt
