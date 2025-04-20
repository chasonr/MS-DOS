#************************* makefile for cmd/join ************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
map	=../../MAPPER
# This is the path from INC or MAP dir's to here.
here	=../CMD/JOIN

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

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

join.ctl join.cl1 join.cl2 join.cla: JOIN.SKL      \
  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\join $(subst /,\,$<) $(country)"

_msgret.obj: _MSGRET.ASM \
  $(inc)/MSGSERV.ASM    \
  $(inc)/SYSMSG.INC     \
  join.ctl              \
  join.cla              \
  join.cl1              \
  join.cl2              \
  JOIN.SKL
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\join $(subst /,\,$<) $(subst /,\,$@)"

_parse.obj: _PARSE.ASM  \
  $(inc)/PARSE.ASM      \
  $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\join $(subst /,\,$<) $(subst /,\,$@)"

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
	rm -f join.cl[12a]
	rm -f join.ctl
	rm -f join.exe
	rm -f resp.txt
