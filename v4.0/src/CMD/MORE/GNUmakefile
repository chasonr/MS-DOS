#************************ makefile for cmd/more *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: more.com

more.ctl more.cl1 more.cl2 more.cla:       more.skl \
                $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg more.skl

more.obj: more.asm             \
          more.inc             \
          more.ctl             \
          more.cla             \
          more.cl1             \
          more.cl2             \
          $(inc)/syscall.inc   \
          $(inc)/msgserv.asm   \
          $(inc)/sysmsg.inc    \
          $(inc)/versiona.inc  \
          $(inc)/copyrigh.inc

OBJS = more.obj

more.com: $(OBJS) MORE.LNK
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=more.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name more.com' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f more.com
	rm -f more.map
	rm -f more.cl[12a]
	rm -f more.ctl
	rm -f resp.txt
