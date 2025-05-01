#************************ makefile for dev/xma2ems************************

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

all: xma2ems.sys

xma2ems.ctl xma2ems.cl1: XMA2EMS.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg1.bat src\dev\xma2ems $(subst /,\,$<) $(country)"

xma2ems.obj:	xma2ems.asm emsinit.inc genioctl.inc i13hook.inc lim40b.inc \
		lim40.inc parmpars.inc ps2_5060.inc romscan.inc xma1diag.inc \
		xma2emsp.inc $(inc)/msbds.inc $(inc)/parse.asm \
		$(inc)/psdata.inc $(inc)/sysvar.inc $(inc)/version.inc \
		xma2ems.cl1

OBJS = xma2ems.obj

xma2ems.sys: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=xma2ems.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name xma2ems.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q xma2ems.exe xma2ems.sys

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f xma2ems.cl1
	rm -f xma2ems.sys
	rm -f xma2ems.exe
	rm -f xma2ems.map
	rm -f resp.txt
