#************************ Makefile for Display/LCD ************************

inc	=../../../INC
msg	=../../../MESSAGE
dos	=../../../DOS
hinc	=../../../H

#
######################### Dependencies Begin Here #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: lcd.cpi

865-cpi.obj:  865-cpi.asm

860-cpi.obj:  860-cpi.asm

437-cpi.obj:  437-cpi.asm

863-cpi.obj:  863-cpi.asm

850-cpi.obj:  850-cpi.asm

copyrigh.obj: copyrigh.asm $(inc)/copyrigh.inc

font-r3.obj:  font-r3.asm

OBJS = font-r3.obj 437-cpi.obj 850-cpi.obj 860-cpi.obj 863-cpi.obj \
       865-cpi.obj copyrigh.obj

lcd.cpi:  $(OBJS) LCD.LNK
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=lcd.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name lcd.cpi' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f lcd.cpi
	rm -f lcd.map
	rm -f resp.txt
