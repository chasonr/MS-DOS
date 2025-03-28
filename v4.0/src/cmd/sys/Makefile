#************************** makefile for cmd/... ***************************

msg	=../../messages
inc	=../../inc
boot	=../../boot

COUNTRY = usa-ms

AS = jwasm
ASFLAGS = -q -Zm -Zg -I$(inc) -Fl

#
#######################	dependencies begin here. #########################
#

all: sys.com

.SUFFIXES: .asm .obj

.asm.obj:
	$(AS) $(ASFLAGS) -Fo$@ $<

$(inc)/boot.inc: $(boot)/msboot.asm $(msg)/$(COUNTRY).msg
	make -C $(boot) boot.inc

sys.cl1: sys.cl1.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

sys.cl2: sys.cl2.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

sys.cla: sys.cla.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

sys.clb: sys.clb.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

sys.clc: sys.clc.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

sys.cld: sys.cld.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

sys1.obj: sys1.asm $(inc)/dossym.inc $(inc)/dosmac.inc \
    $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
    $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
    $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
    $(inc)/pdb.inc $(inc)/sf.inc $(inc)/arena.inc $(inc)/intnat.inc \
    $(inc)/error.inc $(inc)/syscall.inc $(inc)/ioctl.inc \
    $(inc)/bootform.inc $(inc)/boot.inc syshdr.inc

sys2.obj: sys2.asm $(inc)/dossym.inc $(inc)/dosmac.inc \
    $(inc)/bpb.inc $(inc)/buffer.inc $(inc)/sysvar.inc \
    $(inc)/mult.inc $(inc)/dirent.inc $(inc)/dpb.inc \
    $(inc)/curdir.inc $(inc)/cpmfcb.inc $(inc)/find.inc \
    $(inc)/pdb.inc $(inc)/sf.inc $(inc)/arena.inc $(inc)/intnat.inc \
    $(inc)/error.inc $(inc)/syscall.inc $(inc)/ioctl.inc \
    $(inc)/bootform.inc $(inc)/boot.inc syshdr.inc

syssr.obj: syssr.asm $(inc)/parse.asm \
    $(inc)/psdata.inc $(inc)/msgserv.asm $(inc)/sysmsg.inc \
    sys.ctl sys.cl1 sys.cl2 sys.cla sys.clb sys.clc sys.cld

OBJS = sys1.obj sys2.obj syssr.obj

sys.com: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=sys.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name sys.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q sys.exe sys.com

clean:
	rm -f *.obj *.exe *.lst *.err
	rm -f sys.exe sys.com sys.map
	rm -f sys.cl?
	rm -f resp.txt
