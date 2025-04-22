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

all: sort.exe

sort.ctl sort.cl1 sort.cl2 sort.cla: SORT.SKL              \
        $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\sort $(subst /,\,$<) $(country)"

sort.obj: SORT.ASM              \
          sort.ctl              \
          sort.cla              \
          sort.cl1              \
          sort.cl2              \
          $(inc)/parse.asm      \
          $(inc)/psdata.inc     \
          $(inc)/syscall.inc    \
          $(inc)/msgserv.asm    \
          $(inc)/sysmsg.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\sort $(subst /,\,$<) $(subst /,\,$@)"

sortmes.obj: SORTMES.ASM           \
          $(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\sort $(subst /,\,$<) $(subst /,\,$@)"

OBJS = sort.obj sortmes.obj

sort.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\sort sort+sortmes,sort.exe,,,"
	dosemu -t --Fdrive_c ../../.. -E "src\tools\exefix src\cmd\sort\sort.exe 1 1 "

clean:
	rm -f *.obj
	rm -f sort.cl[12a]
	rm -f sort.ctl
	rm -f sort.exe
	rm -f sort.map
	rm -f resp.txt
