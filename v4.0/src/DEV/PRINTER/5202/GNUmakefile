#********************** Makefile for Printer/5202.CPI **********************

inc	=../../../INC
dos	=../../../DOS
hinc	=../../../H
msg	=../../../MESSAGE

#
######################### Dependencies Begin Here ##########################
#

all: 5202.cpi

5202.obj:  5202.ASM  $(inc)/copyrigh.inc
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\printer\5202 $(subst /,\,$<) $(subst /,\,$@)"

OBJS = 5202.obj

5202.cpi:  $(OBJS)
	dosemu -t --Fdrive_c ../../../.. -E "src\dolink src\dev\printer\5202 5202.obj,5202.exe,,,"
	exe2bin -q 5202 5202.cpi
	rm 5202.exe

clean:
	rm -f *.obj
	rm -f 5202.cpi
	rm -f 5202.map
