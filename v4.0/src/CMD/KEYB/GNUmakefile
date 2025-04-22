#************************* Makefile for KEYB *************************

inc	=../../INC
msg	=../../MESSAGES
dos	=../../DOS
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
###################### Dependencies begin here. ######################
#

all: keyb.com

keyb.ctl keyb.cl1 keyb.cl2 keyb.cla: KEYB.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\keyb $(subst /,\,$<) $(country)"

keybcmd.obj: KEYBCMD.ASM \
             $(inc)/STRUC.INC \
             $(inc)/sysmsg.inc \
             $(inc)/versiona.inc \
             KEYBEQU.INC  \
             KEYBSYS.INC  \
             KEYBI9.INC   \
             KEYBI9C.INC  \
             KEYBI2F.INC  \
             KEYBI48.INC  \
             KEYBSHAR.INC \
             keyb.ctl     \
             keyb.cl1     \
             keyb.cl2     \
             keyb.cla     \
             KEYBDCL.INC  \
             KEYBTBBL.INC \
             COMMSUBS.INC \
             KEYBCPSD.INC \
             $(inc)/POSTEQU.INC  \
             $(inc)/DSEG.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

keybtbbl.obj: KEYBTBBL.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

commsubs.obj: COMMSUBS.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

keybi2f.obj: KEYBI2F.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

keybi48.obj: KEYBI48.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

keyb.obj: KEYB.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

keybcpsd.obj: KEYBCPSD.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

keybi9.obj: KEYBI9.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

keybi9c.obj: KEYBI9C.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

parser.obj:  PARSER.ASM \
             $(inc)/parse.asm \
             $(inc)/STRUC.INC \
             KEYBDCL.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\keyb $(subst /,\,$<) $(subst /,\,$@)"

OBJS = keyb.obj keybi9.obj keybi9c.obj keybi2f.obj keybi48.obj keybcpsd.obj \
       commsubs.obj keybtbbl.obj parser.obj keybcmd.obj

keyb.com: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\keyb @keyb.lnk"
	exe2bin -q keyb.exe keyb.com
	rm keyb.exe

clean:
	rm -f *.obj
	rm -f keyb.com
	rm -f keyb.cl[12a]
	rm -f keyb.ctl
	rm -f resp.txt
