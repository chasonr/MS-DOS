#********************** Makefile for Printer/4201.CPI **********************

inc	=../../../INC
dos	=../../../DOS
hinc	=../../../H
msg	=../../../MESSAGE

#
######################### Dependencies Begin Here ##########################
#

all: 4201.cpi

4201.obj:  4201.ASM  $(inc)/COPYRIGH.INC
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\printer\4201 $(subst /,\,$<) $(subst /,\,$@)"

OBJS = 4201.obj

4201.cpi:  $(OBJS)
	dosemu -t --Fdrive_c ../../../.. -E "src\dolink src\dev\printer\4201 4201.obj,4201.exe,,,"
	exe2bin -q 4201 4201.cpi
	rm 4201.exe

clean:
	rm -f *.obj
	rm -f 4201.cpi
	rm -f 4201.map
