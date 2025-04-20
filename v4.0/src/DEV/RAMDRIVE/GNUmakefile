#**     makefile for Ramdrive

DEST	= ramdrive
MSG	= messages

#       Definitions for assembler

ASM	= masm
AFLAGS	= -Mx -t
AINC	= -I../../INC

#       Definitions for C compiler

CC	= cl
CFLAGS	= -Ox -X -Zlp
CINC	= -I../../H

#	Definitions for linker

LINK	= link

# Dependencies follow

all: ramdrive.sys

ramdrive.obj: RAMDRIVE.ASM ABOVE.INC LOADALL.INC EMM.INC MI.INC \
	 DIRENT.INC SYSCALL.INC DEVSYM.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\ramdrive $(subst /,\,$<) $(subst /,\,$@)"

messages.obj:  MESSAGES.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\ramdrive $(subst /,\,$<) $(subst /,\,$@)"

ramdrive.sys: ramdrive.obj messages.obj
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\ramdrive @ramdrive.lnk"
	exe2bin -q ramdrive.exe ramdrive.sys
	rm ramdrive.exe

clean:
	rm -f messages.obj
	rm -f ramdrive.obj
	rm -f ramdrive.sys
	rm -f ramdrive.map
	rm -f resp.txt
