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

all: graphics.com


graphics.ctl graphics.cl1 graphics.cl2 graphics.cla graphics.clb graphics.clc: \
        GRAPHICS.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\graphics $(subst /,\,$<) $(country)"

graphics.obj: GRAPHICS.ASM  GRINST.EXT
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grinst.obj: GRINST.ASM	GRLOAD.EXT GRLOAD2.EXT GRCTRL.EXT GRPRINT.EXT \
	    GRCPSD.EXT	GRPARMS.EXT  GRPARSE.EXT GRBWPRT.EXT GRCOLPRT.EXT \
	    GRINT2FH.EXT GRMSG.EQU  graphics.ctl graphics.cla graphics.cl1 \
	    graphics.clb \
	    graphics.cl2 graphics.clc \
	    $(inc)/SYSMSG.INC $(inc)/STRUC.INC GRSHAR.STR
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grcpsd.obj: GRCPSD.ASM GRCTRL.EXT GRCTRL.STR
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grparse.obj: GRPARSE.ASM $(inc)/STRUC.INC $(inc)/parse.asm $(inc)/psdata.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grpattrn.obj: GRPATTRN.ASM GRPATTRN.STR
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grbwprt.obj: GRBWPRT.ASM GRCOMMON.EXT GRCTRL.STR GRSHAR.STR \
	     GRPATTRN.STR $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grint2fh.obj: GRINT2FH.ASM  GRLOAD.EXT	GRCTRL.EXT GRPRINT.EXT \
	      GRCPSD.EXT
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grctrl.obj: GRCTRL.ASM GRINT2FH.EXT GRBWPRT.EXT GRCOLPRT.EXT GRSHAR.STR \
	    GRPATTRN.STR GRPATTRN.EXT GRCTRL.STR $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grcolprt.obj: GRCOLPRT.ASM GRCTRL.STR GRSHAR.STR GRPATTRN.STR GRCTRL.EXT  \
	      $(inc)/STRUC.INC GRCOMMON.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grload.obj: GRLOAD.ASM $(inc)/STRUC.INC GRINST.EXT GRSHAR.STR GRPARSE.EXT \
	    GRLOAD2.EXT GRLOAD3.EXT GRMSG.EQU
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grload2.obj: GRLOAD2.ASM $(inc)/STRUC.INC GRINST.EXT GRSHAR.STR GRMSG.EQU \
	     GRINST.EXT GRLOAD.EXT GRPARSE.EXT GRPATTRN.STR GRPATTRN.EXT
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grload3.obj: GRLOAD3.ASM $(inc)/STRUC.INC GRINST.EXT GRSHAR.STR GRMSG.EQU \
	     GRINST.EXT GRLOAD.EXT GRLOAD2.EXT GRPARSE.EXT GRPATTRN.STR \
	     GRPATTRN.EXT
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

grparms.obj: GRPARMS.ASM GRMSG.EQU GRSHAR.STR GRINST.EXT GRPARSE.EXT \
	     $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\graphics $(subst /,\,$<) $(subst /,\,$@)"

##############################################################################
OBJS = graphics.obj grint2fh.obj grpattrn.obj grctrl.obj grcpsd.obj \
       grcolprt.obj grbwprt.obj grinst.obj grparse.obj grparms.obj \
       grload.obj grload2.obj grload3.obj

graphics.com: $(OBJS) GRAPHICS.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\graphics /map @graphics.lnk"
	exe2bin -q graphics.exe graphics.com
	rm graphics.exe

clean:
	rm -f *.obj
	rm -f graphics.com
	rm -f graphics.map
	rm -f graphics.cl[12a-c]
	rm -f graphics.ctl
	rm -f resp.txt
