#************************ makefile for cmd/format *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
boot	=../../BOOT

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: format.com

boot.cl1:
		cp $(boot)/boot.cl1 .

format.ctl format.cl1 format.cl2 format.cla format.clb format.clc: \
        FORMAT.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\format $(subst /,\,$<) $(country)"

display.obj:    DISPLAY.ASM FOREQU.INC FORMSG.INC FORMACRO.INC \
                format.ctl format.cl1 format.cl2 format.cla $(inc)/SYSMSG.INC \
                $(inc)/MSGSERV.ASM \
                format.clb format.clc FORMACRO.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\format $(subst /,\,$<) $(subst /,\,$@)"

forexec.obj:    FOREXEC.ASM FOREQU.INC $(inc)/SYSCALL.INC \
                FORMACRO.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\format $(subst /,\,$<) $(subst /,\,$@)"

forlabel.obj:   FORLABEL.ASM FOREQU.INC FORMACRO.INC \
                $(inc)/SYSCALL.INC $(inc)/IOCTL.INC $(inc)/DOSMAC.INC \
                FORSWTCH.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\format $(subst /,\,$<) $(subst /,\,$@)"

format.obj:     FORMAT.ASM $(inc)/DOSMAC.INC $(inc)/BPB.INC \
                $(inc)/DIRENT.INC $(inc)/DPB.INC $(inc)/CURDIR.INC \
                $(inc)/CPMFCB.INC $(inc)/PDB.INC \
                $(inc)/ERROR.INC $(inc)/SYSCALL.INC $(inc)/IOCTL.INC \
                FOREQU.INC FORMACRO.INC FORSWTCH.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\format $(subst /,\,$<) $(subst /,\,$@)"

forinit.obj:    FORINIT.ASM FOREQU.INC FORMACRO.INC \
                $(inc)/SYSCALL.INC $(inc)/IOCTL.INC FORPARSE.INC \
                FORSWTCH.INC $(inc)/PARSE.ASM $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\format $(subst /,\,$<) $(subst /,\,$@)"

msfor.obj:      MSFOR.ASM $(inc)/DOSMAC.INC $(inc)/SYSCALL.INC $(inc)/BPB.INC \
                $(inc)/DIRENT.INC boot.cl1 $(inc)/IOCTL.INC \
                $(inc)/boot.inc $(inc)/BOOT11.INC \
                $(inc)/BOOTFORM.INC FILESIZE.INC FOREQU.INC FORMACRO.INC FORSWTCH.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\format $(subst /,\,$<) $(subst /,\,$@)"

forproc.obj:    FORPROC.ASM $(inc)/SYSCALL.INC FOREQU.INC \
                FORMACRO.INC FORSWTCH.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\format $(subst /,\,$<) $(subst /,\,$@)"

OBJS = display.obj forinit.obj forlabel.obj format.obj forproc.obj msfor.obj \
       forexec.obj

format.com: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\format @format.lnk"
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\format\format.exe"
	rm format.exe

clean:
	rm -f *.obj
	rm -f boot.cl1
	rm -f format.com
	rm -f format.cl[12a-c]
	rm -f format.ctl
	rm -f format.map
	rm -f resp.txt
