#************************ makefile for cmd/subst *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
map	=../../MAPPER
here	=../CMD/SUBST	  # This is the path from INC or MAP dir's to here.

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: subst.exe

$(inc)/errtst.obj:
	$(MAKE) -C $(inc) errtst.obj

$(inc)/sysvar.obj:
	$(MAKE) -C $(inc) sysvar.obj

$(inc)/cds.obj:
	$(MAKE) -C $(inc) cds.obj

$(inc)/dpb.obj:
	$(MAKE) -C $(inc) dpb.obj

$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

subst.ctl subst.cl1 subst.cl2 subst.cla: subst.skl    \
  $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG subst.skl

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
  $(hinc)/CDS.H          \
  $(hinc)/JOINTYPE.H     \
  $(hinc)/SYSVAR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\subst $(subst /,\,$<) $(subst /,\,$@)"

OBJS = subst.obj $(inc)/errtst.obj $(inc)/sysvar.obj $(inc)/cds.obj \
       $(inc)/dpb.obj _msgret.obj _parse.obj

subst.exe: $(OBJS) $(map)/mapper.lib $(inc)/COMSUBS.LIB SUBST.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\subst @subst.lnk"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f subst.cl[12a]
	rm -f subst.ctl
	rm -f subst.exe
	rm -f resp.txt
