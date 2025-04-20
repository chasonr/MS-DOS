# rules and dependencies follow
#
# use microsoft make to build
#
# set up build environment - include and library for c
#

all: smartdrv.sys

smartdrv.obj: SMARTDRV.ASM MI.ASM LOADALL.ASM \
    SYSCALL.ASM EMM.ASM ABOVE.ASM \
    DEVSYM.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\smartdrv $(subst /,\,$<) $(subst /,\,$@)"

OBJS = smartdrv.obj

smartdrv.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\smartdrv smartdrv.obj,smartdrv.exe,,,"

smartdrv.sys: smartdrv.exe
	exe2bin -q smartdrv.exe smartdrv.sys

clean:
	rm -f *.obj
	rm -f smartdrv.sys
	rm -f smartdrv.exe
	rm -f smartdrv.map
