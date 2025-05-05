#************************* Makefile for Display ***************************

inc	=../../INC
msg	=../../MESSAGES
dos	=../../DOS
hinc	=../../H

country = usa-ms

#
######################## Dependencies Begin Here ##########################

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: display.sys ega.cpi lcd.cpi

display.ctl display.cl1 display.cl2 display.cla: display.skl \
        $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg display.skl

display.obj: display.asm \
        macros.inc  \
        def-equ.inc \
        int2fcom.inc \
        int10com.inc \
        cps-func.inc \
        write.inc    \
        f-parser.inc

init.obj: init.asm \
          macros.inc \
          def-equ.inc \
          $(inc)/sysmsg.inc \
          $(inc)/msgserv.asm \
          $(inc)/copyrigh.inc \
          $(inc)/versiona.inc \
          $(inc)/msgdcl.inc \
          display.ctl display.cl1 display.cl2 display.cla \
          tables.inc

parser.obj: parser.asm \
        def-equ.inc  \
        $(inc)/parse.asm \
        $(inc)/psdata.inc

OBJS = display.obj init.obj parser.obj

display.sys: $(OBJS) DISPLAY.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=display.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name display.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q -l=0 display.exe display.sys

ega.cpi:
	$(MAKE) -C EGA

lcd.cpi:
	$(MAKE) -C LCD

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f display.sys
	rm -f display.exe
	rm -f display.map
	rm -f display.cl[12a]
	rm -f display.ctl
	rm -f resp.txt
	$(MAKE) -C EGA clean
	$(MAKE) -C LCD clean
