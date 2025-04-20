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

all: more.com

more.ctl more.cl1 more.cl2 more.cla:       MORE.SKL \
                $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\more $(subst /,\,$<) $(country)"

more.obj: MORE.ASM             \
          MORE.INC             \
          more.ctl             \
          more.cla             \
          more.cl1             \
          more.cl2             \
          $(inc)/SYSCALL.INC   \
          $(inc)/STRUC.INC     \
          $(inc)/MSGSERV.ASM   \
          $(inc)/SYSMSG.INC    \
          $(inc)/VERSIONA.INC  \
          $(inc)/COPYRIGH.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\more $(subst /,\,$<) $(subst /,\,$@)"

OBJS = more.obj

more.com: $(OBJS) MORE.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\more @more.lnk"
	exe2bin -q more.exe more.com
	rm more.exe

clean:
	rm -f *.obj
	rm -f more.com
	rm -f more.cl[12a]
	rm -f more.ctl
	rm -f resp.txt
