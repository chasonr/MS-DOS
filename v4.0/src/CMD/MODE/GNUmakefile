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

all: mode.com

mode.ctl mode.cl1 mode.cl2 mode.cla mode.clb: MODE.SKL \
      $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\mode $(subst /,\,$<) $(country)"


main.obj: MAIN.ASM \
  $(inc)/copyrigh.inc \
  $(inc)/versiona.inc \
  $(inc)/STRUC.INC \
  $(inc)/SYSMSG.INC \
  $(inc)/MSGSERV.ASM \
  mode.ctl \
  mode.cl1 \
  mode.cl2 \
  mode.cla \
  mode.clb
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

scrntab.obj: SCRNTAB.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modescrn.obj: MODESCRN.ASM \
  $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

rescode.obj: RESCODE.ASM \
  $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modecom.obj: MODECOM.ASM \
  $(inc)/STRUC.INC \
	     MODEQUAT.INC \
	     COMMON.STC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modeprin.obj: MODEPRIN.ASM \
  $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modevid.obj: MODEVID.ASM \
  $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modeecho.obj: MODEECHO.ASM \
   COMMON.STC \
  $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modeleng.obj: MODELENG.ASM \
	      MODEQUAT.INC \
  $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modemes.obj: MODEMES.ASM \
  $(inc)/MSGSERV.ASM \
	     MODESUBS.INC \
	     MODEDEFS.INC \
	     MODEQUAT.INC \
	     COMMON.STC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

display.obj: DISPLAY.ASM \
	     COMMON.STC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

typamat.obj: TYPAMAT.ASM \
  $(inc)/STRUC.INC \
	     MODEQUAT.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

invoke.obj: INVOKE.ASM \
  $(inc)/STRUC.INC \
	    MODEQUAT.INC \
	    COMMON.STC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

modepars.obj: MODEPARS.ASM \
  $(inc)/STRUC.INC \
  $(inc)/psdata.inc \
	      MODEQUAT.INC \
	      COMMON.STC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"


parshell.obj: PARSHELL.ASM \
  $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"


modecp.obj: MODECP.ASM \
   MODECPRO.INC \
   MODECPEQ.INC \
   MODECPMS.INC \
  $(inc)/STRUC.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\mode $(subst /,\,$<) $(subst /,\,$@)"

OBJS = rescode.obj modeecho.obj modeleng.obj modemes.obj modescrn.obj \
       main.obj modevid.obj modeprin.obj modecom.obj scrntab.obj modecp.obj \
       display.obj typamat.obj invoke.obj parshell.obj modepars.obj

mode.com: $(OBJS) MODE.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\mode @mode.lnk"
	exe2bin -q mode.exe mode.com
	rm mode.exe

clean:
	rm -f *.obj
	rm -f mode.com
	rm -f mode.cl[12ab]
	rm -f mode.ctl
	rm -f mode.map
	rm -f resp.txt
