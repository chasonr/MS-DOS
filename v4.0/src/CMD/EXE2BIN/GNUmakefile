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

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: exe2bin.exe

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

exe2bin.ctl exe2bin.cl1 exe2bin.cl2 exe2bin.cla exe2bin.clb: EXE2BIN.SKL \
              $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\exe2bin $(subst /,\,$<) $(country)"

e2binit.obj : e2binit.asm  e2bparse.inc  e2bmacro.inc \
              e2bequ.inc  $(inc)/sysmsg.inc  e2btable.inc  \
              exe2bin.ctl exe2bin.cl1 exe2bin.cl2 exe2bin.cla exe2bin.clb \
              $(DOSSYM_INC) $(inc)/parse.asm \
              $(inc)/psdata.inc $(inc)/msgserv.asm $(inc)/copyrigh.inc

display.obj : display.asm

OBJS = e2binit.obj display.obj

exe2bin.exe : $(OBJS) exe2bin.ctl EXE2BIN.LNK
	echo 'system dos' >resp.txt
	echo 'option stack=362' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=exe2bin.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name exe2bin.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f exe2bin.cl[12ab]
	rm -f exe2bin.ctl
	rm -f exe2bin.exe
	rm -f exe2bin.map
	rm -f resp.txt
