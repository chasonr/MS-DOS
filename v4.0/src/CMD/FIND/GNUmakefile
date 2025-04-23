#************************** makefile for cmd\... ***************************

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

all: find.exe

find.ctl find.cl1 find.cl2 find.cla: FIND.SKL              \
          $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\find $(subst /,\,$<) $(country)"

find.obj: find.asm              \
          find.ctl              \
          find.cla              \
          find.cl1              \
          find.cl2              \
          find.inc              \
          $(inc)/syscall.inc    \
          $(inc)/msgserv.asm    \
          $(inc)/sysmsg.inc     \
          $(inc)/versiona.inc

findmes.obj: findmes.asm

OBJS = find.obj findmes.obj

find.exe: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=find.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name find.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f find.cl[12a]
	rm -f find.ctl
	rm -f find.exe
	rm -f find.map
	rm -f resp.txt
