# rules and dependencies follow
#
# use microsoft make to build
#
# set up build environment - include and library for c
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: smartdrv.sys

smartdrv.obj: smartdrv.asm ab_macro.asm mi.asm loadall.asm \
    syscall.asm emm.asm above.asm \
    devsym.asm

OBJS = smartdrv.obj

smartdrv.exe: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=smartdrv.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name smartdrv.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

smartdrv.sys: smartdrv.exe
	exe2bin -q smartdrv.exe smartdrv.sys

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f smartdrv.sys
	rm -f smartdrv.exe
	rm -f smartdrv.map
	rm -f resp.txt
