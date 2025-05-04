#************************* Makefile for Printer ***************************

inc	=../../INC
msg	=../../MESSAGES
dos	=../../DOS
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
######################## Dependencies Begin Here ##########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: printer.sys 4201.cpi 4208.cpi 5202.cpi

printer.ctl printer.cl1 printer.cl2 printer.cla: printer.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG printer.skl

cpspm10.obj:	cpspm10.asm cpspequ.inc

cpsfont3.obj:	cpsfont3.asm cpspequ.inc

prtint2f.obj:	prtint2f.asm cpspequ.inc

cpspi07.obj:	cpspi07.asm cpspequ.inc $(inc)/sysmsg.inc $(inc)/msgserv.asm \
                $(inc)/copyrigh.inc $(inc)/versiona.inc $(inc)/msgdcl.inc \
                printer.ctl printer.cl1 printer.cl2 printer.cla

parser.obj:	parser.asm cpspequ.inc $(inc)/parse.asm $(inc)/psdata.inc

OBJS = cpspm10.obj cpsfont3.obj prtint2f.obj cpspi07.obj parser.obj

printer.sys: $(OBJS) PRINTER.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=printer.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name printer.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q -l=0 printer.exe printer.sys

4201.cpi:
	$(MAKE) -C 4201

4208.cpi:
	$(MAKE) -C 4208

5202.cpi:
	$(MAKE) -C 5202

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f printer.sys
	rm -f printer.exe
	rm -f printer.cl[12a]
	rm -f printer.ctl
	rm -f printer.map
	rm -f resp.txt
	$(MAKE) -C 4201 clean
	$(MAKE) -C 4208 clean
	$(MAKE) -C 5202 clean
