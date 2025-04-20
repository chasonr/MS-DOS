#************************** makefile for mapper ***************************

msg	=../messages
dos	=../dos
inc	=../inc
hinc	=../h

#
#######################	dependencies begin here. #########################
#

all: mapper.lib

chdir.obj:  CHDIR.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

getver.obj: GETVER.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

f_first.obj: F_FIRST.ASM MACROS.INC  FIND.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

set_tod.obj: SET_TOD.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

write.obj:  WRITE.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

beep.obj:   BEEP.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

mkdir.obj:  MKDIR.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

exit.obj:   EXIT.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

delete.obj: DELETE.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

getcntry.obj: GETCNTRY.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

f_close.obj: F_CLOSE.ASM  MACROS.INC  FIND.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

open.obj:   OPEN.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

read.obj:   READ.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

rmdir.obj:  RMDIR.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

qcurdir.obj: QCURDIR.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

qcurdsk.obj: QCURDSK.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

qverify.obj: QVERIFY.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

qfilemod.obj: QFILEMOD.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

sverify.obj: SVERIFY.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

sfilemod.obj: SFILEMOD.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

lseek.obj:  LSEEK.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

sfileinf.obj: SFILEINF.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

close.obj:   CLOSE.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

allocseg.obj: ALLOCSEG.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

freeseg.obj: FREESEG.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

sel_disk.obj: SEL_DISK.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

qfsinfo.obj: QFSINFO.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

f_next.obj: F_NEXT.ASM	MACROS.INC	FIND.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

getmsg.obj: GETMSG.ASM	MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

get_tod.obj: GET_TOD.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

charin.obj: CHARIN.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

flushbuf.obj: FLUSHBUF.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

devconfg.obj: DEVCONFG.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

reallseg.obj: REALLSEG.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

putmsg.obj: PUTMSG.ASM	MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

execpgm.obj: EXECPGM.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

qhandtyp.obj: QHANDTYP.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

cwait.obj:  CWAIT.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

kbdgstat.obj: KBDGSTAT.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

kbdsstat.obj: KBDSSTAT.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

casemap.obj: CASEMAP.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

dbcs.obj:   DBCS.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

ioctl.obj:  IOCTL.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

sighand.obj: SIGHAND.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

error.obj:  ERROR.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

setint24.obj:  SETINT24.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

qfileinf.obj: QFILEINF.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

scurpos.obj: SCURPOS.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

scrollup.obj: SCROLLUP.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

wchstra.obj: WCHSTRA.ASM  MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

scntry.obj: SCNTRY.ASM	MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

setfsinf.obj: SETFSINF.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

gmachmod.obj: GMACHMOD.ASM MACROS.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\mapper $(subst /,\,$<) $(subst /,\,$@);"

OFILES = chdir.obj getver.obj f_first.obj set_tod.obj write.obj beep.obj \
         mkdir.obj exit.obj delete.obj getcntry.obj f_close.obj open.obj \
         read.obj rmdir.obj qcurdir.obj qcurdsk.obj qverify.obj qfilemod.obj \
         sverify.obj sfilemod.obj lseek.obj sfileinf.obj close.obj \
         allocseg.obj freeseg.obj sel_disk.obj qfsinfo.obj f_next.obj \
         getmsg.obj get_tod.obj charin.obj flushbuf.obj devconfg.obj \
         reallseg.obj putmsg.obj execpgm.obj qhandtyp.obj cwait.obj \
         kbdgstat.obj kbdsstat.obj casemap.obj dbcs.obj ioctl.obj \
         sighand.obj error.obj setint24.obj qfileinf.obj scurpos.obj \
         scrollup.obj wchstra.obj scntry.obj setfsinf.obj gmachmod.obj

mapper.lib: $(OFILES)
	rm -f $@
	rm -f resp.txt
	for x in $(OFILES); do echo "+$$x" >>resp.txt; done
	wlib -l=mapper.lst $@ @resp.txt

clean:
	rm -f *.obj
	rm -f mapper.lib
	rm -f mapper.lst
	rm -f resp.txt
