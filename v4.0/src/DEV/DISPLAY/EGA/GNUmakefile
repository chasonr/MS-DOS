#*********************** Makefile for Display/EGA ************************

inc	=../../../INC
dos	=../../../DOS
msg	=../../../MESSAGES
hinc	=../../../H

#
######################## Dependencies begin here #########################
#

all: ega.cpi

cpi-head.obj: CPI-HEAD.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\ega $(subst /,\,$<) $(subst /,\,$@)"

437-cpi.obj: 437-CPI.ASM \
             437-8X16.ASM \
             437-8X14.ASM \
             437-8X8.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\ega $(subst /,\,$<) $(subst /,\,$@)"

850-cpi.obj: 850-CPI.ASM \
             850-8X16.ASM \
             850-8X14.ASM \
             850-8X8.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\ega $(subst /,\,$<) $(subst /,\,$@)"

860-cpi.obj: 860-CPI.ASM \
             860-8X16.ASM \
             860-8X14.ASM \
             860-8X8.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\ega $(subst /,\,$<) $(subst /,\,$@)"

863-cpi.obj: 863-CPI.ASM \
             863-8X16.ASM \
             863-8X14.ASM \
             863-8X8.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\ega $(subst /,\,$<) $(subst /,\,$@)"

865-cpi.obj: 865-CPI.ASM \
             865-8X16.ASM \
             865-8X14.ASM \
             865-8X8.ASM
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\ega $(subst /,\,$<) $(subst /,\,$@)"

copyrigh.obj: COPYRIGH.ASM  $(inc)/copyrigh.inc
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\display\ega $(subst /,\,$<) $(subst /,\,$@)"

OBJS = cpi-head.obj 437-cpi.obj 850-cpi.obj 860-cpi.obj 863-cpi.obj \
       865-cpi.obj copyrigh.obj

ega.cpi: $(OBJS) EGA.LNK
	dosemu -t --Fdrive_c ../../../.. -E "src\dolink src\dev\display\ega @ega.lnk"
	exe2bin -q cpi-head.exe ega.cpi
	rm cpi-head.exe

clean:
	rm -f *.obj
	rm -f ega.cpi
