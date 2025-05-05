#************************ Makefile for Country.sys ************************

dos	=../../DOS
lib	=../../LIB
inc	=../../INC

#
######################## Dependencies begin here ##########################
#
.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: country.sys

mkckntry.obj : mkcntry.asm mkcntry.inc $(inc)/copyrigh.inc

OBJS = mkcntry.obj

country.sys: $(OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=country.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name country.sys' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f country.sys
	rm -f country.map
	rm -f resp.txt
