#************************ makefile for cmd/share *************************

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

all: share.exe

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

share.ctl share.cl1 share.cl2 share.cla: share.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG share.skl

gshare.obj: gshare.asm sharehdr.inc $(DOSSYM_INC) $(inc)/dpl.asm \
            $(inc)/dosseg.asm $(inc)/bugtyp.asm $(inc)/mft.inc

gshare2.obj: gshare2.asm sharehdr.inc $(DOSSYM_INC) $(inc)/sysmsg.inc \
             $(inc)/msgserv.asm $(inc)/copyrigh.inc $(inc)/versiona.inc \
             $(inc)/dosseg.asm $(inc)/bugtyp.asm $(inc)/mft.inc \
             $(inc)/msgdcl.inc \
             share.ctl

sharesr.obj: sharesr.asm sharehdr.inc $(inc)/sysmsg.inc $(inc)/msgserv.asm \
             $(inc)/copyrigh.inc $(inc)/versiona.inc $(inc)/parse.asm \
             $(inc)/psdata.inc $(inc)/msgdcl.inc \
             share.ctl share.cl1 share.cl2 share.cla

sharelnk.obj: sharelnk.asm $(DOSSYM_INC) $(inc)/devsym.inc $(inc)/dosseg.asm

$(inc)/nibdos.obj:
	$(MAKE) -C $(inc) nibdos.obj

$(inc)/const2.obj:
	$(MAKE) -C $(inc) const2.obj

$(inc)/msdata.obj:
	$(MAKE) -C $(inc) msdata.obj

$(inc)/msdosme.obj:
	$(MAKE) -C $(inc) msdosme.obj

OBJS = gshare.obj gshare2.obj sharesr.obj sharelnk.obj $(inc)/nibdos.obj \
       $(inc)/const2.obj $(inc)/msdata.obj $(inc)/msdosme.obj

share.exe: share.ctl $(OBJS) SHARE.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=share.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name share.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f share.cl[12a]
	rm -f share.ctl
	rm -f share.exe
	rm -f share.map
	rm -f resp.txt
