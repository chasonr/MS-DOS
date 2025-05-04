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

all: ifsfunc.exe

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

ifsfunc.ctl ifsfunc.cl1 ifsfunc.cl2 ifsfunc.cla: ifsfunc.skl  $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG ifsfunc.skl

ifssess.obj: ifssess.asm $(inc)/ifssym.inc ifsfsym.inc $(DOSSYM_INC) \
             $(inc)/devsym.inc $(inc)/bugtyp.asm $(inc)/copyrigh.inc

ifsdir.obj: ifsdir.asm ifsdir.asm $(inc)/ifssym.inc ifsfsym.inc $(DOSSYM_INC) \
            $(inc)/devsym.inc $(inc)/dosseg.asm

ifsfile.obj: ifsfile.asm $(inc)/ifssym.inc ifsfsym.inc $(DOSSYM_INC) \
             $(inc)/devsym.inc $(inc)/doscntry.inc $(inc)/dosseg.asm \
             $(inc)/bugtyp.asm

ifshand.obj: ifshand.asm $(inc)/ifssym.inc ifsfsym.inc $(DOSSYM_INC) \
             $(inc)/devsym.inc $(inc)/dosseg.asm

ifsdev.obj:  ifsdev.asm $(inc)/ifssym.inc ifsfsym.inc $(DOSSYM_INC) \
             $(inc)/devsym.inc $(inc)/dosseg.asm

ifsutil.obj: ifsutil.asm $(inc)/ifssym.inc ifsfsym.inc $(DOSSYM_INC) \
             $(inc)/devsym.inc $(inc)/dosseg.asm $(inc)/bugtyp.asm

ifserror.obj: ifserror.asm $(inc)/ifssym.inc ifsfsym.inc $(DOSSYM_INC) \
              $(inc)/devsym.inc $(inc)/sysmsg.inc $(inc)/msgserv.asm \
              $(inc)/copyrigh.inc $(inc)/dosseg.asm $(inc)/msgdcl.inc \
              ifsfunc.ctl ifsfunc.cl1

ifsfdos.obj:  ifsfdos.asm ifsfsym.inc $(inc)/ifssym.inc $(DOSSYM_INC) \
              $(inc)/devsym.inc $(inc)/dosseg.asm

ifsinit.obj:  ifsinit.asm ifsfsym.inc $(inc)/ifssym.inc $(DOSSYM_INC) \
              $(inc)/devsym.inc $(inc)/sysmsg.inc $(inc)/msgserv.asm \
              $(inc)/copyrigh.inc $(inc)/dosseg.asm ifsparse.inc \
              $(inc)/parse.asm $(inc)/psdata.inc $(inc)/msgdcl.inc \
              ifsfunc.ctl ifsfunc.cl2 ifsfunc.cla

$(inc)/nibdos.obj:
	$(MAKE) -C $(inc) nibdos.obj

$(inc)/const2.obj:
	$(MAKE) -C $(inc) const2.obj

$(inc)/msdata.obj:
	$(MAKE) -C $(inc) msdata.obj

$(inc)/mstable.obj:
	$(MAKE) -C $(inc) mstable.obj

$(inc)/msdosme.obj:
	$(MAKE) -C $(inc) msdosme.obj

$(dos)/msdisp.obj:
	$(MAKE) -C $(dos) msdisp.obj

$(dos)/mscode.obj:
	$(MAKE) -C $(dos) mscode.obj

ifsflink.obj: ifsflink.asm $(DOSSYM_INC) $(inc)/devsym.inc $(inc)/dosseg.asm

OBJS = ifssess.obj ifsdir.obj ifsfile.obj ifshand.obj ifsdev.obj ifsutil.obj \
       ifserror.obj ifsfdos.obj ifsinit.obj $(inc)/nibdos.obj \
       $(inc)/const2.obj $(inc)/msdata.obj $(inc)/mstable.obj \
       $(dos)/msdisp.obj $(dos)/mscode.obj $(inc)/msdosme.obj ifsflink.obj

ifsfunc.exe: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option stack=406' >>resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=ifsfunc.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name ifsfunc.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f ifsfunc.cl[12a]
	rm -f ifsfunc.ctl
	rm -f ifsfunc.exe
	rm -f ifsfunc.map
	rm -f resp.txt
