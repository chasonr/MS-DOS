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

all: mode.com

mode.ctl mode.cl1 mode.cl2 mode.cla mode.clb: MODE.SKL \
      $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\mode $(subst /,\,$<) $(country)"

main.obj: main.asm \
  $(inc)/copyrigh.inc \
  $(inc)/versiona.inc \
  $(inc)/sysmsg.inc \
  $(inc)/msgserv.asm \
  mode.ctl \
  mode.cl1 \
  mode.cl2 \
  mode.cla \
  mode.clb

scrntab.obj: scrntab.asm

modescrn.obj: modescrn.asm \
  common.stc

rescode.obj: rescode.asm

modecom.obj: modecom.asm \
	     modequat.inc \
	     common.stc

modeprin.obj: modeprin.asm \
  common.stc

modevid.obj: modevid.asm \
  common.stc

modeecho.obj: modeecho.asm \
   common.stc

modeleng.obj: modeleng.asm \
	      modequat.inc

modemes.obj: modemes.asm \
	     modesubs.inc \
	     modedefs.inc \
	     modequat.inc \
	     common.stc

display.obj: display.asm \
	     common.stc

typamat.obj: typamat.asm \
  $(inc)/version.inc \
	     modequat.inc

invoke.obj: invoke.asm \
	    modequat.inc \
	    common.stc

modepars.obj: modepars.asm \
	      modequat.inc \
	      common.stc


parshell.obj: parshell.asm \
  $(inc)/parse.asm \
  $(inc)/psdata.inc


modecp.obj: modecp.asm \
   modecpro.inc \
   modecpeq.inc \
   modecpms.inc

OBJS = rescode.obj modeecho.obj modeleng.obj modemes.obj modescrn.obj \
       main.obj modevid.obj modeprin.obj modecom.obj scrntab.obj modecp.obj \
       display.obj typamat.obj invoke.obj parshell.obj modepars.obj

mode.com: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=mode.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name mode.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q mode.exe mode.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f mode.com
	rm -f mode.exe
	rm -f mode.map
	rm -f mode.cl[12ab]
	rm -f mode.ctl
	rm -f mode.map
	rm -f resp.txt
