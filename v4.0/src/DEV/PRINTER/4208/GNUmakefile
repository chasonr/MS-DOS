#********************** Makefile for Printer/4208.CPI **********************

inc	=../../../INC
dos	=../../../DOS
hinc	=../../../H
msg	=../../../MESSAGE

#
######################### Dependencies Begin Here ##########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: 4208.cpi

4208.obj:  4208.asm  $(inc)/copyrigh.inc

OBJS = 4208.obj

4208.cpi:  $(OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=4208.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name 4208.cpi' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f 4208.cpi
	rm -f 4208.map
	rm -f resp.txt
