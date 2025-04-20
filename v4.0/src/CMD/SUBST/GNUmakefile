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

subst.ctl subst.cl1 subst.cl2 subst.cla: SUBST.SKL    \
  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\subst $(subst /,\,$<) $(country)"

_msgret.obj: _MSGRET.ASM \
  $(inc)/MSGSERV.ASM    \
  $(inc)/SYSMSG.INC     \
  subst.ctl             \
  subst.cla             \
  subst.cl1             \
  subst.cl2             \
  SUBST.SKL
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\subst $(subst /,\,$<) $(subst /,\,$@)"

_parse.obj: _PARSE.ASM  \
  $(inc)/PARSE.ASM      \
  $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\subst $(subst /,\,$<) $(subst /,\,$@)"

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
	rm -f subst.cl[12a]
	rm -f subst.ctl
	rm -f subst.exe
	rm -f resp.txt
