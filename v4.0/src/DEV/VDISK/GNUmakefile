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

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: vdisk.sys

vdisk.ctl vdisk.cl1 vdisk.cl2 vdisk.cla: vdisk.skl    \
           $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG vdisk.skl


vdisksys.obj: vdisksys.asm       \
              $(inc)/sysmsg.inc \
              $(inc)/msgserv.asm \
              $(inc)/copyrigh.inc \
              $(inc)/versiona.inc \
           vdisk.ctl             \
           vdisk.cl2             \
           vdisk.cla             \
           vdisk.cl1

OBJS = vdisksys.obj

vdisk.sys: $(OBJS) VDISK.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=vdisk.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name vdisk.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q vdisk.exe vdisk.sys

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f vdisk.sys
	rm -f vdisk.exe
	rm -f vdisk.map
	rm -f vdisk.cl[12a]
	rm -f vdisk.ctl
	rm -f resp.txt
