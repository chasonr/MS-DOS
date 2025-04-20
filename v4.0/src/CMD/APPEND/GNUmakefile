#************************** makefile for cmd/append ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: append.exe

append.ctl append.cl1 append.cl2 append.cla append.clb: \
        APPEND.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\append $(subst /,\,$<) $(country)"

append.obj: APPEND.ASM APPENDP.INC $(inc)/PARSE.ASM append.ctl
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\append $(subst /,\,$<) $(subst /,\,$@)"

OBJS = append.obj

append.exe: append.obj
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\append append.obj,append.exe,,,"

clean:
	rm -f *.obj
	rm -f append.cl[12ab]
	rm -f append.ctl
	rm -f append.exe
	rm -f append.map
	rm -f resp.txt
