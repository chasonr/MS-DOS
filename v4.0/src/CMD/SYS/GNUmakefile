#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
boot	=../../BOOT
here	=../CMD/SYS

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

all: sys.com

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

$(inc)/boot.inc: $(boot)/msboot.asm $(msg)/$(COUNTRY).MSG
	$(MAKE) -C $(boot)

sys.ctl sys.cl1 sys.cl2 sys.cla sys.clb sys.clc sys.cld: sys.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG sys.skl

sys1.obj: sys1.asm syshdr.inc $(DOSSYM_INC) $(inc)/bootform.inc \
          $(inc)/boot.inc $(inc)/copyrigh.inc $(inc)/ioctl.inc \
          $(inc)/msgdcl.inc $(inc)/msgserv.asm $(inc)/pathmac.inc \
          $(inc)/sysmsg.inc \
          sys.ctl

sys2.obj: sys2.asm syshdr.inc $(DOSSYM_INC) $(inc)/bootform.inc \
          $(inc)/ioctl.inc $(inc)/pathmac.inc

syssr.obj: syssr.asm syshdr.inc $(DOSSYM_INC) $(inc)/bootform.inc \
           $(inc)/copyrigh.inc $(inc)/ioctl.inc $(inc)/msgdcl.inc \
           $(inc)/msgserv.asm $(inc)/parse.asm $(inc)/pathmac.inc \
           $(inc)/psdata.inc $(inc)/sysmsg.inc \
           sys.ctl sys.cl1 sys.cl2 sys.cla sys.clb sys.clc sys.cld

OBJS = sys1.obj sys2.obj syssr.obj

sys.com: sys.ctl $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=sys.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name sys.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q sys.exe sys.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f sys.com
	rm -f sys.exe
	rm -f sys.cl[12a-d]
	rm -f sys.ctl
	rm -f sys.map
	rm -f resp.txt
