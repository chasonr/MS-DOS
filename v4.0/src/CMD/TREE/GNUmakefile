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

all: tree.com

tree.ctl tree.cl1 tree.cl2 tree.cla: tree.skl \
    $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg tree.skl

tree.obj: tree.asm \
    treequ.inc \
    $(inc)/pathmac.inc

treesysp.obj: treesysp.asm \
    $(inc)/pathmac.inc \
    $(inc)/psdata.inc \
    $(inc)/parse.asm

treesysm.obj: treesysm.asm \
    $(inc)/copyrigh.inc \
    $(inc)/versiona.inc \
    $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm \
    tree.ctl \
    tree.cl1 \
    tree.cl2 \
    tree.cla \
    $(inc)/msghan.inc \
    $(inc)/msgdcl.inc \
    $(inc)/pathmac.inc \
    treems.inc

treepar.obj: treepar.asm $(inc)/pathmac.inc

OBJS = tree.obj treepar.obj treesysp.obj treesysm.obj

tree.com: $(OBJS) TREE.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=tree.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name tree.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q tree.exe tree.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f tree.com
	rm -f tree.exe
	rm -f tree.map
	rm -f tree.cl[12a]
	rm -f tree.ctl
	rm -f resp.txt
