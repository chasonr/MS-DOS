#************************* makefile for cmd/comp *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

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

all: comp.com

comp.ctl comp.ct1 comp.ct2 comp.cta: COMP.SKL \
    $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\comp $(subst /,\,$<) $(country)"

comp1.obj: comp1.asm

comppar.obj: comppar.asm \
    compeq.inc

compp.obj: compp.asm \
    $(inc)/parse.asm $(inc)/psdata.inc

compsm.obj: compsm.asm \
    $(inc)/copyrigh.inc \
    $(inc)/versiona.inc \
    $(inc)/sysmsg.inc \
    $(inc)/msghan.inc \
    $(inc)/msgserv.asm \
    $(inc)/msgdcl.inc \
    comp.ctl \
    comp.cl1 \
    comp.cl2 \
    comp.cla \
    compms.inc

comp2.obj: comp2.asm \
    compeq.inc

OBJS = comp1.obj comppar.obj compp.obj compsm.obj comp2.obj

comp.com: $(OBJS) COMP.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=comp.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name comp.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q comp.exe comp.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f comp.com
	rm -f comp.exe
	rm -f comp.cl[12a]
	rm -f comp.ctl
	rm -f comp.map
	rm -f resp.txt
