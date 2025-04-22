#************************ Makefile for vdisk **************************

inc	=../../INC
msg	=../../MESSAGES
dos	=../../DOS
hinc	=../../HINC

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
####################### Dependencies begin here. #######################
#

all: vdisk.sys

vdisk.ctl vdisk.cl1 vdisk.cl2 vdisk.cla: VDISK.SKL    \
           $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\dev\vdisk $(subst /,\,$<) $(country)"


vdisksys.obj: VDISKSYS.ASM       \
           VDISKSYS.INC          \
           vdisk.ctl             \
           vdisk.cl2             \
           vdisk.cla             \
           vdisk.cl1             \
           $(inc)/msgserv.asm \
           $(inc)/sysmsg.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\vdisk $(subst /,\,$<) $(subst /,\,$@)"

OBJS = vdisksys.obj

vdisk.sys: $(OBJS) VDISK.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\vdisk @vdisk.lnk"
	exe2bin -q vdisk.exe vdisk.sys
	rm vdisk.exe

clean:
	rm -f *.obj
	rm -f vdisk.sys
	rm -f vdisk.cl[12a]
	rm -f vdisk.ctl
	rm -f resp.txt
