#************************** makefile for cmd/... ***************************

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

all: sort.exe

sort.ctl sort.cl1 sort.cl2 sort.cla: SORT.SKL              \
        $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\sort $(subst /,\,$<) $(country)"

sort.obj: sort.asm              \
          sort.ctl              \
          sort.cla              \
          sort.cl1              \
          sort.cl2              \
          $(inc)/parse.asm      \
          $(inc)/msgdcl.inc     \
          $(inc)/psdata.inc     \
          $(inc)/syscall.inc    \
          $(inc)/msgserv.asm    \
          $(inc)/copyrigh.inc

sortmes.obj: sortmes.asm

OBJS = sort.obj sortmes.obj

sort.exe: $(OBJS)
#	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\sort sort+sortmes,sort.exe,,,"
	echo 'system dos' >resp.txt
	echo 'option stack=458' >>resp.txt
	echo 'option map=sort.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name sort.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	dosemu -t --Fdrive_c ../../.. -E "src\tools\exefix src\cmd\sort\sort.exe 1 1 "

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f sort.cl[12a]
	rm -f sort.ctl
	rm -f sort.exe
	rm -f sort.map
	rm -f resp.txt
