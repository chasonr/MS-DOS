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

all: attrib.exe

attrib.ctl attrib.cl1 attrib.cl2 attrib.cla attrib.clb: ATTRIB.SKL \
	$(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\attrib $(subst /,\,$<) $(country)"

_parse.obj: _PARSE.ASM \
	$(inc)/parse.asm \
	$(inc)/psdata.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\attrib $(subst /,\,$<) $(subst /,\,$@)"

_msgret.obj: _MSGRET.ASM \
	$(inc)/MSGSERV.ASM \
	$(inc)/SYSMSG.INC  \
	$(inc)/copyrigh.inc \
	ATTRIB.SKL \
	attrib.ctl \
	attrib.cl1 \
	attrib.cl2 \
	attrib.cla \
	attrib.clb
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\attrib $(subst /,\,$<) $(subst /,\,$@)"

attriba.obj: ATTRIBA.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\attrib $(subst /,\,$<) $(subst /,\,$@)"

attrib.obj: ATTRIB.C \
	ATTRIB.H \
	PARSE.H \
	MSGRET.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\attrib $(subst /,\,$<) $(subst /,\,$@)"

OBJS = attriba.obj attrib.obj _parse.obj _msgret.obj

attrib.exe: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\attrib @attrib.lnk"
#	echo 'system dos' >resp.txt
#	echo 'option map=attrib.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name attrib.exe' >>resp.txt
#	echo 'libpath ../../TOOLS/BLD/LIB' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f attrib.cl[12ab]
	rm -f attrib.ctl
	rm -f attrib.exe
	rm -f attrib.map
