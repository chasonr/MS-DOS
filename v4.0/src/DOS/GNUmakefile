#*************************** Makefile for DOS ***************************

msg	=../MESSAGES
inc	=../INC
hinc	=../HINC
dos	=.

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
###################### Dependencies begin here ##########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl -Sa

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: msdos.sys

msdos.cl1: msdos.skl \
	$(msg)/$(COUNTRY).MSG 
	../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG msdos.skl

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

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

msdisp.obj: msdisp.asm mssw.asm disp.asm \
	     $(DOSSYM_INC) $(inc)/dosseg.asm

mscode.obj: mscode.asm mssw.asm ms_code.asm \
	     $(DOSSYM_INC) $(inc)/dosseg.asm $(inc)/devsym.inc \
            $(inc)/fastopen.inc $(inc)/fastxxxx.inc

time.obj: time.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
	  $(inc)/devsym.inc

getset.obj: getset.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/doscntry.inc

parse.obj: parse.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

misc.obj: misc.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/bugtyp.asm

misc2.obj: misc2.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/bugtyp.asm

crit.obj: crit.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/bugtyp.asm

cpmio.obj: cpmio.asm $(inc)/dosseg.asm \
    $(DOSSYM_INC) \
    $(inc)/devsym.inc \
    kstrin.asm strin.asm

cpmio2.obj: cpmio2.asm $(inc)/dosseg.asm \
    $(DOSSYM_INC) $(inc)/devsym.inc

fcbio.obj: fcbio.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/sf.inc $(inc)/fastopen.inc

fcbio2.obj: fcbio2.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

search.obj: search.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

path.obj: path.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

ioctl.obj: ioctl.asm $(inc)/ioctl.inc $(inc)/dosseg.asm \
    $(DOSSYM_INC) $(inc)/devsym.inc

delete.obj: delete.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/sf.inc $(inc)/fastxxxx.inc $(inc)/fastopen.inc

rename.obj: rename.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/sf.inc

finfo.obj: finfo.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

dup.obj: dup.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

create.obj: create.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

open.obj: open.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/fastopen.inc

dinfo.obj: dinfo.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
   $(inc)/devsym.inc $(inc)/bugtyp.asm $(inc)/buffer.inc

isearch.obj: isearch.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

abort.obj: abort.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/sf.inc

close.obj: close.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/buffer.inc

dircall.obj: dircall.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/buffer.inc $(inc)/fastopen.inc

disk.obj: disk.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

disk2.obj: disk2.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/buffer.inc

disk3.obj: disk3.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

dir.obj: dir.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
	 $(inc)/buffer.inc $(inc)/fastopen.inc

dir2.obj: dir2.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
	  $(inc)/buffer.inc $(inc)/fastopen.inc

dev.obj: dev.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

mknode.obj: mknode.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc  $(inc)/buffer.inc $(inc)/fastopen.inc \
    $(inc)/filemode.inc

rom.obj: rom.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc  $(inc)/buffer.inc

fcb.obj: fcb.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

msctrlc.obj: msctrlc.asm mssw.asm ctrlc.asm \
    $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

fat.obj: fat.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/buffer.inc $(inc)/curdir.inc

buf.obj: buf.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/buffer.inc

proc.obj: proc.asm \
    $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
    $(inc)/curdir.inc \
    exec.asm

alloc.obj: alloc.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

srvcall.obj: srvcall.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

util.obj: util.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

macro.obj: macro.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc  $(inc)/curdir.inc

macro2.obj: macro2.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/curdir.inc

handle.obj: handle.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/bugtyp.asm

file.obj: file.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/bugtyp.asm $(inc)/fastopen.inc \
    $(inc)/filemode.inc

lock.obj: lock.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

share.obj: share.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc

extattr.obj: extattr.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/ea.inc $(inc)/buffer.inc

ifs.obj: ifs.asm $(inc)/dosseg.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc $(inc)/doscntry.inc $(inc)/buffer.inc

OBJS = $(inc)/nibdos.obj $(inc)/const2.obj $(inc)/msdata.obj \
       $(inc)/mstable.obj msdisp.obj mscode.obj $(inc)/msdosme.obj time.obj \
       getset.obj parse.obj misc.obj misc2.obj crit.obj cpmio.obj cpmio2.obj \
       fcbio.obj fcbio2.obj search.obj path.obj ioctl.obj delete.obj \
       rename.obj finfo.obj dup.obj create.obj open.obj dinfo.obj \
       isearch.obj abort.obj close.obj dircall.obj disk.obj disk2.obj \
       disk3.obj dir.obj dir2.obj dev.obj mknode.obj rom.obj fcb.obj \
       msctrlc.obj fat.obj buf.obj proc.obj alloc.obj srvcall.obj util.obj \
       handle.obj macro.obj macro2.obj file.obj lock.obj share.obj \
       extattr.obj ifs.obj

msdos.sys: msdos.cl1 $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=msdos.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msdos.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q msdos.exe msdos.sys
	rm msdos.exe

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f msdos.cl1
	rm -f msdos.cl3
	rm -f msdos.sys
	rm -f msdos.map
	rm -f resp.txt
