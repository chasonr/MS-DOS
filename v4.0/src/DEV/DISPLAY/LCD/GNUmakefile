#************************ Makefile for Display/LCD ************************

inc	=../../../INC
msg	=../../../MESSAGE
dos	=../../../DOS
hinc	=../../../H

#
######################### Dependencies Begin Here #########################
#

all: lcd.cpi

865-cpi.obj:  865-CPI.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\lcd $(subst /,\,$<) $(subst /,\,$@)"

860-cpi.obj:  860-CPI.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\lcd $(subst /,\,$<) $(subst /,\,$@)"

437-cpi.obj:  437-CPI.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\lcd $(subst /,\,$<) $(subst /,\,$@)"

863-cpi.obj:  863-CPI.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\lcd $(subst /,\,$<) $(subst /,\,$@)"

850-cpi.obj:  850-CPI.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\lcd $(subst /,\,$<) $(subst /,\,$@)"

copyrigh.obj: COPYRIGH.ASM $(inc)/copyrigh.inc
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\lcd $(subst /,\,$<) $(subst /,\,$@)"

font-r3.obj:  FONT-R3.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\lcd $(subst /,\,$<) $(subst /,\,$@)"

OBJS = font-r3.obj 437-cpi.obj 850-cpi.obj 860-cpi.obj 863-cpi.obj \
       865-cpi.obj copyrigh.obj

lcd.cpi:  $(OBJS) LCD.LNK
	dosemu -t --Fdrive_c ../../../.. -E "src\dolink src\dev\display\lcd @lcd.lnk"
	exe2bin -q font-r3.exe lcd.cpi
	rm font-r3.exe

clean:
	rm -f *.obj
	rm -f lcd.cpi
