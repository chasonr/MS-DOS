#******************** makefile for boot *****************************

msg	=../MESSAGES
dos	=../DOS
inc	=../INC
hinc	=../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#################### dependencies begin here ############################
#

all: msboot.bin

boot.cl1: BOOT.SKL \
	$(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../.. -E "src\domsg1.bat src\boot $(subst /,\,$<) $(country);"

msboot.obj: MSBOOT.ASM boot.cl1
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\boot $(subst /,\,$<) $(subst /,\,$@);"

OBJS = msboot.obj

msboot.bin: msboot.obj
	echo 'system dos' >resp.txt
	echo 'option map=msboot.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name msboot.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q msboot.exe msboot.bin
	dosemu -t --Fdrive_c ../.. -E "src\tools\dbof src\boot\msboot.bin src\boot\boot.inc 7c00 200"
	mv boot.inc $(inc)

clean:
	rm -f *.obj
	rm -f msboot.exe
	rm -f msboot.map
	rm -f boot.cl1
	rm -f msboot.bin
	rm -f $(inc)/boot.inc
	rm -f resp.txt
