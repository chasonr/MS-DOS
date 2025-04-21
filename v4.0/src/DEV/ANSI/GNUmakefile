#*********************** Makefile for ansi.sys ****************************

dos	=../../DOS
inc	=../../INC
msg	=../../MESSAGES

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
####################### Dependencies Begin Here ##########################
#

all: ansi.sys

ansi.ctl ansi.cl1 ansi.cl2 ansi.cla: ANSI.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\dev\ansi $(subst /,\,$<) $(country)"

ansi.obj:       ANSI.ASM ANSI.INC \
                $(inc)/vector.inc \
                $(inc)/MULT.INC \
                $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\ansi $(subst /,\,$<) $(subst /,\,$@)"

ioctl.obj:      IOCTL.ASM ANSI.INC \
                $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\ansi $(subst /,\,$<) $(subst /,\,$@)"

ansiinit.obj:   ANSIINIT.ASM ANSI.INC ANSIVID.INC \
                $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\ansi $(subst /,\,$<) $(subst /,\,$@)"

parser.obj:     PARSER.ASM ANSI.INC $(inc)/SYSMSG.INC $(inc)/parse.asm \
                $(inc)/STRUC.INC ansi.ctl $(inc)/versiona.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\ansi $(subst /,\,$<) $(subst /,\,$@)"

OBJS = ansi.obj ioctl.obj ansiinit.obj parser.obj

ansi.sys: $(OBJS) ANSI.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\ansi @ansi.lnk"
	exe2bin -q ansi.exe ansi.sys
	rm      ansi.exe

clean:
	rm -f *.obj
	rm -f ansi.sys
	rm -f ansi.cl[12a]
	rm -f ansi.ctl
	rm -f ansi.map
	rm -f resp.txt
