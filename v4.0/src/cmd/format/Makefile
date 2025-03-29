#************************ makefile for cmd/format *************************

msg	=../../messages
inc	=../../inc
boot	=../../boot

COUNTRY = usa-ms

AS = jwasm
ASFLAGS = -q -Zm -Zg -I$(inc) -I$(boot) -Fl

.SUFFIXES: .asm .obj

.asm.obj:
	$(AS) $(ASFLAGS) -Fo$@ $<

#
#######################	dependencies begin here. #########################
#

all: format.com

$(inc)/boot.inc: $(boot)/msboot.asm $(msg)/$(COUNTRY).msg
	make -C $(boot) boot.inc

format.cl1: format.cl1.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

format.cl2: format.cl2.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

format.cla: format.cla.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

format.clb: format.clb.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

format.clc: format.clc.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

format.ctl:     format.skl $(msg)/$(COUNTRY).msg

display.obj:    display.asm forequ.inc formsg.inc formacro.inc \
                format.ctl format.cl1 format.cl2 format.cla $(inc)/sysmsg.inc \
                $(inc)/msgserv.asm \
                format.clb format.clc formacro.inc

forexec.obj:    forexec.asm forequ.inc $(inc)/syscall.inc \
                formacro.inc

forlabel.obj:   forlabel.asm forequ.inc formacro.inc \
                $(inc)/syscall.inc $(inc)/ioctl.inc $(inc)/dosmac.inc \
                forswtch.inc

format.obj:     format.asm $(inc)/dosmac.inc $(inc)/bpb.inc \
                $(inc)/dirent.inc $(inc)/dpb.inc $(inc)/curdir.inc \
                $(inc)/cpmfcb.inc $(inc)/pdb.inc \
                $(inc)/error.inc $(inc)/syscall.inc $(inc)/ioctl.inc \
                forequ.inc formacro.inc forswtch.inc

forinit.obj:    forinit.asm forequ.inc formacro.inc \
                $(inc)/syscall.inc $(inc)/ioctl.inc forparse.inc \
                forswtch.inc $(inc)/parse.asm $(inc)/psdata.inc

msfor.obj:      msfor.asm $(inc)/dosmac.inc $(inc)/syscall.inc $(inc)/bpb.inc \
                $(inc)/dirent.inc $(boot)/boot.cl1 $(inc)/ioctl.inc \
                $(inc)/boot.inc $(inc)/boot11.inc \
                $(inc)/bootform.inc filesize.inc forequ.inc formacro.inc forswtch.inc

forproc.obj:    forproc.asm $(inc)/syscall.inc forequ.inc \
                formacro.inc forswtch.inc

OBJS = display.obj forinit.obj forlabel.obj format.obj forproc.obj msfor.obj \
       forexec.obj

format.com: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=format.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'option stack=0x1F0' >>resp.txt
	echo 'name format.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	../../tools/make-com.rb format.exe format.com

clean:
	rm -f *.obj *.exe *.lst *.err
	rm -f format.exe format.com format.map
	rm -f format.cl?
	rm -f resp.txt
