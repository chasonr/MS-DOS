#************************** makefile for cmd/append ***************************

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

all: append.exe

append.ctl append.cl1 append.cl2 append.cla append.clb: \
        append.skl $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg append.skl

append.obj: append.asm appendp.inc sysmac.lib $(inc)/copyrigh.inc \
            $(inc)/msgdcl.inc $(inc)/msgserv.asm $(inc)/parse.asm \
            $(inc)/pdb.inc $(inc)/psdata.inc $(inc)/sysmsg.inc \
            $(inc)/versiona.inc \
            append.ctl append.cl1 append.cl2 append.cla append.clb

OBJS = append.obj

append.exe: append.obj
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=append.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name append.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f append.cl[12ab]
	rm -f append.ctl
	rm -f append.exe
	rm -f append.map
	rm -f resp.txt
