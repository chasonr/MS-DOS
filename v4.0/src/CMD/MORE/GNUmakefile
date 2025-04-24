#************************ makefile for cmd/more *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: more.com

more.ctl more.cl1 more.cl2 more.cla:       MORE.SKL \
                $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\more $(subst /,\,$<) $(country)"

more.obj: more.asm             \
          more.inc             \
          more.ctl             \
          more.cla             \
          more.cl1             \
          more.cl2             \
          $(inc)/syscall.inc   \
          $(inc)/msgserv.asm   \
          $(inc)/sysmsg.inc    \
          $(inc)/versiona.inc  \
          $(inc)/copyrigh.inc

OBJS = more.obj

more.com: $(OBJS) MORE.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\more @more.lnk"
	echo 'system dos' >resp.txt
	echo 'option map=more.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name more.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q more.exe more.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f more.com
	rm -f more.exe
	rm -f more.map
	rm -f more.cl[12a]
	rm -f more.ctl
	rm -f resp.txt
