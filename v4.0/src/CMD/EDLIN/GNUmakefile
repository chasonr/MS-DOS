#************************** makefile for cmd/edlin ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: edlin.com

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

edlin.ctl edlin.cl1 edlin.cl2 edlin.cla edlin.clb edlin.clc: EDLIN.SKL   \
                $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\edlin $(subst /,\,$<) $(country)"

edlin.obj:      edlin.asm edlequ.asm edlstdsw.inc $(DOSSYM_INC)

edlcmd1.obj:    edlcmd1.asm edlequ.asm edlstdsw.inc $(DOSSYM_INC)

edlcmd2.obj:    edlcmd2.asm edlequ.asm edlstdsw.inc $(DOSSYM_INC)

edlmes.obj:     edlmes.asm $(inc)/sysmsg.inc $(inc)/msgdcl.inc \
                $(inc)/versiona.inc $(inc)/msgserv.asm \
                $(inc)/copyrigh.inc \
                edlin.ctl \
                edlin.cla \
                edlin.clb \
                edlin.cl1 \
                edlin.cl2

edlparse.obj:   edlparse.asm $(inc)/parse.asm $(inc)/psdata.inc

OBJS = edlin.obj edlcmd1.obj edlcmd2.obj edlmes.obj edlparse.obj

edlin.com: $(OBJS) EDLIN.LNK
	echo 'system dos' >resp.txt
	echo 'option map=edlin.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name edlin.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\edlin\edlin.exe"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f edlin.com
	rm -f edlin.exe
	rm -f edlin.map
	rm -f edlin.cl[12a-c]
	rm -f edlin.ctl
	rm -f resp.txt
