#************************** makefile for cmd/assign ***************************

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

all: assign.com

assign.ctl assign.cl1 assign.cl2 assign.cla: assign.skl \
	$(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg assign.skl

assgparm.obj: assgparm.asm \
	$(inc)/psdata.inc \
	$(inc)/parse.asm

assgmain.obj: assgmain.asm \
	$(inc)/dosmac.inc \
	$(inc)/sysvar.inc \
	$(inc)/mult.inc \
	$(inc)/pdb.inc \
	$(inc)/syscall.inc \
	$(inc)/msgserv.asm \
	$(inc)/sysmsg.inc \
	assgparm.inc \
	assgmsg.inc \
	assign.ctl \
	assign.cla \
	assign.cl1 \
	assign.cl2 \
	$(inc)/curdir.inc

OBJS = assgmain.obj assgparm.obj
assign.com: $(OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=assign.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name assign.com' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f assign.com
	rm -f assign.cl[12a]
	rm -f assign.ctl
	rm -f assign.map
	rm -f resp.txt
