#
###### Make file for SELECT.EXE, SELECT.DAT, SELECT.COM, SELECT.HLP #####
#

msg	=../MESSAGES
dos	=../DOS
inc	=../INC
hinc	=../H
shell	=../SHELL
cas	=../SHELL/CASSFAR

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: select.exe select.dat select.com select.hlp

#
############################ Make SELECT.EXE #############################
#

select.ctl select.cl1 select.cl2 select.cla select.clb: SELECT.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../.. -E "src\domsg2.bat src\select $(subst /,\,$<) $(country);"

select0.obj: SELECT0.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC  \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC     \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC  \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC    \
             select.ctl MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select1.obj: SELECT1.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC  \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC     \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC  \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC    \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select2.obj: SELECT2.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select2a.obj: SELECT2A.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select3.obj: SELECT3.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select4.obj: SELECT4.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select5.obj: SELECT5.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select5a.obj: SELECT5A.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select6.obj: SELECT6.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select7.obj: SELECT7.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select8.obj: SELECT8.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

select9.obj: SELECT9.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC   \
             PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC      \
             MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC   \
             MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC     \
             MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

gen_coms.obj: GEN_COMS.ASM $(inc)/STRUC.INC $(inc)/SYSMSG.INC CASEXTRN.INC \
              PANEL.MAC SELECT.INC PAN-LIST.INC CASTRUC.INC MACROS.INC     \
              MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC  \
              MACROS7.INC MAC_EQU.INC EXT.INC VARSTRUC.INC ROUT_EXT.INC    \
              MACROS8.INC PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

mparse.obj: MPARSE.ASM $(inc)/parse.asm DATA.MAC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

initmem.obj: INITMEM.ASM $(inc)/STRUC.INC MACROS.INC MACROS2.INC MACROS3.INC \
             MACROS4.INC MACROS5.INC MACROS6.INC MACROS7.INC MACROS8.INC \
	     MAC_EQU.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

input.obj:    INPUT.ASM PCEQUATE.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

routines.obj: ROUTINES.ASM $(inc)/STRUC.INC MAC_EQU.INC VARSTRUC.INC EXT.INC \
              MACROS.INC MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC     \
              MACROS6.INC MACROS7.INC MACROS8.INC PAN-LIST.INC PANEL.MAC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"


routine2.obj: ROUTINE2.ASM $(inc)/STRUC.INC MAC_EQU.INC EXT.INC VARSTRUC.INC \
              MACROS.INC MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC     \
              MACROS6.INC MACROS7.INC MACROS8.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

var.obj:  VAR.ASM $(inc)/SYSMSG.INC SEL_FILE.INC VARSTRUC.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

prn_def.obj: PRN_DEF.ASM $(inc)/STRUC.INC MACROS.INC MACROS2.INC MACROS3.INC \
             MACROS4.INC MACROS5.INC MACROS6.INC MACROS7.INC MACROS8.INC \
	     MAC_EQU.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

scn_parm.obj: SCN_PARM.ASM $(inc)/STRUC.INC EXT.INC MACROS.INC MACROS2.INC   \
              MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC MACROS7.INC    \
              MACROS8.INC MAC_EQU.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

s_disply.obj: S_DISPLY.ASM $(inc)/STRUC.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

mod_copy.obj: MOD_COPY.ASM $(inc)/STRUC.INC DOS.EQU XCOPY.EQU DOSFILES.INC  \
              MACROS.INC MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC    \
              MACROS6.INC MACROS7.INC PAN-LIST.INC MACROS8.INC MAC_EQU.INC \
	      XMAINMSG.EQU PANEL.MAC CASEXTRN.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

bridge.obj: BRIDGE.ASM $(inc)/CASVAR.INC $(inc)/CASRN.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

caservic.obj: CASERVIC.ASM $(inc)/CASVAR.INC $(inc)/CASRN.INC PAN-LIST.INC \
	      SELECT.INC CASTRUC.INC DATA.MAC PANEL.MAC MACROS.INC \
	      $(inc)/STRUC.INC PCEQUATE.INC MAC_EQU.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

ckdisp.obj: CKDISP.ASM $(inc)/STRUC.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

intvec.obj: INTVEC.ASM $(inc)/STRUC.INC MAC_EQU.INC PAN-LIST.INC \
            PANEL.MAC MACROS.INC VARSTRUC.INC EXT.INC CASEXTRN.INC \
            MACROS8.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

asm2c.obj : ASM2C.ASM 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

get_stat.obj : GET_STAT.C GET_STAT.H EXTERN.H 
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

int13.obj : INT13.C 
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

global.obj : GLOBAL.C 
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

../CMD/FDISK/bootrec.obj:
	$(MAKE) -C ../CMD/FDISK bootrec.obj

bootrec.obj : ../CMD/FDISK/bootrec.obj
	cp ../CMD/FDISK/bootrec.obj .

selquit.obj : SELQUIT.ASM PANEL.MAC PCEQUATE.INC PAN-LIST.INC CASTRUC.INC   \
              EXT.INC $(inc)/STRUC.INC MACROS.INC MACROS2.INC MACROS3.INC   \
              MACROS4.INC MACROS5.INC MACROS6.INC MACROS7.INC MACROS8.INC \
	      MAC_EQU.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

selchild.obj : SELCHILD.ASM PCEQUATE.INC CASTRUC.INC MACROS.INC MACROS2.INC  \
               MACROS3.INC MACROS4.INC MACROS5.INC MACROS6.INC MACROS7.INC   \
               MACROS8.INC MAC_EQU.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

services.obj : SERVICES.ASM PCEQUATE.INC CASTRUC.INC $(inc)/CASVAR.INC \
	       MACROS.INC MACROS2.INC MACROS3.INC MACROS4.INC MACROS5.INC \
	       MACROS6.INC MACROS7.INC MACROS8.INC MAC_EQU.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

get_help.obj : GET_HELP.ASM 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

selserv.obj : SELSERV.ASM 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

services.lib : selquit.obj selchild.obj services.obj get_help.obj selserv.obj
	rm -f services.lib
	wlib services.lib -+selquit.obj;
	wlib services.lib -+selchild.obj;
	wlib services.lib -+services.obj;
	wlib services.lib -+get_help.obj;
	wlib services.lib -+selserv.obj;

SELECT_OBJS = select0.obj select1.obj select2.obj select2a.obj select3.obj \
              select4.obj select5.obj select5a.obj select6.obj select7.obj \
              select8.obj select9.obj routine2.obj gen_coms.obj routines.obj \
              intvec.obj ckdisp.obj scn_parm.obj prn_def.obj var.obj \
              caservic.obj input.obj initmem.obj mparse.obj mod_copy.obj \
              s_disply.obj bridge.obj asm2c.obj get_stat.obj global.obj \
              int13.obj bootrec.obj

select.exe: $(SELECT_OBJS) services.lib
	dosemu -t --Fdrive_c ../.. -E "src\dolink src\select /noe @select.lnk"
# The "/noe" is so symbols defined in source files supercede library routines

#
#######################  make select.com #####################
#

sstub.obj: SSTUB.ASM $(inc)/SYSMSG.INC select.ctl 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

STUB_OBJS = sstub.obj

select.com: $(STUB_OBJS)
	dosemu -t --Fdrive_c ../.. -E "src\dolink src\select /noe sstub.obj,sstub.exe,,,"
	exe2bin -q sstub.exe select.com

#
#######################  make select.dat ####################
#


panel.inf: USA.INF 
	cp USA.INF panel.inf

panels.obj: PANELS.ASM SEL-PAN.INC PAN-LIST.INC panel.inf 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

colors.obj: COLORS.ASM SEL-PAN.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

scroll.obj: SCROLL.ASM SEL-PAN.INC panel.inf 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

sel-pan.obj: SEL-PAN.ASM $(inc)/CASVAR.INC SEL-PAN.INC 
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\select $(subst /,\,$<) $(subst /,\,$@);"

SELPAN_OBJS = sel-pan.obj panels.obj colors.obj scroll.obj

sel-pan.exe: $(SELPAN_OBJS) SEL-PAN.LNK
	dosemu -t --Fdrive_c ../.. -E "src\dolink src\select @sel-pan.lnk"

select.dat: sel-pan.exe
	exe2bin -q sel-pan.exe sel-pan.dat
	ln -sf ../TOOLS/COMPRESS.COM compress.com
	dosemu -t --Fdrive_c . -E "compress"

#
######################  make select.hlp #####################
#

#$(shell)/shellhlp/asc2hlp.exe : 
#				cd $(shell)/shellhlp
#				$(make) asc2hlp.exe
#				cd $(here)

select.hlp: USA.TXT
	rm -f select.hlp
	dosemu -t --Fdrive_c ../.. -E 'src\dohelp.bat src\select USA.txt select.hlp'

clean:
	rm -f *.obj
	rm -f panel.inf
	rm -f sel-pan.dat
	rm -f select.com
	rm -f select.hlp
	rm -f services.bak
	rm -f services.lib
	rm -f sel-pan.exe
	rm -f sel-pan.map
	rm -f select.cl[12ab]
	rm -f select.ctl
	rm -f select.dat
	rm -f select.exe
	rm -f select.map
	rm -f sstub.exe
	rm -f sstub.map
	rm -f resp.txt
	rm -f compress.com
