#**     makefile for Ramdrive

DEST	= ramdrive
MSG	= messages
inc = ../../inc

#       Definitions for assembler

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

# Dependencies follow

all: ramdrive.sys

ramdrive.obj: ramdrive.asm above.inc loadall.inc emm.inc mi.inc \
	 dirent.inc syscall.inc devsym.inc ab_macro.inc

messages.obj:  messages.asm

OBJS = ramdrive.obj messages.obj

ramdrive.sys: $(OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=ramdrive.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name ramdrive.sys' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f ramdrive.sys
	rm -f ramdrive.map
	rm -f resp.txt
