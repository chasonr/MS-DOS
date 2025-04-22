#************************** makefile for cmd/backup ***************************

cflags	= -AS -Od -Zp $(extcsw)
msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
map	=../../MAPPER

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: backup.com

$(map)/mapper.lib:
	$(MAKE) -C $(map)/mapper.lib:

_parse.obj:	_PARSE.ASM			\
		$(inc)/parse.asm		\
		$(inc)/psdata.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\backup $(subst /,\,$<) $(subst /,\,$@)"

backup.ctl backup.cl1 backup.cl2 backup.cla:	BACKUP.SKL			\
		$(msg)/$(COUNTRY).MSG		
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\backup $(subst /,\,$<) $(country)"

_msgret.obj:	_MSGRET.ASM			\
		backup.ctl			\
		$(inc)/msgserv.asm		\
		$(inc)/sysmsg.inc		\
		$(inc)/versiona.inc		\
		$(inc)/copyrigh.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\backup $(subst /,\,$<) $(subst /,\,$@)"

backup.obj:  BACKUP.C  BACKPARS.H BACKUP.H  \
	     $(hinc)/DOSCALLS.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc2.bat src\cmd\backup $(subst /,\,$<) $(subst /,\,$@)"

OBJS = backup.obj _parse.obj _msgret.obj

backup.com: $(OBJS) $(map)/mapper.lib $(inc)/COMSUBS.LIB
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\backup /NOE $(subst /,\,backup+_parse+_msgret,,,$(map)/mapper+$(inc)/COMSUBS)"
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\backup\backup.exe"
	rm backup.exe

clean:
	rm -f *.obj
	rm -f backup.com
	rm -f backup.cl[12a]
	rm -f backup.ctl
	rm -f backup.map
	rm -f resp.txt
