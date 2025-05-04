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

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

map	=../../MAPPER

all: fdisk.exe


# Handle the FDISK 'C' source compilations first

fdiskm.c  : FDISK.MSG $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domenu.bat src\cmd\fdisk $(subst /,\,$<) $(country)"

fdisk5.cl1 : fdisk5.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG fdisk5.skl

fdisk.ctl fdisk.cl1 fdisk.cl2 fdisk.cla fdisk.clb: fdisk.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG fdisk.skl

main.obj : MAIN.C \
           FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H MSGRET.H DOSCALL.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

fdisk.obj : FDISK.C \
            FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H DOSCALL.H MSGRET.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

mainmenu.obj : MAINMENU.C FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

display.obj : DISPLAY.C \
              FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H DOSCALL.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

d_menus.obj : D_MENUS.C FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

c_menus.obj : C_MENUS.C FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

input.obj : INPUT.C FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H DOSCALL.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

tdisplay.obj : TDISPLAY.C FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

vdisplay.obj : VDISPLAY.C FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

space.obj : SPACE.C FDISK.H SUBTYPE.H EXTERN.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

partinfo.obj : PARTINFO.C FDISK.H SUBTYPE.H EXTERN.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

makepart.obj : MAKEPART.C FDISK.H SUBTYPE.H EXTERN.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

video.obj : VIDEO.C FDISK.H EXTERN.H SUBTYPE.H FDISKMSG.H DOSCALL.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

int13.obj : INT13.C FDISK.H SUBTYPE.H EXTERN.H FDISKMSG.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

diskout.obj : DISKOUT.C FDISK.H SUBTYPE.H EXTERN.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

fdparse.obj : FDPARSE.C FDISK.H SUBTYPE.H EXTERN.H PARSE.H MSGRET.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

convert.obj : CONVERT.C FDISK.H SUBTYPE.H EXTERN.H 
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

global.obj : GLOBAL.C FDISK.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

fdiskm.obj : fdiskm.c
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"

messages.obj : MESSAGES.C MSGRET.H EXTERN.H SUBTYPE.H FDISK.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fdisk $(subst /,\,$<) $(subst /,\,$@)"


# Handle the FDISK MASM source


fdboot.obj : fdboot.asm fdisk5.cl1

BOOT_OBJS = fdboot.obj

fdboot.inc: $(BOOT_OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=fdboot.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name fdboot.exe' >>resp.txt
	for x in $(BOOT_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q fdboot.exe fdboot.bin
	dosemu -t --Fdrive_c ../../.. -E "src\tools\dbof src\cmd\fdisk\fdboot.bin src\cmd\fdisk\fdboot.inc 600 200"

_parse.obj : _parse.asm $(inc)/psdata.inc $(inc)/parse.asm

_msgret.obj : _msgret.asm $(inc)/sysmsg.inc $(inc)/msgserv.asm \
              $(inc)/copyrigh.inc $(inc)/versiona.inc \
             fdisk.ctl fdisk.cla fdisk.clb fdisk.cl1 fdisk.cl2

bootrec.obj : bootrec.asm fdboot.inc

reboot.obj : reboot.asm

$(map)/mapper.lib:
	$(MAKE) -C $(map) mapper.lib

# Do the link of FDISK

FDISK_OBJS = main.obj mainmenu.obj d_menus.obj c_menus.obj fdisk.obj \
             reboot.obj bootrec.obj fdboot.obj display.obj input.obj \
             tdisplay.obj vdisplay.obj space.obj partinfo.obj video.obj \
             makepart.obj int13.obj diskout.obj messages.obj fdparse.obj \
             convert.obj global.obj _parse.obj _msgret.obj fdiskm.obj

fdisk.exe : $(FDISK_OBJS) $(map)/mapper.lib FDISK.LNK fdisk.ctl \
            $(inc)/COMSUBS.LIB
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\fdisk @fdisk.lnk"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f fdboot.bin
	rm -f fdboot.map
	rm -f fdboot.inc
	rm -f fdboot.exe
	rm -f fdisk5.cl1
	rm -f fdiskm.c
	rm -f fdisk.cl[12ab]
	rm -f fdisk.ctl
	rm -f fdisk.exe
	rm -f fdisk.map
	rm -f resp.txt
