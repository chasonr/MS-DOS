#************************* Makefile for KEYB *************************

inc	=../../INC
msg	=../../MESSAGES
dos	=../../DOS
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
###################### Dependencies begin here. ######################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: keyb.com

keyb.ctl keyb.cl1 keyb.cl2 keyb.cla: KEYB.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\keyb $(subst /,\,$<) $(country)"

keybcmd.obj: keybcmd.asm \
             $(inc)/sysmsg.inc \
             $(inc)/versiona.inc \
             $(inc)/msgserv.asm \
             $(inc)/copyrigh.inc \
             keybequ.inc  \
             keybsys.inc  \
             keybi9.inc   \
             keybi9c.inc  \
             keybi2f.inc  \
             keybi48.inc  \
             keybshar.inc \
             keyb.ctl     \
             keyb.cl1     \
             keyb.cl2     \
             keyb.cla     \
             keybdcl.inc  \
             keybtbbl.inc \
             commsubs.inc \
             keybcpsd.inc \
             $(inc)/postequ.inc  \
             $(inc)/dseg.inc \
             $(inc)/msgdcl.inc

keybtbbl.obj: keybtbbl.asm keybequ.inc keybshar.inc keybsys.inc keybcmd.inc \
              keybdcl.inc commsubs.inc keybcpsd.inc

commsubs.obj: commsubs.asm keybequ.inc keybcpsd.inc keybshar.inc keybcmd.inc \
              $(inc)/dseg.inc $(inc)/postequ.inc

keybi2f.obj: keybi2f.asm keybequ.inc keybshar.inc keybmac.inc keybcmd.inc \
             keybcpsd.inc keybi9c.inc

keybi48.obj: keybi48.asm keybequ.inc keybshar.inc keybmac.inc keybcmd.inc \
             keybcpsd.inc $(inc)/postequ.inc $(inc)/dseg.inc

keyb.obj: keyb.asm keybcmd.inc

keybcpsd.obj: keybcpsd.asm keybshar.inc keybcmd.inc keybtbbl.inc

keybi9.obj: keybi9.asm keybequ.inc $(inc)/dseg.inc $(inc)/postequ.inc \
            keybshar.inc keybi2f.inc keybi9c.inc keybcpsd.inc keybcmd.inc

keybi9c.obj: keybi9c.asm keybequ.inc $(inc)/dseg.inc $(inc)/postequ.inc \
             keybshar.inc keybi2f.inc keybi9.inc keybcpsd.inc keybcmd.inc

parser.obj:  parser.asm \
             $(inc)/parse.asm \
             $(inc)/psdata.inc \
             keybdcl.inc

OBJS = keyb.obj keybi9.obj keybi9c.obj keybi2f.obj keybi48.obj keybcpsd.obj \
       commsubs.obj keybtbbl.obj parser.obj keybcmd.obj

keyb.com: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=keyb.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name keyb.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q keyb.exe keyb.com

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f keyb.com
	rm -f keyb.exe
	rm -f keyb.map
	rm -f keyb.cl[12a]
	rm -f keyb.ctl
	rm -f resp.txt
