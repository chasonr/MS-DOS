#************************** makefile for cmd/append ***************************

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

all: attrib.exe

attrib.ctl attrib.cl1 attrib.cl2 attrib.cla attrib.clb: ATTRIB.SKL \
	$(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\attrib $(subst /,\,$<) $(country)"

_parse.obj: _parse.asm \
	$(inc)/parse.asm \
	$(inc)/psdata.inc

_msgret.obj: _msgret.asm \
	$(inc)/msgserv.asm \
	$(inc)/sysmsg.inc  \
	$(inc)/copyrigh.inc \
	attrib.ctl \
	attrib.cl1 \
	attrib.cl2 \
	attrib.cla \
	attrib.clb

attriba.obj: attriba.asm

attrib.obj: ATTRIB.C \
	ATTRIB.H \
	PARSE.H \
	MSGRET.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\attrib $(subst /,\,$<) $(subst /,\,$@)"

OBJS = attriba.obj attrib.obj _parse.obj _msgret.obj

attrib.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\attrib /map @attrib.lnk"
#	ln -sf ../../TOOLS/BLD/LIB/SLIBCE.LIB SLIBCE.lib
#	echo 'system dos' >resp.txt
#	echo 'option map=attrib.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name attrib.exe' >>resp.txt
#	echo 'libpath .' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f attrib.cl[12ab]
	rm -f attrib.ctl
	rm -f attrib.exe
	rm -f attrib.map
	rm -f SLIBCE.lib
