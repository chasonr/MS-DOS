#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: exe2bin.exe

exe2bin.ctl exe2bin.cl1 exe2bin.cl2 exe2bin.cla exe2bin.clb: EXE2BIN.SKL \
              $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\exe2bin $(subst /,\,$<) $(country)"

e2binit.obj : E2BINIT.ASM  $(inc)/SYSCALL.INC E2BPARSE.INC  E2BMACRO.INC \
              E2BEQU.INC  $(inc)/SYSMSG.INC  E2BTABLE.INC  exe2bin.ctl   \
              LOCATE.ASM $(inc)/DOSSYM.INC $(inc)/DOSMAC.INC \
              $(inc)/BPB.INC $(inc)/BUFFER.INC $(inc)/SYSVAR.INC \
              $(inc)/MULT.INC $(inc)/DIRENT.INC $(inc)/DPB.INC \
              $(inc)/CURDIR.INC $(inc)/CPMFCB.INC $(inc)/FIND.INC \
              $(inc)/PDB.INC $(inc)/SF.INC $(inc)/ARENA.INC $(inc)/INTNAT.INC \
              $(inc)/ERROR.INC $(inc)/SYSCALL.INC $(inc)/PARSE.ASM \
              $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\exe2bin $(subst /,\,$<) $(subst /,\,$@)"

display.obj : DISPLAY.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\exe2bin $(subst /,\,$<) $(subst /,\,$@)"

OBJS = e2binit.obj display.obj

exe2bin.exe : $(OBJS) exe2bin.ctl EXE2BIN.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\exe2bin @exe2bin.lnk"
#	echo 'system dos' >resp.txt
#	echo 'option map=exe2bin.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name exe2bin.exe' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f exe2bin.cl[12ab]
	rm -f exe2bin.ctl
	rm -f exe2bin.exe
	rm -f exe2bin.map
