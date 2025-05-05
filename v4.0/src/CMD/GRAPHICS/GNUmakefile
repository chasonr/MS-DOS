#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: graphics.com


graphics.ctl graphics.cl1 graphics.cl2 graphics.cla graphics.clb graphics.clc: \
        graphics.skl $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg graphics.skl

graphics.obj: graphics.asm  grinst.ext

grinst.obj: grinst.asm grload.ext grload2.ext grload3.ext grctrl.ext \
            grcpsd.ext grparms.ext grparse.ext grbwprt.ext grcolprt.ext \
            grint2fh.ext grmsg.equ grshar.str $(inc)/sysmsg.inc \
            $(inc)/copyrigh.inc $(inc)/msgdcl.inc \
            $(inc)/msgserv.asm $(inc)/versiona.inc \
            graphics.ctl graphics.cl1 graphics.cl2 graphics.cla graphics.clb \
            graphics.clc

grcpsd.obj: grcpsd.asm grctrl.ext grctrl.str

grparse.obj: grparse.asm $(inc)/parse.asm $(inc)/psdata.inc

grpattrn.obj: grpattrn.asm grpattrn.str

grbwprt.obj: grbwprt.asm grctrl.str grshar.str \
	     grpattrn.str grctrl.ext grcommon.asm

grint2fh.obj: grint2fh.asm grinst.ext grctrl.ext grcpsd.ext

grctrl.obj: grctrl.asm grint2fh.ext grbwprt.ext grcolprt.ext grshar.str \
	    grpattrn.str grpattrn.ext grctrl.str

grcolprt.obj: grcolprt.asm grctrl.str grshar.str grpattrn.str grctrl.ext  \
	      grcommon.asm

grload.obj: grload.asm grinst.ext grshar.str grparse.ext \
	    grload2.ext grload3.ext grmsg.equ

grload2.obj: grload2.asm grinst.ext grshar.str grmsg.equ \
	     grinst.ext grload.ext grparse.ext grpattrn.str grpattrn.ext

grload3.obj: grload3.asm grinst.ext grshar.str grmsg.equ \
	     grinst.ext grload.ext grload2.ext grparse.ext grpattrn.str \
	     grpattrn.ext

grparms.obj: grparms.asm grmsg.equ grshar.str grinst.ext grparse.ext

OBJS = graphics.obj grint2fh.obj grpattrn.obj grctrl.obj grcpsd.obj \
       grcolprt.obj grbwprt.obj grinst.obj grparse.obj grparms.obj \
       grload.obj grload2.obj grload3.obj

graphics.com: $(OBJS) GRAPHICS.LNK
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=graphics.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name graphics.com' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f graphics.com
	rm -f graphics.map
	rm -f graphics.cl[12a-c]
	rm -f graphics.ctl
	rm -f resp.txt
