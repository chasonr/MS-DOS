#************************** makefile for cmd/append ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: command.com

$(inc)/DOSSYM.INC: $(inc)/DOSMAC.INC $(inc)/BPB.INC \
    $(inc)/BUFFER.INC $(inc)/SYSVAR.INC $(inc)/VECTOR.INC \
    $(inc)/MULT.INC $(inc)/DIRENT.INC $(inc)/DPB.INC $(inc)/CURDIR.INC \
    $(inc)/CPMFCB.INC $(inc)/FIND.INC $(inc)/PDB.INC $(inc)/EXE.INC \
    $(inc)/SF.INC $(inc)/ARENA.INC $(inc)/INTNAT.INC $(inc)/MI.INC \
    $(inc)/FILEMODE.INC $(inc)/ERROR.INC $(inc)/SYSCALL.INC
	echo "touch $(inc)/DOSSYM.INC"

command.ctl command.cl1 command.cl2 command.cl3 command.cl4 command.cl5 command.cla command.clb command.clc command.cld command.cle command.clf: \
        COMMAND.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\command $(subst /,\,$<) $(country)"

command1.obj:  COMMAND1.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSW.ASM COMEQU.ASM RESMSG.EQU \
    ENVDATA.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

command2.obj:  COMMAND2.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSW.ASM COMEQU.ASM RESMSG.EQU \
    ENVDATA.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

copy.obj:  COPY.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

copypr1.obj:  COPYPR1.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

copypr2.obj:  COPYPR2.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

cparse.obj:  CPARSE.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

init.obj:  INIT.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC \
    COMSW.ASM COMSEG.ASM COMEQU.ASM RESMSG.EQU $(inc)/SYSMSG.INC \
    $(inc)/MSGSERV.ASM command.ctl
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

iparse.obj:  IPARSE.ASM COMSEG.ASM $(inc)/PARSE.ASM $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

parse2.obj:  PARSE2.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC COMSW.ASM \
    COMSEG.ASM COMEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

path1.obj:  PATH1.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC COMSW.ASM \
    COMSEG.ASM COMEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

path2.obj:  PATH2.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC COMSW.ASM \
    COMSEG.ASM COMEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

rdata.obj:  RDATA.ASM COMSW.ASM COMSEG.ASM $(inc)/SYSMSG.INC \
    $(inc)/MSGSERV.ASM command.cla command.cl3 command.cl4 \
    command.cld command.clc command.cle command.ctl
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

rucode.obj:  RUCODE.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC \
    $(inc)/DOSCNTRY.INC RESMSG.EQU $(inc)/SYSMSG.INC \
    $(inc)/MSGSERV.ASM COMSW.ASM COMSEG.ASM COMEQU.ASM command.ctl
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tbatch.obj:  TBATCH.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/DOSCNTRY.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tbatch2.obj:  TBATCH2.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/DOSCNTRY.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tcmd1a.obj:  TCMD1A.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/IOCTL.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tcmd1b.obj:  TCMD1B.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/IOCTL.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM $(inc)/EA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tcmd2a.obj:  TCMD2A.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/IOCTL.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tcmd2b.obj:  TCMD2B.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tcode.obj:  TCODE.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM \
    $(inc)/MSHALO.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tdata.obj:  TDATA.ASM COMSW.ASM COMSEG.ASM $(inc)/CURDIR.INC \
    $(inc)/ERROR.INC IFEQU.ASM COMEQU.ASM $(inc)/SYSMSG.INC \
    $(inc)/MSGSERV.ASM TRANMSG.ASM command.clf command.cl1 command.cl2 \
    command.ctl  $(inc)/EA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tenv.obj:  TENV.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC \
    COMSEG.ASM COMEQU.ASM IFEQU.ASM $(inc)/DOSCNTRY.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tenv2.obj:  TENV2.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC \
    COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tfor.obj:  TFOR.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/DEVSYM.INC \
    COMSEG.ASM COMEQU.ASM IFEQU.ASM FORDATA.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tmisc1.obj:  TMISC1.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tmisc2.obj:  TMISC2.ASM COMSW.ASM $(inc)/DOSSYM.INC $(inc)/IOCTL.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tparse.obj:  TPARSE.ASM COMSEG.ASM $(inc)/PARSE.ASM $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tpipe.obj:  TPIPE.ASM COMSW.ASM $(inc)/DOSSYM.INC \
    $(inc)/DEVSYM.INC COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tprintf.obj:  TPRINTF.ASM COMSW.ASM $(inc)/DOSMAC.INC \
    COMSEG.ASM COMEQU.ASM $(inc)/SYSMSG.INC $(inc)/MSGSERV.ASM \
    command.ctl
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tspc.obj:  TSPC.ASM COMSW.ASM $(inc)/DOSSYM.INC COMEQU.ASM \
    IFEQU.ASM COMSEG.ASM  $(inc)/EA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

tucode.obj:  TUCODE.ASM $(inc)/DOSMAC.INC $(inc)/DOSSYM.INC \
    COMSW.ASM COMSEG.ASM COMEQU.ASM IFEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

uinit.obj:  UINIT.ASM COMSW.ASM COMSEG.ASM IFEQU.ASM command.clb \
    $(inc)/SYSMSG.INC $(inc)/MSGSERV.ASM command.ctl
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\command $(subst /,\,$<) $(subst /,\,$@)"

OBJS = command1.obj command2.obj rucode.obj rdata.obj init.obj iparse.obj \
       uinit.obj tcode.obj tbatch.obj tbatch2.obj tfor.obj tcmd1a.obj \
       tcmd1b.obj tcmd2a.obj tcmd2b.obj tenv.obj tenv2.obj tmisc1.obj \
       tmisc2.obj tpipe.obj parse2.obj path1.obj path2.obj tucode.obj \
       copy.obj copypr1.obj copypr2.obj cparse.obj tparse.obj tprintf.obj \
       tdata.obj tspc.obj

command.com:  $(OBJS)
#	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\command @command.lnk"
	echo 'system dos' >resp.txt
	echo 'option map=command.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name command.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q command.exe command.com
	rm command.exe

clean:
	rm -f *.obj
	rm -f command.com
	rm -f command.cl[1-4a-f]
	rm -f command.ctl
	rm -f command.map
	rm -f resp.txt
