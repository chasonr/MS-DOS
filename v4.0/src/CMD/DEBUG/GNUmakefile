#************************** makefile for cmd/debug ***************************

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

all: debug.com

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

debug.ctl debug.cl1 debug.cl2 debug.cla debug.clb debug.clc debug.cld: debug.skl   \
                $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg debug.skl

debug.obj:      debug.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debcom1.obj:    debcom1.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debcom2.obj:    debcom2.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debcom3.obj:    debcom3.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debasm.obj:     debasm.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debuasm.obj:    debuasm.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

deberr.obj:     deberr.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debconst.obj:   debconst.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debdata.obj:    debdata.asm $(DOSSYM_INC) $(inc)/dosmac.inc \
                $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
                $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
                $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
                $(inc)/pdb.inc $(inc)/sf.inc \
                $(inc)/arena.inc $(inc)/intnat.inc \
                $(inc)/error.inc $(inc)/syscall.inc debequ.asm

debems.obj:     debems.asm debequ.asm

debmes.obj:     debmes.asm sysver.inc $(inc)/msgdcl.inc $(inc)/sysmsg.inc \
        debug.ctl \
        debug.cla \
        debug.clb \
        debug.clc \
        debug.cld \
        debug.cl1 \
        debug.cl2

OBJS = debug.obj debcom1.obj debcom2.obj debcom3.obj debasm.obj debuasm.obj \
       deberr.obj debconst.obj debmes.obj debems.obj debdata.obj

debug.com: $(OBJS) DEBUG.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option stack=362' >>resp.txt
	echo 'option map=debug.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name debug.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	../../bldtools/make-com.rb debug.exe debug.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f debug.com
	rm -f debug.exe
	rm -f debug.map
	rm -f debug.cl[12a-d]
	rm -f debug.ctl
	rm -f resp.txt
