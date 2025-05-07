#**     makefile for fc

#DEST	=FC
#MSG	=MESSAGES

#	Path Definitions

BIOS	=../../BIOS
BOOT	=../../BOOT
dos	=../../DOS
inc	=../../INC
hinc	=../../H
H	=../../H

#	List of object files required

OBJ	= fc.obj \
	  error.obj \
	  fgetl.obj \
	  getl.obj \
	  itoupper.obj \
	  $(inc)/kstring.obj \
	  maxmin.obj \
	  move.obj \
	  ntoi.obj \
	  string.obj \
	  update.obj \
	  xtab.obj \
	  messages.obj

#       Rules and Dependencies follow

.SUFFIXES: .c .asm .obj

CC = wcl
CFLAGS = -q -ms -os -zp=1 -I. -I$(hinc) -wx

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all:	fc.exe

$(inc)/kstring.obj: $(inc)/kstring.c $(hinc)/internat.h

getl.obj: getl.asm $(inc)/cmacros.inc $(inc)/version.inc

itoupper.obj: itoupper.asm  $(inc)/cmacros.inc $(inc)/version.inc

maxmin.obj: maxmin.asm $(inc)/cmacros.inc $(inc)/version.inc

messages.obj: messages.asm

move.obj: move.asm $(inc)/cmacros.inc $(inc)/version.inc

string.obj: string.asm $(inc)/cmacros.inc $(inc)/version.inc

xtab.obj: xtab.asm $(inc)/cmacros.inc $(inc)/version.inc

error.obj: error.c tools.h ttypes.h

fc.obj: fc.c fc.h tools.h ttypes.h

fgetl.obj: fgetl.c tools.h ttypes.h

ntoi.obj: ntoi.c tools.h ttypes.h

update.obj: update.c tools.h ttypes.h

fc.exe: $(OBJ)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=fc.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name fc.exe' >>resp.txt
	for x in $(OBJ); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f fc.exe
	rm -f fc.map
	rm -f resp.txt
