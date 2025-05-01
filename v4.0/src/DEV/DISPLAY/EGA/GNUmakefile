#*********************** Makefile for Display/EGA ************************

inc	=../../../INC
dos	=../../../DOS
msg	=../../../MESSAGES
hinc	=../../../H

#
######################## Dependencies begin here #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: ega.cpi

cpi-head.obj: cpi-head.asm

437-cpi.obj: 437-cpi.asm \
             437-8x16.asm \
             437-8x14.asm \
             437-8x8.asm

850-cpi.obj: 850-cpi.asm \
             850-8x16.asm \
             850-8x14.asm \
             850-8x8.asm

860-cpi.obj: 860-cpi.asm \
             860-8x16.asm \
             860-8x14.asm \
             860-8x8.asm

863-cpi.obj: 863-cpi.asm \
             863-8x16.asm \
             863-8x14.asm \
             863-8x8.asm

865-cpi.obj: 865-cpi.asm \
             865-8x16.asm \
             865-8x14.asm \
             865-8x8.asm

copyrigh.obj: copyrigh.asm  $(inc)/copyrigh.inc

OBJS = cpi-head.obj 437-cpi.obj 850-cpi.obj 860-cpi.obj 863-cpi.obj \
       865-cpi.obj copyrigh.obj

ega.cpi: $(OBJS) EGA.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=cpi-head.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name cpi-head.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q cpi-head.exe ega.cpi

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f ega.cpi
	rm -f cpi-head.exe
	rm -f cpi-head.map
	rm -f resp.txt
