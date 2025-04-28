#************************ makefile for cmd/format *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H
boot	=../../BOOT

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

all: format.com

boot.cl1: $(boot)/boot.cl1
	cp $(boot)/boot.cl1 .

$(boot)/boot.cl1:
	$(MAKE) -C $(boot)

format.ctl format.cl1 format.cl2 format.cla format.clb format.clc: \
        FORMAT.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\format $(subst /,\,$<) $(country)"

display.obj:    display.asm forchng.inc forequ.inc formsg.inc format.ctl \
                format.cl1 format.cl2 format.cla format.clb format.clc \
                $(inc)/sysmsg.inc $(inc)/versiona.inc $(inc)/msgserv.asm \
                $(inc)/copyrigh.inc

forexec.obj:    forexec.asm forchng.inc formacro.inc $(inc)/syscall.inc \
                forequ.inc

forlabel.obj:   forlabel.asm forchng.inc formacro.inc $(inc)/syscall.inc \
                forequ.inc forswtch.inc

format.obj:     format.asm $(inc)/versiona.inc $(inc)/dosmac.inc \
                $(inc)/syscall.inc $(inc)/error.inc $(inc)/dpb.inc \
                $(inc)/cpmfcb.inc $(inc)/dirent.inc $(inc)/curdir.inc \
                $(inc)/pdb.inc $(inc)/bpb.inc forequ.inc formacro.inc \
                $(inc)/ioctl.inc $(inc)/bpb.inc forswtch.inc \
                $(inc)/sysvar.inc $(inc)/version.inc

forinit.obj:    forinit.asm  forchng.inc formacro.inc $(inc)/syscall.inc \
                $(inc)/ioctl.inc $(inc)/bpb.inc forequ.inc forparse.inc \
                $(inc)/parse.asm $(inc)/psdata.inc forswtch.inc

msfor.obj:      msfor.asm forchng.inc $(inc)/dosmac.inc formacro.inc \
                forequ.inc forswtch.inc $(inc)/syscall.inc filesize.inc \
                $(inc)/dirent.inc $(inc)/ioctl.inc $(inc)/bpb.inc \
                $(inc)/version.inc $(inc)/boot11.inc $(inc)/bootform.inc \
                $(inc)/boot.inc boot.cl1

forproc.obj:    forproc.asm forchng.inc $(inc)/syscall.inc forequ.inc \
                formacro.inc forswtch.inc $(inc)/ioctl.inc $(inc)/bpb.inc

OBJS = display.obj forinit.obj forlabel.obj format.obj forproc.obj msfor.obj \
       forexec.obj

format.com: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option stack=496' >>resp.txt
	echo 'option map=format.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name format.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\format\format.exe"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f boot.cl1
	rm -f format.com
	rm -f format.exe
	rm -f format.cl[12a-c]
	rm -f format.ctl
	rm -f format.map
	rm -f resp.txt
