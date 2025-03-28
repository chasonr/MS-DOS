#******************** makefile for boot *****************************

msg	=../messages
inc	=../inc
tools = ../tools

COUNTRY = usa-ms

AS = jwasm
ASFLAGS = -q -Zm -Zg -I$(inc) -Fl

#
#################### dependencies begin here ############################
#

.SUFFIXES: .asm .obj

.asm.obj:
	$(AS) $(ASFLAGS) -Fo$@ $<

all: $(inc)/boot.inc

$(inc)/boot.inc: msboot.bin
	$(tools)/hexify.rb msboot.bin $(inc)/boot.inc 7c00 200

boot.cl1: boot.cl1.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

msboot.obj: msboot.asm boot.cl1

OBJS = msboot.obj

msboot.bin: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=msboot.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msboot.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin msboot.exe msboot.bin

clean:
	rm -f *.obj *.err *.lst
	rm -f msboot.exe
	rm -f boot.cl1
	rm -f msboot.bin
	rm -f $(inc)/boot.inc
	rm -f resp.txt
