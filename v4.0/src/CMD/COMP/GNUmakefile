#************************* makefile for cmd/comp *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: comp.com

comp.ctl comp.ct1 comp.ct2 comp.cta: COMP.SKL \
    $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\comp $(subst /,\,$<) $(country)"

comp1.obj: COMP1.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\comp $(subst /,\,$<) $(subst /,\,$@)"

comppar.obj: COMPPAR.ASM \
    COMPEQ.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\comp $(subst /,\,$<) $(subst /,\,$@)"

compp.obj: COMPP.ASM \
    $(inc)/PARSE.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\comp $(subst /,\,$<) $(subst /,\,$@)"

compsm.obj: COMPSM.ASM \
    $(inc)/COPYRIGH.INC \
    $(inc)/VERSIONA.INC \
    $(inc)/SYSMSG.INC \
    $(inc)/MSGHAN.INC \
    comp.ctl \
    comp.cl1 \
    comp.cl2 \
    comp.cla \
    COMPMS.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\comp $(subst /,\,$<) $(subst /,\,$@)"

comp2.obj: COMP2.ASM \
    COMPEQ.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\comp $(subst /,\,$<) $(subst /,\,$@)"

OBJS = comp1.obj comppar.obj compp.obj compsm.obj comp2.obj

comp.com: $(OBJS) COMP.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\comp @comp.lnk"
	exe2bin -q comp.exe comp.com
	rm comp.exe

clean:
	rm -f *.obj
	rm -f comp.com
	rm -f comp.cl[12a]
	rm -f comp.ctl
	rm -f comp.map
	rm -f resp.txt
