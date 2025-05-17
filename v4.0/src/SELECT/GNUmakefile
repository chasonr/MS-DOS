#
###### Make file for SELECT.EXE, SELECT.DAT, SELECT.COM, SELECT.HLP #####
#

msg	=../MESSAGES
dos	=../DOS
inc	=../INC
hinc	=../H
shell	=../SHELL
cas	=../SHELL/CASSFAR

country = usa-ms

#
#######################	dependencies begin here. #########################
#

all: select.exe select.dat select.com select.hlp

.SUFFIXES: .c .asm .obj

CC = wcl
CFLAGS = -q -ms -os -zp=1 -I. -wx -ecc

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

#
############################ Make SELECT.EXE #############################
#

select.ctl select.cl1 select.cl2 select.cla select.clb: select.skl $(msg)/$(country).msg
	../bldtools/buildmsg.rb $(msg)/$(country).msg select.skl

MACROS_INC = macros.inc macros2.inc macros3.inc macros4.inc macros5.inc \
             macros6.inc macros7.inc macros8.inc mac_equ.inc \
             $(inc)/versiona.inc

select0.obj  : select0.asm panel.mac $(MACROS_INC) $(inc)/sysmsg.inc \
               $(inc)/msgserv.asm $(inc)/copyrigh.inc $(inc)/versiona.inc \
               rout_ext.inc ext.inc pan-list.inc casextrn.inc \
               $(inc)/msgdcl.inc \
               select.ctl select.cl1 select.cl2 select.cla select.clb

select1.obj  : select1.asm panel.mac select.inc pcequate.inc castruc.inc \
               $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc pan-list.inc \
               casextrn.inc

select2.obj  : select2.asm panel.mac select.inc pcequate.inc castruc.inc \
               $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc pan-list.inc \
               casextrn.inc

select2a.obj : select2a.asm panel.mac select.inc pcequate.inc pan-list.inc \
               castruc.inc $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc \
               casextrn.inc

select3.obj  : select3.asm panel.mac select.inc pcequate.inc pan-list.inc \
               castruc.inc $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc \
               casextrn.inc

select4.obj  : select4.asm panel.mac select.inc pcequate.inc pan-list.inc \
               castruc.inc $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc \
               casextrn.inc

select5.obj  : select5.asm panel.mac select.inc pcequate.inc castruc.inc \
               $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc pan-list.inc \
               casextrn.inc

select5a.obj : select5a.asm panel.mac select.inc pcequate.inc castruc.inc \
               $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc pan-list.inc \
               casextrn.inc

select6.obj  : select6.asm panel.mac select.inc pcequate.inc castruc.inc \
               $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc pan-list.inc \
               casextrn.inc

select7.obj  : select7.asm panel.mac select.inc pcequate.inc pan-list.inc \
               castruc.inc $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc \
               casextrn.inc

select8.obj  : select8.asm panel.mac select.inc pcequate.inc pan-list.inc \
               castruc.inc $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc \
               casextrn.inc

select9.obj  : select9.asm panel.mac select.inc pcequate.inc pan-list.inc \
               castruc.inc $(MACROS_INC) ext.inc varstruc.inc rout_ext.inc \
               casextrn.inc

gen_coms.obj : gen_coms.asm ext.inc $(MACROS_INC) rout_ext.inc

mparse.obj   : mparse.asm $(inc)/parse.asm $(inc)/psdata.inc

initmem.obj  : initmem.asm $(MACROS_INC)

input.obj    : input.asm pcequate.inc

routines.obj : routines.asm pan-list.inc panel.mac $(MACROS_INC) varstruc.inc \
               ext.inc

routine2.obj : routine2.asm $(MACROS_INC) varstruc.inc ext.inc

var.obj      : var.asm $(inc)/sysmsg.inc $(inc)/msgserv.asm \
               $(inc)/copyrigh.inc $(inc)/versiona.inc varstruc.inc \
               sel_file.inc $(inc)/msgdcl.inc \
               select.ctl

prn_def.obj  : prn_def.asm $(MACROS_INC)

scn_parm.obj : scn_parm.asm $(MACROS_INC) ext.inc

s_disply.obj : s_disply.asm

mod_copy.obj : mod_copy.asm xmainmsg.equ dos.equ xcopy.equ pan-list.inc \
               panel.mac casextrn.inc dosfiles.inc

bridge.obj   : bridge.asm

caservic.obj : caservic.asm $(MACROS_INC) panel.mac pan-list.inc select.inc \
               pcequate.inc castruc.inc data.mac $(inc)/casvar.inc \
               $(inc)/casrn.inc

ckdisp.obj   : ckdisp.asm

intvec.obj   : intvec.asm panel.mac $(MACROS_INC) varstruc.inc ext.inc \
               pan-list.inc casextrn.inc

asm2c.obj    : asm2c.asm

get_stat.obj : get_stat.c get_stat.h extern.h

int13.obj    : int13.c get_stat.h extern.h

global.obj   : global.c get_stat.h

../CMD/FDISK/bootrec.obj:
	$(MAKE) -C ../CMD/FDISK bootrec.obj

bootrec.obj : ../CMD/FDISK/bootrec.obj
	cp ../CMD/FDISK/bootrec.obj .

selquit.obj  : selquit.asm panel.mac pcequate.inc pan-list.inc castruc.inc \
               ext.inc $(MACROS_INC)

selchild.obj : selchild.asm pcequate.inc castruc.inc $(MACROS_INC)

services.obj : services.asm $(MACROS_INC) pcequate.inc castruc.inc \
               $(inc)/casvar.inc $(inc)/casrn.inc

get_help.obj : get_help.asm

selserv.obj : selserv.asm

services.lib : selquit.obj selchild.obj services.obj get_help.obj selserv.obj
	rm -f services.lib
	wlib services.lib -+selquit.obj;
	wlib services.lib -+selchild.obj;
	wlib services.lib -+services.obj;
	wlib services.lib -+get_help.obj;
	wlib services.lib -+selserv.obj;

SELECT_OBJS = select0.obj select1.obj select2.obj select2a.obj select3.obj \
              select4.obj select5.obj select5a.obj select6.obj select7.obj \
              select8.obj select9.obj routine2.obj gen_coms.obj routines.obj \
              intvec.obj ckdisp.obj scn_parm.obj prn_def.obj var.obj \
              caservic.obj input.obj initmem.obj mparse.obj mod_copy.obj \
              s_disply.obj bridge.obj asm2c.obj get_stat.obj global.obj \
              int13.obj bootrec.obj

select.exe: $(SELECT_OBJS) services.lib
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=select.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name select.exe' >>resp.txt
	for x in $(SELECT_OBJS); do echo "file $$x" >>resp.txt; done
	echo 'library services.lib' >>resp.txt
	echo 'library CASSFAR.LIB' >>resp.txt
	wlink @resp.txt

#
#######################  make select.com #####################
#

sstub.obj    : sstub.asm $(inc)/sysmsg.inc $(inc)/msgserv.asm \
               $(inc)/copyrigh.inc $(inc)/versiona.inc $(inc)/msgdcl.inc \
               select.ctl select.cl1 select.cl2 select.cla select.clb

STUB_OBJS = sstub.obj

select.com: $(STUB_OBJS)
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=sstub.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name select.com' >>resp.txt
	for x in $(STUB_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

#
#######################  make select.dat ####################
#


panel.inf: usa.inf
	cp usa.inf panel.inf

panels.obj : panels.asm sel-pan.inc pan-list.inc panel.inf

colors.obj : colors.asm sel-pan.inc

scroll.obj : scroll.asm sel-pan.inc panel.inf

sel-pan.obj: sel-pan.asm

SELPAN_OBJS = sel-pan.obj panels.obj colors.obj scroll.obj

sel-pan.dat: $(SELPAN_OBJS) SEL-PAN.LNK
	echo 'system dos com' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=sel-pan.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name sel-pan.dat' >>resp.txt
	for x in $(SELPAN_OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt

select.dat: sel-pan.dat
	../bldtools/rlencode.rb sel-pan.dat select.dat

#
######################  make select.hlp #####################
#

#$(shell)/shellhlp/asc2hlp.exe :
#				cd $(shell)/shellhlp
#				$(make) asc2hlp.exe
#				cd $(here)

select.hlp: usa.txt
	../bldtools/asc2hlp.rb usa.txt select.hlp

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f panel.inf
	rm -f sel-pan.dat
	rm -f select.com
	rm -f select.hlp
	rm -f services.bak
	rm -f services.lib
	rm -f sel-pan.dat
	rm -f sel-pan.map
	rm -f select.cl[12ab]
	rm -f select.ctl
	rm -f select.dat
	rm -f select.exe
	rm -f select.map
	rm -f sstub.map
	rm -f resp.txt
