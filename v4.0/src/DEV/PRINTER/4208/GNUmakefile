#********************** Makefile for Printer/4208.CPI **********************

inc	=../../../INC
dos	=../../../DOS
hinc	=../../../H
msg	=../../../MESSAGE

#
######################### Dependencies Begin Here ##########################
#

all: 4208.cpi

4208.obj:  4208.ASM  $(inc)/COPYRIGH.INC
	dosemu -t --Fdrive_c ../../../.. -E "src\domasm.bat src\dev\printer\4208 $(subst /,\,$<) $(subst /,\,$@)"

OBJS = 4208.obj

4208.cpi:  $(OBJS)
	dosemu -t --Fdrive_c ../../../.. -E "src\dolink src\dev\printer\4208 4208.obj,4208.exe,,,"
	exe2bin -q 4208 4208.cpi
	rm 4208.exe

clean:
	rm -f *.obj
	rm -f 4208.cpi
	rm -f 4208.map
