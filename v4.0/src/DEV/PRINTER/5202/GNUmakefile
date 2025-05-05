#********************** Makefile for Printer/5202.CPI **********************

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

all: 5202.cpi

5202.obj:  5202.asm  $(inc)/copyrigh.inc

OBJS = 5202.obj

5202.cpi:  $(OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=5202.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name 5202.cpi' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f 5202.cpi
	rm -f 5202.map
	rm -f resp.txt
