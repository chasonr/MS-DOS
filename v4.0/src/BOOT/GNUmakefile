#******************** makefile for boot *****************************

msg	=../MESSAGES
dos	=../DOS
inc	=../INC
hinc	=../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#################### dependencies begin here ############################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: $(inc)/boot.inc

boot.cl1: boot.skl \
	$(msg)/$(COUNTRY).MSG
	../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG boot.skl

msboot.obj: msboot.asm boot.cl1

OBJS = msboot.obj

msboot.bin: msboot.obj
	echo 'system dos com' >resp.txt
	echo 'option map=msboot.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msboot.bin' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

$(inc)/boot.inc: msboot.bin
	../bldtools/hexify.rb msboot.bin $(inc)/boot.inc 7c00 200

clean:
	rm -f *.obj
	rm -f *.lst
	rm -f msboot.map
	rm -f boot.cl1
	rm -f msboot.bin
	rm -f $(inc)/boot.inc
	rm -f resp.txt
