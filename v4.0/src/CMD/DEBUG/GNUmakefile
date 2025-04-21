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

all: debug.com

debug.ctl: DEBUG.SKL   \
                $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\debug $(subst /,\,$<) $(country)"

debug.obj:      DEBUG.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debcom1.obj:    DEBCOM1.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debcom2.obj:    DEBCOM2.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debcom3.obj:    DEBCOM3.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debasm.obj:     DEBASM.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debuasm.obj:    DEBUASM.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

deberr.obj:     DEBERR.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debconst.obj:   DEBCONST.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debdata.obj:    DEBDATA.ASM $(inc)/dossym.inc $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debems.obj:     DEBEMS.ASM DEBEQU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

debmes.obj:     DEBMES.ASM $(inc)/MSGSERV.ASM $(inc)/SYSMSG.INC \
        debug.ctl \
        debug.cla \
        debug.clb \
        debug.clc \
        debug.cld \
        debug.cl1 \
        debug.cl2
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\debug $(subst /,\,$<) $(subst /,\,$@)"

OBJS = debug.obj debcom1.obj debcom2.obj debcom3.obj debasm.obj debuasm.obj \
       deberr.obj debconst.obj debmes.obj debems.obj debdata.obj

debug.com: $(OBJS) DEBUG.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\debug @debug.lnk"
#	echo 'system dos' >resp.txt
#	echo 'option map=debug.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name debug.exe' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\debug\debug.exe"
	rm debug.exe

clean:
	rm -f *.obj
	rm -f debug.com
	rm -f debug.map
	rm -f debug.cl[12a-d]
	rm -f debug.ctl
	rm -f resp.txt
