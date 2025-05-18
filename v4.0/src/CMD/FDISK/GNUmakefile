#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
comsubs = ../../comsubs
hinc	=../../H

country = usa-ms

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .c .asm .obj

CC = wcl
CFLAGS = -q -ms -os -zp=1 -I$(hinc) -wx

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

map	=../../MAPPER

all: fdisk.exe


# Handle the FDISK 'C' source compilations first

fdiskm.c  : fdisk.msg $(msg)/$(country).msg
	../../bldtools/menubld.rb $< $(msg)/$(country).msg $@

fdisk5.cl1 : fdisk5.skl $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg fdisk5.skl

fdisk.ctl fdisk.cl1 fdisk.cl2 fdisk.cla fdisk.clb: fdisk.skl $(msg)/$(country).msg
	../../bldtools/buildmsg.rb $(msg)/$(country).msg fdisk.skl

main.obj : main.c \
           fdisk.h subtype.h extern.h fdiskmsg.h msgret.h doscall.h 

fdisk.obj : fdisk.c \
            fdisk.h subtype.h extern.h fdiskmsg.h doscall.h msgret.h

mainmenu.obj : mainmenu.c fdisk.h subtype.h extern.h fdiskmsg.h 

display.obj : display.c \
              fdisk.h subtype.h extern.h fdiskmsg.h doscall.h

d_menus.obj : d_menus.c fdisk.h subtype.h extern.h fdiskmsg.h 

c_menus.obj : c_menus.c fdisk.h subtype.h extern.h fdiskmsg.h 

input.obj : input.c fdisk.h subtype.h extern.h fdiskmsg.h doscall.h

tdisplay.obj : tdisplay.c fdisk.h subtype.h extern.h fdiskmsg.h 

vdisplay.obj : vdisplay.c fdisk.h subtype.h extern.h fdiskmsg.h 

space.obj : space.c fdisk.h subtype.h extern.h

partinfo.obj : partinfo.c fdisk.h subtype.h extern.h 

makepart.obj : makepart.c fdisk.h subtype.h extern.h 

video.obj : video.c fdisk.h extern.h subtype.h fdiskmsg.h doscall.h

int13.obj : int13.c fdisk.h subtype.h extern.h fdiskmsg.h

diskout.obj : diskout.c fdisk.h subtype.h extern.h

fdparse.obj : fdparse.c fdisk.h subtype.h extern.h parse.h msgret.h 

convert.obj : convert.c fdisk.h subtype.h extern.h 

global.obj : global.c fdisk.h

fdiskm.obj : fdiskm.c

messages.obj : messages.c msgret.h extern.h subtype.h fdisk.h


# Handle the FDISK MASM source


fdboot.obj : fdboot.asm fdisk5.cl1

BOOT_OBJS = fdboot.obj

fdboot.bin: $(BOOT_OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=fdboot.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name fdboot.bin' >>resp.txt
	for x in $(BOOT_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

fdboot.inc: fdboot.bin
	../../bldtools/hexify.rb fdboot.bin fdboot.inc 600 200

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

fdisk.exe : $(FDISK_OBJS) $(map)/mapper.lib fdisk.ctl
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=fdisk.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name fdisk.exe' >>resp.txt
	for x in $(FDISK_OBJS); do echo "file $$x" >>resp.txt; done
	echo "library $(map)/mapper.lib" >>resp.txt
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f fdboot.bin
	rm -f fdboot.map
	rm -f fdboot.inc
	rm -f fdisk5.cl1
	rm -f fdiskm.c
	rm -f fdisk.cl[12ab]
	rm -f fdisk.ctl
	rm -f fdisk.exe
	rm -f fdisk.map
	rm -f resp.txt
