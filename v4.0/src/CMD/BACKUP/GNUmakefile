#************************** makefile for cmd/backup ***************************

cflags	= -AS -Od -Zp $(extcsw)
msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
map	=../../MAPPER

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: backup.com

$(map)/mapper.lib:
	$(MAKE) -C $(map)/mapper.lib:

backup.ctl backup.cl1 backup.cl2 backup.cla:	backup.skl			\
		$(msg)/$(country).msg		
	../../bldtools/buildmsg.rb $(msg)/$(country).msg backup.skl

_parse.obj:	_parse.asm			\
		$(inc)/parse.asm		\
		$(inc)/psdata.inc       \
		$(inc)/version.inc

_msgret.obj:	_msgret.asm			\
		backup.ctl backup.cl1 backup.cl2 backup.cla \
		$(inc)/msgserv.asm		\
		$(inc)/sysmsg.inc		\
		$(inc)/msgdcl.inc		\
		$(inc)/versiona.inc		\
		$(inc)/copyrigh.inc

backup.obj:  BACKUP.C  BACKPARS.H BACKUP.H  \
	     $(hinc)/DOSCALLS.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc2.bat src\cmd\backup $(subst /,\,$<) $(subst /,\,$@)"

OBJS = backup.obj _parse.obj _msgret.obj

backup.com: $(OBJS) $(map)/mapper.lib $(inc)/COMSUBS.LIB
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\backup /NOE /MAP $(subst /,\,backup+_parse+_msgret,,,$(map)/mapper+$(inc)/COMSUBS)"
	../../bldtools/make-com.rb backup.exe backup.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f backup.com
	rm -f backup.exe
	rm -f backup.cl[12a]
	rm -f backup.ctl
	rm -f backup.map
	rm -f resp.txt
