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

all: edlin.com

edlin.ctl edlin.cl1 edlin.cl2 edlin.cla edlin.clb edlin.clc: EDLIN.SKL   \
                $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\edlin $(subst /,\,$<) $(country)"


edlin.obj:      EDLIN.ASM EDLEQU.ASM EDLSTDSW.INC \
                $(inc)/DOSSYM.INC \
                $(inc)/dosmac.inc $(inc)/bpb.inc $(inc)/buffer.inc \
                $(inc)/sysvar.inc $(inc)/MULT.INC $(inc)/dirent.inc \
                $(inc)/dpb.inc $(inc)/curdir.inc $(inc)/CPMFCB.INC \
                $(inc)/FIND.INC $(inc)/pdb.inc $(inc)/sf.inc $(inc)/arena.inc \
                $(inc)/intnat.inc $(inc)/ERROR.INC $(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\edlin $(subst /,\,$<) $(subst /,\,$@)"

edlcmd1.obj:    EDLCMD1.ASM EDLEQU.ASM EDLSTDSW.INC \
                $(inc)/DOSSYM.INC \
                $(inc)/dosmac.inc $(inc)/bpb.inc $(inc)/buffer.inc \
                $(inc)/sysvar.inc $(inc)/MULT.INC $(inc)/dirent.inc \
                $(inc)/dpb.inc $(inc)/curdir.inc $(inc)/CPMFCB.INC \
                $(inc)/FIND.INC $(inc)/pdb.inc $(inc)/sf.inc $(inc)/arena.inc \
                $(inc)/intnat.inc $(inc)/ERROR.INC $(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\edlin $(subst /,\,$<) $(subst /,\,$@)"

edlcmd2.obj:    EDLCMD2.ASM EDLEQU.ASM EDLSTDSW.INC \
                $(inc)/DOSSYM.INC \
                $(inc)/dosmac.inc $(inc)/bpb.inc $(inc)/buffer.inc \
                $(inc)/sysvar.inc $(inc)/MULT.INC $(inc)/dirent.inc \
                $(inc)/dpb.inc $(inc)/curdir.inc $(inc)/CPMFCB.INC \
                $(inc)/FIND.INC $(inc)/pdb.inc $(inc)/sf.inc $(inc)/arena.inc \
                $(inc)/intnat.inc $(inc)/ERROR.INC $(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\edlin $(subst /,\,$<) $(subst /,\,$@)"

edlmes.obj:     EDLMES.ASM $(inc)/SYSMSG.INC  \
                edlin.ctl \
                edlin.cla \
                edlin.clb \
                edlin.cl1 \
                edlin.cl2
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\edlin $(subst /,\,$<) $(subst /,\,$@)"

edlparse.obj:   EDLPARSE.ASM $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\edlin $(subst /,\,$<) $(subst /,\,$@)"

OBJS = edlin.obj edlcmd1.obj edlcmd2.obj edlmes.obj edlparse.obj

edlin.com: $(OBJS) EDLIN.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\edlin @edlin.lnk"
#	echo 'system dos' >resp.txt
#	echo 'option map=edlin.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name edlin.exe' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\edlin\edlin.exe"
	rm edlin.exe

clean:
	rm -f *.obj
	rm -f edlin.com
	rm -f edlin.map
	rm -f edlin.cl[12a-c]
	rm -f edlin.ctl
	rm -f resp.txt
