#************************ Makefile for Country.sys ************************

dos	=../../DOS
lib	=../../LIB
inc	=../../INC

#
######################## Dependencies begin here ##########################
#

all: country.sys

mkcntry.obj: MKCNTRY.ASM MKCNTRY.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\country $(subst /,\,$<) $(subst /,\,$@)"

OBJS = mkcntry.obj

mkcntry.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\country mkcntry.obj,mkcntry.exe,,,"

country.sys: mkcntry.exe
	dosemu -t --Fdrive_c ../../.. -E "src\dev\country\mkcntry"
	mv ../../../country.sys .

clean:
	rm -f *.obj
	rm -f country.sys
	rm -f mkcntry.exe
	rm -f mkcntry.map
	rm -f resp.txt
