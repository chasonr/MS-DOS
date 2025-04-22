#************************* Makefile for Display ***************************

inc	=../../INC
msg	=../../MESSAGES
dos	=../../DOS
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
######################## Dependencies Begin Here ##########################

all: display.sys ega.cpi lcd.cpi

display.ctl display.cl1 display.cl2 display.cla: DISPLAY.SKL \
        $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\dev\display $(subst /,\,$<) $(country)"

display.obj: DISPLAY.ASM \
        MACROS.INC  \
        DEF-EQU.INC \
        INT2FCOM.INC \
        INT10COM.INC \
        CPS-FUNC.INC \
        WRITE.INC    \
        F-PARSER.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\display $(subst /,\,$<) $(subst /,\,$@)"

init.obj: INIT.ASM \
          MACROS.INC \
          DEF-EQU.INC \
          $(inc)/sysmsg.inc \
          $(inc)/versiona.inc \
          display.ctl \
          TABLES.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\display $(subst /,\,$<) $(subst /,\,$@)"

parser.obj: PARSER.ASM \
        DEF-EQU.INC  \
        $(inc)/STRUC.INC \
        $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\display $(subst /,\,$<) $(subst /,\,$@)"

OBJS = display.obj init.obj parser.obj

display.sys: $(OBJS) DISPLAY.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\display @display.lnk"
	exe2bin -q -l=0 display.exe display.sys
	rm display.exe

ega.cpi:
	$(MAKE) -C EGA

lcd.cpi:
	$(MAKE) -C LCD

clean:
	rm -f *.obj
	rm -f display.sys
	rm -f display.cl[12a]
	rm -f display.ctl
	rm -f resp.txt
	$(MAKE) -C EGA clean
	$(MAKE) -C LCD clean
