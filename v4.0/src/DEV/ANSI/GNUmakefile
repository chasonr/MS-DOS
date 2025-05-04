#*********************** Makefile for ansi.sys ****************************

dos	=../../DOS
inc	=../../INC
msg	=../../MESSAGES

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
####################### Dependencies Begin Here ##########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: ansi.sys

ansi.ctl ansi.cl1 ansi.cl2 ansi.cla: ansi.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG ansi.skl

ansi.obj:       ansi.asm ansi.inc \
                $(inc)/vector.inc \
                $(inc)/mult.inc

ioctl.obj:      ioctl.asm ansi.inc

ansiinit.obj:   ansiinit.asm ansi.inc ansivid.inc

parser.obj:     parser.asm ansi.inc $(inc)/sysmsg.inc $(inc)/msgserv.asm \
                $(inc)/copyrigh.inc $(inc)/versiona.inc $(inc)/parse.asm \
                $(inc)/psdata.inc $(inc)/msgdcl.inc \
                ansi.ctl ansi.cl1 ansi.cl2 ansi.cla

OBJS = ansi.obj ioctl.obj ansiinit.obj parser.obj

ansi.sys: $(OBJS) ANSI.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=ansi.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name ansi.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q ansi.exe ansi.sys

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f ansi.sys
	rm -f ansi.exe
	rm -f ansi.cl[12a]
	rm -f ansi.ctl
	rm -f ansi.map
	rm -f resp.txt
