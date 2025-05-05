#*************************** Makefile for Bios ************************

msg	=../../MSG
dos	=../../DOS
inc	=../../INC

#
###################### Dependencies begin here #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all:           keyboard.sys

kdfnow.obj:    kdfnow.asm

kdffr120.obj:  kdffr120.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdffr189.obj:  kdffr189.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfeof.obj:    kdfeof.asm $(inc)/copyrigh.inc

kdfuk166.obj:  kdfuk166.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfuk168.obj:  kdfuk168.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfit141.obj:  kdfit141.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfit142.obj:  kdfit142.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfge.obj:     kdfge.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfsp.obj:     kdfsp.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfnl.obj:     kdfnl.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfno.obj:     kdfno.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfdk.obj:     kdfdk.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfsg.obj:     kdfsg.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfsf.obj:     kdfsf.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfpo.obj:     kdfpo.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfbe.obj:     kdfbe.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfcf.obj:     kdfcf.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfla.obj:     kdfla.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

kdfsv.obj:     kdfsv.asm keybmac.inc keybshar.inc $(inc)/postequ.inc

OBJS = kdfnow.obj kdfsp.obj kdfpo.obj kdffr120.obj kdffr189.obj kdfdk.obj \
       kdfsg.obj kdfge.obj kdfit141.obj kdfit142.obj kdfuk166.obj \
       kdfuk168.obj kdfsf.obj kdfbe.obj kdfnl.obj kdfno.obj kdfcf.obj \
       kdfsv.obj kdfla.obj kdfeof.obj

keyboard.sys: $(OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=keyboard.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name keyboard.sys' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f keyboard.sys
	rm -f keyboard.map
	rm -f resp.txt
