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

all: graftabl.com

graftabl.ctl graftabl.cl1 graftabl.cl2 graftabl.cla: graftabl.skl \
    $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg graftabl.skl

grtab.obj: grtab.asm $(inc)/pathmac.inc

grtabp.obj: grtabp.asm \
    $(inc)/pathmac.inc \
    $(inc)/psdata.inc \
    $(inc)/parse.asm

grtabsm.obj: grtabsm.asm \
    $(inc)/copyrigh.inc \
    $(inc)/versiona.inc \
    $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm \
    $(inc)/pathmac.inc \
    $(inc)/msgdcl.inc \
    graftabl.ctl \
    graftabl.cl1 \
    graftabl.cl2 \
    graftabl.cla \
    $(inc)/msghan.inc \
    grtabms.inc

grtabpar.obj: grtabpar.asm $(inc)/pathmac.inc

grtabhan.obj: grtabhan.asm $(inc)/pathmac.inc

grtabus.obj: grtabus.asm

grtabno.obj: grtabno.asm

grtabpo.obj: grtabpo.asm

grtabcf.obj: grtabcf.asm

grtabml.obj: grtabml.asm

OBJS = grtabhan.obj grtabus.obj grtabml.obj grtabpo.obj grtabcf.obj \
       grtabno.obj grtabsm.obj grtabpar.obj grtabp.obj grtab.obj

graftabl.com: $(OBJS) GRAFTABL.LNK
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=graftabl.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name graftabl.com' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f graftabl.com
	rm -f graftabl.map
	rm -f graftabl.cl[12a]
	rm -f graftabl.ctl
	rm -f resp.txt
