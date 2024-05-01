#************************** makefile for cmd\... ***************************

msg	=..\..\messages
dos	=..\..\dos
inc	=..\..\inc
hinc	=..\..\h
boot	=..\..\boot
here	=..\cmd\sys

#
#######################	dependencies begin here. #########################
#

all: sys.com

$(inc)\boot.inc: $(boot)\msboot.asm $(msg)\$(COUNTRY).msg
        cd $(boot)
        nmake
        cd $(here)

sys.ctl: sys.skl $(msg)\$(COUNTRY).msg

sys1.obj: sys1.asm $(inc)\dossym.inc $(inc)\dosmac.inc \
    $(inc)\bpb.inc $(inc)\buffer.inc $(inc)\sysvar.inc \
    $(inc)\mult.inc $(inc)\dirent.inc $(inc)\dpb.inc \
    $(inc)\curdir.inc $(inc)\cpmfcb.inc $(inc)\find.inc \
    $(inc)\pdb.inc $(inc)\sf.inc $(inc)\arena.inc $(inc)\intnat.inc \
    $(inc)\error.inc $(inc)\syscall.inc $(inc)\ioctl.inc \
    $(inc)\bootform.inc $(inc)\boot.inc syshdr.inc

sys2.obj: sys2.asm $(inc)\dossym.inc $(inc)\dosmac.inc \
    $(inc)\bpb.inc $(inc)\buffer.inc $(inc)\sysvar.inc \
    $(inc)\mult.inc $(inc)\dirent.inc $(inc)\dpb.inc \
    $(inc)\curdir.inc $(inc)\cpmfcb.inc $(inc)\find.inc \
    $(inc)\pdb.inc $(inc)\sf.inc $(inc)\arena.inc $(inc)\intnat.inc \
    $(inc)\error.inc $(inc)\syscall.inc $(inc)\ioctl.inc \
    $(inc)\bootform.inc $(inc)\boot.inc syshdr.inc

syssr.obj: syssr.asm $(inc)\parse.asm \
    $(inc)\psdata.inc $(inc)\msgserv.asm $(inc)\sysmsg.inc \
    sys.ctl sys.cl1 sys.cl2 sys.cla sys.clb sys.clc sys.cld

sys.com: sys.ctl sys1.obj syssr.obj sys1.obj sys2.obj
        link @sys.lnk
        exe2bin sys.exe sys.com
        del sys.exe

clean:
	@if exist *.obj del *.obj
	@if exist sys.com del sys.com
	@if exist sys.cl1 del sys.cl1
	@if exist sys.cl2 del sys.cl2
	@if exist sys.cla del sys.cla
	@if exist sys.clb del sys.clb
	@if exist sys.clc del sys.clc
	@if exist sys.cld del sys.cld
	@if exist sys.ctl del sys.ctl
	@if exist sys.map del sys.map
