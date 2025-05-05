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

smartdrv.sys: $(OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=smartdrv.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name smartdrv.sys' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f smartdrv.sys
	rm -f smartdrv.map
	rm -f resp.txt
