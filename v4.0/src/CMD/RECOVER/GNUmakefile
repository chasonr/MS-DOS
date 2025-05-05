#************************** makefile for cmd/... ***************************

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

all: recover.com

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

recover.ctl : recover.skl    \
	     $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg recover.skl

recover.obj: recover.asm recchng.inc recseg.inc $(DOSSYM_INC) recequ.inc \
             recdata.inc recmacro.inc $(inc)/sysmsg.inc $(inc)/versiona.inc \
             $(inc)/msgserv.asm $(inc)/copyrigh.inc pathmac.inc \
             $(inc)/msgdcl.inc recover.ctl

recinit.obj: recinit.asm pathmac.inc recseg.inc $(DOSSYM_INC) \
             recequ.inc recmacro.inc recparse.inc $(inc)/psdata.inc \
             $(inc)/parse.asm

recproc.obj: recproc.asm recseg.inc $(DOSSYM_INC) \
             recequ.inc pathmac.inc

recdisp.obj: recdisp.asm pathmac.inc recseg.inc $(DOSSYM_INC)\
             $(inc)/sysmsg.inc  $(inc)/versiona.inc $(inc)/msgserv.asm \
             $(inc)/copyrigh.inc recequ.inc recmsg.inc $(inc)/msgdcl.inc \
             recover.ctl recover.cl1 recover.cl2 recover.cla

OBJS = recdisp.obj recinit.obj recproc.obj recover.obj

recover.com: $(OBJS) RECOVER.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=recover.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name recover.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	../../bldtools/make-com.rb recover.exe recover.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f recover.com
	rm -f recover.cl[12a]
	rm -f recover.ctl
	rm -f recover.exe
	rm -f recover.map
	rm -f resp.txt
