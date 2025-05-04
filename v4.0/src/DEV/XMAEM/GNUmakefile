#************************ makefile for dev/xmaem************************

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

all: xmaem.sys

xmaem.cl1: xmaem.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG xmaem.skl

indeini.obj:   indeini.asm indedat.inc indeovp.mac indeins.mac

indeemu.obj:   indeemu.asm indedat.inc indeovp.mac indeins.mac

indeexc.obj:   indeexc.asm indedat.inc indeovp.mac

indexma.obj:   indexma.asm indedat.inc indeovp.mac indeins.mac

indedma.obj:   indedma.asm indedat.inc indeovp.mac indeins.mac

indeidt.obj:   indeidt.asm indedat.inc indeovp.mac

indegdt.obj:   indegdt.asm indedat.inc indeacc.inc indedes.mac

indei15.obj:   indei15.asm indedat.inc indeovp.mac

indemsg.obj:   indemsg.asm xmaem.cl1

indepat.obj:   indepat.asm

OBJS = indeini.obj indeexc.obj indeemu.obj indexma.obj indedma.obj \
       indei15.obj indeidt.obj indegdt.obj indemsg.obj indepat.obj

xmaem.sys:  $(OBJS) XMAEM.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=xmaem.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name xmaem.sys' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f xmaem.cl1
	rm -f xmaem.sys
	rm -f xmaem.map
	rm -f resp.txt
