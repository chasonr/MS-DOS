#************************** makefile for cmd\append ***************************

msg	=..\..\messages
dos	=..\..\dos
inc	=..\..\inc
hinc	=..\..\h

#
#######################	dependencies begin here. #########################
#

all: append.exe

append.ctl: append.skl $(msg)\$(COUNTRY).msg

append.obj: append.asm appendp.inc $(inc)\parse.asm append.ctl

append.exe: append.obj
        link append;

clean:
	@if exist *.obj del *.obj
	@if exist append.cl1 del append.cl1
	@if exist append.cl2 del append.cl2
	@if exist append.cla del append.cla
	@if exist append.clb del append.clb
	@if exist append.ctl del append.ctl
	@if exist append.exe del append.exe
