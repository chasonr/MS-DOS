#************************ makefile for cmd\format *************************

msg	=..\..\messages
dos	=..\..\dos
inc	=..\..\inc
hinc	=..\..\h
boot	=..\..\boot

#
#######################	dependencies begin here. #########################
#

all: format.com

boot.cl1:
		copy $(boot)\boot.cl1

format.ctl:     format.skl $(msg)\$(COUNTRY).msg

display.obj:    display.asm forequ.inc formsg.inc formacro.inc makefile \
                format.ctl format.cl1 format.cl2 format.cla $(inc)\sysmsg.inc \
                $(inc)\msgserv.asm \
                format.clb format.clc formacro.inc

forexec.obj:    forexec.asm forequ.inc makefile $(inc)\syscall.inc \
                formacro.inc

forlabel.obj:   forlabel.asm forequ.inc formacro.inc makefile \
                $(inc)\syscall.inc $(inc)\ioctl.inc $(inc)\dosmac.inc \
                forswtch.inc

format.obj:     format.asm $(inc)\dosmac.inc $(inc)\bpb.inc \
                $(inc)\dirent.inc $(inc)\dpb.inc $(inc)\curdir.inc \
                $(inc)\cpmfcb.inc $(inc)\pdb.inc makefile \
                $(inc)\error.inc $(inc)\syscall.inc $(inc)\ioctl.inc \
                forequ.inc formacro.inc forswtch.inc

forinit.obj:    forinit.asm forequ.inc formacro.inc makefile \
                $(inc)\syscall.inc $(inc)\ioctl.inc forparse.inc \
                forswtch.inc $(inc)\parse.asm $(inc)\psdata.inc

msfor.obj:      msfor.asm $(inc)\dosmac.inc $(inc)\syscall.inc $(inc)\bpb.inc \
                $(inc)\dirent.inc boot.cl1 $(inc)\ioctl.inc \
                $(inc)\boot.inc $(inc)\boot11.inc makefile \
                $(inc)\bootform.inc filesize.inc forequ.inc formacro.inc forswtch.inc

forproc.obj:    forproc.asm $(inc)\syscall.inc makefile forequ.inc \
                formacro.inc forswtch.inc


format.com:     format.obj forproc.obj msfor.obj forexec.obj display.obj \
                forinit.obj forlabel.obj 
        link  @format.lnk
        convert format.exe
        del format.exe

clean:
	@if exist *.obj del *.obj
	@if exist boot.cl1 del boot.cl1
	@if exist format.com del format.com
	@if exist format.cl1 del format.cl1
	@if exist format.cl2 del format.cl2
	@if exist format.cla del format.cla
	@if exist format.clb del format.clb
	@if exist format.clc del format.clc
	@if exist format.ctl del format.ctl
	@if exist format.map del format.map
