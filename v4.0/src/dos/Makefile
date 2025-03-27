#*************************** Makefile for DOS ***************************

msg	=../messages
inc	=../inc

COUNTRY = usa-ms

AS = jwasm
ASFLAGS = -q -Zm -Zg -I$(inc) -Fl

#
###################### Dependencies begin here ##########################
#

DOSSYM_INC = $(inc)/dossym.inc $(inc)/dbcs.sw $(inc)/dosmac.inc \
             $(inc)/versiona.inc $(inc)/bpb.inc $(inc)/buffer.inc \
             $(inc)/sysvar.inc $(inc)/version.inc $(inc)/vector.inc \
             $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
             $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
             $(inc)/pdb.inc $(inc)/exe.inc $(inc)/sf.inc $(inc)/arena.inc \
             $(inc)/intnat.inc $(inc)/mi.inc $(inc)/filemode.inc \
             $(inc)/error.inc $(inc)/syscall.inc

all: msdos.sys

msdos.cl1: msdos.cl1.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

msdos.cl3: msdos.cl3.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat


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

.SUFFIXES: .asm .obj

.asm.obj:
	$(AS) $(ASFLAGS) -Fo$@ $<

msdisp.obj: msdisp.asm mssw.asm $(inc)/version.inc disp.asm $(DOSSYM_INC) \
            $(inc)/dosseg.asm

mscode.obj: mscode.asm mssw.asm $(inc)/version.inc ms_code.asm $(DOSSYM_INC) \
            $(inc)/devsym.inc $(inc)/dosseg.asm $(inc)/ifssym.inc \
            $(inc)/fastopen.inc $(inc)/fastxxxx.inc

time.obj: time.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

getset.obj: getset.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
            $(inc)/doscntry.inc

parse.obj: parse.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

misc.obj: misc.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

misc2.obj: misc2.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/fastseek.inc \
           $(inc)/fastxxxx.inc

crit.obj: crit.asm $(inc)/dosseg.asm $(DOSSYM_INC)

cpmio.obj: cpmio.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
           $(inc)/doscntry.inc kstrin.asm strin.asm

cpmio2.obj: cpmio2.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

fcbio.obj: fcbio.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
           $(inc)/fastopen.inc

fcbio2.obj: fcbio2.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
            $(inc)/version.inc

search.obj: search.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
            $(inc)/fastopen.inc $(inc)/fastxxxx.inc

path.obj: path.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

ioctl.obj: ioctl.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
           $(inc)/ioctl.inc $(inc)/ifssym.inc

delete.obj: delete.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
            $(inc)/fastopen.inc $(inc)/fastseek.inc $(inc)/fastxxxx.inc

rename.obj: rename.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

finfo.obj: finfo.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
           $(inc)/fastxxxx.inc $(inc)/fastopen.inc

dup.obj: dup.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

create.obj: create.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
            $(inc)/version.inc

open.obj: open.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
          $(inc)/fastopen.inc $(inc)/fastxxxx.inc $(inc)/ifssym.inc

dinfo.obj: dinfo.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

isearch.obj: isearch.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
             $(inc)/fastopen.inc $(inc)/fastxxxx.inc

abort.obj: abort.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

close.obj: close.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

dircall.obj: dircall.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
             $(inc)/fastopen.inc $(inc)/fastxxxx.inc

disk.obj: disk.asm $(inc)/dosseg.asm $(inc)/fastseek.inc $(inc)/fastxxxx.inc \
          $(DOSSYM_INC) $(inc)/devsym.inc $(inc)/version.inc

disk2.obj: disk2.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
           $(inc)/version.inc

disk3.obj: disk3.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
           $(inc)/version.inc

dir.obj: dir.asm $(inc)/dosseg.asm $(inc)/fastopen.inc $(DOSSYM_INC)

dir2.obj: dir2.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
          $(inc)/fastopen.inc

dev.obj: dev.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
         $(inc)/version.inc

mknode.obj: mknode.asm $(inc)/dosseg.asm $(inc)/fastopen.inc $(DOSSYM_INC) \
            $(inc)/devsym.inc

rom.obj: rom.asm $(inc)/dosseg.asm $(inc)/fastseek.inc $(inc)/fastxxxx.inc \
         $(inc)/version.inc $(DOSSYM_INC) $(inc)/devsym.inc $(inc)/ea.inc

fcb.obj: fcb.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
         $(inc)/doscntry.inc

msctrlc.obj: msctrlc.asm mssw.asm $(inc)/version.inc ctrlc.asm \
             $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
             $(inc)/version.inc

fat.obj: fat.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

buf.obj: buf.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
         $(inc)/version.inc

proc.obj: proc.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc exec.asm \
          $(inc)/ea.inc $(inc)/version.inc

alloc.obj: alloc.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

srvcall.obj: srvcall.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
             $(inc)/dpl.asm

util.obj: util.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

macro.obj: macro.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

macro2.obj: macro2.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

handle.obj: handle.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
            $(inc)/ea.inc $(inc)/version.inc

file.obj: file.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
          $(inc)/fastopen.inc $(inc)/ea.inc $(inc)/version.inc

lock.obj: lock.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
          $(inc)/lock.inc

share.obj: share.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc

extattr.obj: extattr.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
             $(inc)/ea.inc

ifs.obj: ifs.asm $(inc)/dosseg.asm $(DOSSYM_INC) $(inc)/devsym.inc \
         $(inc)/doscntry.inc

DOS_OBJS = $(inc)/nibdos.obj $(inc)/const2.obj $(inc)/msdata.obj \
           $(inc)/mstable.obj msdisp.obj mscode.obj $(inc)/msdosme.obj \
           time.obj getset.obj parse.obj misc.obj misc2.obj crit.obj \
           cpmio.obj cpmio2.obj fcbio.obj fcbio2.obj search.obj path.obj \
           ioctl.obj delete.obj rename.obj finfo.obj dup.obj create.obj \
           open.obj dinfo.obj isearch.obj abort.obj close.obj dircall.obj \
           disk.obj disk2.obj disk3.obj dir.obj dir2.obj dev.obj mknode.obj \
           rom.obj fcb.obj msctrlc.obj fat.obj buf.obj proc.obj alloc.obj \
           srvcall.obj util.obj handle.obj macro.obj macro2.obj file.obj \
           lock.obj share.obj extattr.obj ifs.obj

msdos.sys: $(DOS_OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=msdos.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msdos.exe' >>resp.txt
	for x in $(DOS_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q msdos.exe msdos.sys

clean:
	rm -f *.obj *.lst *.err
	@rm -f msdos.cl1
	@rm -f msdos.cl3
	rm -f msdos.exe
	rm -f msdos.sys
	rm -f msdos.map
	rm -f resp.txt
