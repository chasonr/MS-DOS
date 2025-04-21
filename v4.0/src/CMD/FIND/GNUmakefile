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

all: find.exe

find.ctl find.cl1 find.cl2 find.cla: FIND.SKL              \
          $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\find $(subst /,\,$<) $(country)"

find.obj: FIND.ASM              \
          find.ctl              \
          find.cla              \
          find.cl1              \
          find.cl2              \
          FIND.INC              \
          $(inc)/parse.asm      \
          $(inc)/psdata.inc     \
          $(inc)/syscall.inc    \
          $(inc)/MSGSERV.ASM    \
          $(inc)/SYSMSG.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\find $(subst /,\,$<) $(subst /,\,$@)"

findmes.obj: FINDMES.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\find $(subst /,\,$<) $(subst /,\,$@)"

OBJS = find.obj findmes.obj

find.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\find find+findmes,find.exe,,/ex"
#	echo 'system dos' >resp.txt
#	echo 'option map=find.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name find.exe' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f find.cl[12a]
	rm -f find.ctl
	rm -f find.exe
	rm -f find.map
	rm -f resp.txt
