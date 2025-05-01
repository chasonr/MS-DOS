#********************** Makefile for Printer/4201.CPI **********************

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

all: 4201.cpi

4201.obj:  4201.asm  $(inc)/copyrigh.inc

OBJS = 4201.obj

4201.cpi:  $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=4201.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name 4201.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q 4201 4201.cpi

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f 4201.cpi
	rm -f 4201.map
	rm -f 4201.exe
	rm -f resp.txt
