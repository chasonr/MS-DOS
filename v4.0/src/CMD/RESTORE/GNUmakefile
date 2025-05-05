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

all: restore.com

#-------BUILD MAPPER ----------------
$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

restore.ctl restore.cl1 restore.cl2 restore.cla:	restore.skl			\
		$(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg restore.skl

_parse.obj :	_parse.asm			\
		$(inc)/parse.asm		\
		$(inc)/psdata.inc

_msgret.obj:	_msgret.asm			\
		restore.ctl			\
		restore.cl1 restore.cl2 restore.cla \
		$(inc)/msgserv.asm		\
		$(inc)/sysmsg.inc		\
		$(inc)/copyrigh.inc		\
		$(inc)/versiona.inc		\
		$(inc)/msgdcl.inc


restore.obj :	RESTORE.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtt1.obj :	RTT1.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtt3.obj :	RTT3.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtdo.obj :	RTDO.C	RT.H RT1.H RT2.H RESTPARS.H  \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtdo1.obj :	RTDO1.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtnew.obj :	RTNEW.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtnew1.obj :	RTNEW1.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtold.obj :	RTOLD.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtold1.obj :	RTOLD1.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtfile.obj  :	RTFILE.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

rtfile1.obj :	RTFILE1.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

restpars.obj :	RESTPARS.C RT.H RT1.H RT2.H RESTPARS.H \
		$(hinc)/COMSUB.H    $(hinc)/DOSCALLS.H	     \
		$(hinc)/ERROR.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\restore $(subst /,\,$<) $(subst /,\,$@)"

OBJS = restore.obj restpars.obj rtt1.obj rtt3.obj rtdo.obj rtdo1.obj \
       rtold.obj rtold1.obj rtnew.obj rtnew1.obj rtfile.obj rtfile1.obj \
       _parse.obj _msgret.obj

restore.com: $(OBJS) RESTORE.LNK $(map)/mapper.lib
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\restore /map @restore.lnk"
	../../bldtools/make-com.rb restore.exe restore.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f restore.com
	rm -f restore.exe
	rm -f restore.cl[12a]
	rm -f restore.ctl
	rm -f restore.map
	rm -f resp.txt
