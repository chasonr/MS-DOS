#************************** makefile for cmd/append ***************************

msg	=../../messages
inc	=../../inc

COUNTRY = usa-ms

AS = jwasm
ASFLAGS = -q -Zm -Zg -I$(inc) -I$(boot) -Fl

.SUFFIXES: .asm .obj

.asm.obj:
	$(AS) $(ASFLAGS) -Fo$@ $<

#
#######################	dependencies begin here. #########################
#

all: append.exe

append.cl1: append.cl1.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

append.cl2: append.cl2.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

append.cla: append.cla.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

append.clb: append.clb.base $(msg)/$(COUNTRY).cat
	$(msg)/substmsg.rb $< $@ $(msg)/$(COUNTRY).cat

append.obj: append.asm appendp.inc $(inc)/parse.asm append.ctl \
            append.cl1 append.cl2 append.cla append.clb

OBJS = append.obj

append.exe: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=append.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name append.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj *.lst *.err
	rm -f append.exe append.map
	rm -f append.cl?
	rm -f resp.txt
