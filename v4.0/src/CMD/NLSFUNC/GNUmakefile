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

all: nlsfunc.exe

nlsfunc.ctl nlsfunc.cl1 nlsfunc.cl2 nlsfunc.cla: nlsfunc.skl	\
	     $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG nlsfunc.skl

nlsfunc.obj: nlsfunc.asm	  \
	     funcdbcs.inc	  \
	     msg2nls.inc	  \
	     funcparm.inc	  \
	     nlsfunc.ctl	  \
	     nlsfunc.cla	  \
	     nlsfunc.cl1	  \
	     nlsfunc.cl2	  \
	     doesmac.inc       \
	     $(inc)/mult.inc     \
	     $(inc)/msgserv.asm   \
	     $(inc)/doscntry.inc \
	     $(inc)/devsym.inc   \
	     $(inc)/dosmac.inc    \
	     $(inc)/sf.inc     \
	     $(inc)/sysmsg.inc     \
	     $(inc)/versiona.inc     \
	     $(inc)/copyrigh.inc

nlsparm.obj:  nlsparm.asm	  \
	      $(inc)/parse.asm \
	      $(inc)/psdata.inc

OBJS = nlsfunc.obj nlsparm.obj

nlsfunc.exe: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=nlsfunc.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name nlsfunc.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f nlsfunc.cl[12a]
	rm -f nlsfunc.ctl
	rm -f nlsfunc.exe
	rm -f nlsfunc.map
	rm -f resp.txt
