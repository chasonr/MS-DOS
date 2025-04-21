#************************* Makefile for Printer ***************************

inc	=../../INC
msg	=../../MESSAGES
dos	=../../DOS
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
######################## Dependencies Begin Here ##########################
#

all: printer.sys 4201.cpi 4208.cpi 5202.cpi

printer.ctl printer.cl1 printer.cl2 printer.cla: PRINTER.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\dev\printer $(subst /,\,$<) $(country)"

cpspm10.obj:	CPSPM10.ASM CPSPEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\printer $(subst /,\,$<) $(subst /,\,$@)"

cpsfont3.obj:	CPSFONT3.ASM CPSPEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\printer $(subst /,\,$<) $(subst /,\,$@)"

prtint2f.obj:	PRTINT2F.ASM CPSPEQU.INC $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\printer $(subst /,\,$<) $(subst /,\,$@)"

cpspi07.obj:	CPSPI07.ASM CPSPEQU.INC \
		$(inc)/SYSMSG.INC printer.ctl \
		$(inc)/versiona.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\printer $(subst /,\,$<) $(subst /,\,$@)"

parser.obj:	PARSER.ASM CPSPEQU.INC $(inc)/parse.asm \
		$(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\printer $(subst /,\,$<) $(subst /,\,$@)"

OBJS = cpspm10.obj cpsfont3.obj prtint2f.obj cpspi07.obj parser.obj

printer.sys: $(OBJS) PRINTER.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\printer @printer.lnk"
	exe2bin -q -l=0 printer.exe printer.sys
	rm printer.exe

4201.cpi:
	$(MAKE) -C 4201

4208.cpi:
	$(MAKE) -C 4208

5202.cpi:
	$(MAKE) -C 5202

clean:
	rm -f *.obj
	rm -f printer.sys
	rm -f printer.cl[12a]
	rm -f printer.ctl
	rm -f printer.map
	rm -f resp.txt
	$(MAKE) -C 4201 clean
	$(MAKE) -C 4208 clean
	$(MAKE) -C 5202 clean
