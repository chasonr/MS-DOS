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

all: label.com

labl.ctl labl.cl1 labl.cl2 labl.cla: LABL.SKL     \
  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\label $(subst /,\,$<) $(country)"

label.obj: label.asm

labelm.obj: labelm.asm  \
  labl.ctl labl.cl1 labl.cl2 labl.cla \
  $(inc)/versiona.inc   \
  $(inc)/msgdcl.inc   \
  $(inc)/copyrigh.inc   \
  $(inc)/sysmsg.inc     \
  $(inc)/msgserv.asm

OBJS = label.obj labelm.obj

label.com: $(OBJS) LABEL.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=label.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name label.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q label.exe label.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f label.com
	rm -f label.exe
	rm -f label.map
	rm -f labl.cl[12a]
	rm -f labl.ctl
	rm -f resp.txt
