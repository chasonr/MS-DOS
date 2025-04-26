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

all: graftabl.com

graftabl.ctl graftabl.cl1 graftabl.cl2 graftabl.cla: GRAFTABL.SKL \
    $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\graftabl $(subst /,\,$<) $(country)"

grtab.obj: GRTAB.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabp.obj: GRTABP.ASM \
    $(inc)/psdata.inc \
    $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabsm.obj: GRTABSM.ASM \
    $(inc)/copyrigh.inc \
    $(inc)/versiona.inc \
    $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm \
    graftabl.ctl \
    graftabl.cl1 \
    graftabl.cl2 \
    graftabl.cla \
    $(inc)/msghan.inc \
    GRTABMS.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabpar.obj: GRTABPAR.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabhan.obj: GRTABHAN.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabus.obj: GRTABUS.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabno.obj: GRTABNO.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabpo.obj: GRTABPO.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabcf.obj: GRTABCF.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

grtabml.obj: GRTABML.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graftabl $(subst /,\,$<) $(subst /,\,$@)"

OBJS = grtabhan.obj grtabus.obj grtabml.obj grtabpo.obj grtabcf.obj \
       grtabno.obj grtabsm.obj grtabpar.obj grtabp.obj grtab.obj

graftabl.com: $(OBJS) GRAFTABL.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\graftabl @graftabl.lnk"
	exe2bin -q graftabl.exe graftabl.com
	rm graftabl.exe

clean:
	rm -f *.obj
	rm -f graftabl.com
	rm -f graftabl.cl[12a]
	rm -f graftabl.ctl
	rm -f resp.txt
