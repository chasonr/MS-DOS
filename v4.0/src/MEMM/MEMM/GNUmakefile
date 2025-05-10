#******************************************************************************
#	title	MAKEFILE - MEMM build file
#******************************************************************************
#
#   (C) Copyright MICROSOFT Corp. 1986
#
#   Title:    MEMM - MICROSOFT Expanded Memory Manager 386
#
#   Module:   MAKEFILE
#
#   Version:  0.06
#
#   Date:     May 12, 1986
#
#   Author:
#
#******************************************************************************
#
#   Change log:
#
#     DATE    REVISION			DESCRIPTION
#   --------  --------	-------------------------------------------------------
#	      Original
#   05/12/86  B-	Cleanup and segment reorganization
#   06/03/86  C-	Added module for driver i/f
#   06/08/86  C-	Merge in lastest code from MS
#   06/17/86  D-	Added debug version.
#   06/28/86  0.02	Name change from MEMM386 to MEMM
#   07/01/86  0.03	Added MapDMA module.
#   07/11/86  0.05	Moved HIFLAG into global includes.
#
#******************************************************************************
#
#   Functional Description:
#
#   This file assembles and links
#	(1) EMM386.EXE	  - Production version of EMM386 driver
#	(2) EMM386.COM	  - Production version of EMM386 utility
#	(3) EMM386D.EXE   - Debug (Internal) version of EMM386 driver
#
#******************************************************************************

#******************************************************************************
#	R U L E S   and   M A C R O S
#******************************************************************************
.SUFFIXES:
.SUFFIXES:	.c .asm .obj .lst .def .lnk .lrf .exe .com

# EMM library is in this directory
EMM = ../EMM

#	Definition for turning OFF high memory allocation
#		HIFLAG = -DNOHIMEM => turns it off
#		HIFLAG =	   => turns on high memory allocation
HIFLAG        = -DNOHIMEM
#HIFLAG	=

#	Definitions for assembler
#ASM = c:/bin/masm400
#ASM	   = masm400
ASM		= jwasm
ADFLAGS 	= -q -Zm -Zg $(HIFLAG) -Fl
AFLAGS      = -DNoBugMode $(ADFLAGS)
AINC		= -I$(EMM)

#	Defines for C Compiler
CC	= wcl
CFLAGS = -ms -zu -2 -oat -s -ze -zl -wx

#	Definitions for linker for old style .exe files
#LINK = c:/bin/link
#LINK	   = link
LINK	= link
LFLAGS	= /NOI

#	Definitions for .COM generation
CONVERT = c:/dos/exe2bin
#CONVERT = exe2bin

#	Rules for generating object and linker response and definition files
.asm.obj:
	$(ASM) $(AFLAGS) $(AINC) -Fo$@ $<

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

#******************************************************************************
#	List of object files required
#******************************************************************************

MEMMOBJ = memm386.obj elimfunc.obj init.obj allocmem.obj ppage.obj emmmes.obj \
		inittab.obj memmonf.obj rom_srch.obj i286.obj trapdef.obj \
		i386.obj tabdef.obj vmtrap.obj vminst.obj elimtrap.obj \
		vminit.obj moveb.obj em286ll.obj em386ll.obj retreal.obj \
		rrtrap.obj vdminit.obj initepg.obj errhndlr.obj maplin.obj \
		ekbd.obj util.obj initdeb.obj emm.obj emminit.obj mapdma.obj \
		iotrap.obj a20trap.obj oemproc.obj m_state.obj \
		shiphi.obj extpool.obj

COMOBJ = memmcom.obj memmonf.obj

BUGOBJ = memm386.obj elimfunc.obj init.obj allocmem.obj ppage.obj emmmes.obj \
		inittab.obj memmonf.obj rom_srch.obj i286.obj trapdef.obj \
		i386.obj tabdefD.obj vmtrapD.obj vminstD.obj elimtrap.obj \
		vminit.obj moveb.obj em286ll.obj em386ll.obj retreal.obj \
		rrtrap.obj vdminitD.obj initepg.obj errhndlr.obj maplin.obj \
		ekbd.obj util.obj initdebD.obj emmD.obj emminit.obj mapdma.obj \
		iotrap.obj a20trap.obj oemproc.obj kbd.obj print.obj m_state.obj

#******************************************************************************
#	List of libraries required
#******************************************************************************

MEMMLIBS	= $(EMM)/emmlib.lib

BUGLIBS 	= ../deb386/buglib.lib $(EMM)/emmlib.lib

#******************************************************************************
#	Listing files
#******************************************************************************
MEMMLST = memm386.lst elimfunc.lst init.lst ppage.lst allocmem.lst emmmes.lst \
		inittab.lst memmonf.lst rom_srch.lst i286.lst trapdef.obj \
		i386.lst tabdef.lst vmtrap.lst vminst.lst elimtrap.lst \
		vminit.lst moveb.lst em286ll.lst em386ll.lst retreal.lst \
		rrtrap.lst vdminit.lst initepg.lst errhndlr.lst maplin.lst \
		ekbd.lst util.lst initdeb.lst emm.lst emminit.lst mapdma.lst \
		iotrap.lst a20trap.lst memminc.lst oemproc.lst shiphi.lst \
		extpool.lst

COMLST = memmcom.lst memmonf.lst

BUGLST = memm386.lst elimfunc.lst init.lst allocmem.lst ppage.lst emmmes.lst \
		inittab.lst memmonf.lst rom_srch.lst i286.lst trapdef.lst \
		i386.lst tabdefD.lst vmtrapD.lst vminstD.lst elimtrap.lst \
		vminit.lst moveb.lst em286ll.lst em386ll.lst retreal.lst \
		rrtrap.lst vdminitD.lst initepg.lst errhndlr.lst maplin.lst \
		ekbd.lst util.lst initdebD.lst emmD.lst emminit.lst mapdma.lst \
		iotrap.lst a20trap.lst kbd.lst emmincD.lst oemproc.lst


#******************************************************************************
#	MEMM targets
#******************************************************************************
#emm386: emm386.sys emm386.com emm386d.exe
emm386: emm386.sys

#	production version of EMM386 device driver
#
emm386.sys: $(MEMMOBJ) $(MEMMLIBS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=emm386.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name emm386.sys' >>resp.txt
	for x in $(MEMMOBJ); do echo "file $$x" >>resp.txt; done
	for x in $(MEMMLIBS); do echo "library $$x" >>resp.txt; done
	wlink @resp.txt

$(EMM)/emmlib.lib:
	$(MAKE) -C $(EMM) emmlib.lib

#	EMM386.COM utility
#
#emm386.com: $(COMOBJ) emmcom.lnk
#	 $(LINK) $(LFLAGS) @emmcom.lnk
#	 $(CONVERT) emmcom.exe emm386.com

#	debug version of EMM386 driver
#
#emm386d.exe: $(BUGOBJ) $(BUGLIBS) emm386d.lnk
#	 $(LINK) $(LFLAGS) @emm386d.lnk

#******************************************************************************
# EMM386 driver i/f modules
#******************************************************************************

memm386.obj: memm386.asm driver.equ driver.str vdmseg.inc

elimfunc.obj: elimfunc.asm vdmseg.inc

init.obj: init.asm vdmseg.inc vdmsel.inc desc.inc emm386.inc driver.equ \
          driver.str ascii_sm.equ

allocmem.obj: allocmem.asm vdmseg.inc vdmsel.inc emm386.inc driver.equ \
              driver.str romxbios.equ desc.inc ascii_sm.equ oemdep.inc \
              $(EMM)/emmdef.inc

rom_srch.obj: rom_srch.asm $(EMM)/emmdef.inc vdmseg.inc romstruc.equ

inittab.obj: inittab.asm vdmseg.inc vdmsel.inc desc.inc page.inc \
             instr386.inc oemdep.inc

emmmes.obj: emmmes.asm ascii_sm.equ vdmseg.inc

extpool.obj: extpool.asm vdmseg.inc

shiphi.obj: shiphi.asm vdmseg.inc desc.inc page.inc

m_state.obj: m_state.asm vdmseg.inc

ppage.obj: ppage.asm vdmseg.inc emm386.inc $(EMM)/emmdef.inc

#******************************************************************************
# VDM modules
#******************************************************************************

vdminit.obj: vdminit.asm vdmseg.inc vdmsel.inc desc.inc instr386.inc page.inc

i286.obj: i286.asm vdmseg.inc vdmsel.inc desc.inc

i386.obj: i386.asm vdmseg.inc vdmsel.inc desc.inc page.inc

trapdef.obj: trapdef.asm vdmseg.inc vdmsel.inc desc.inc elim.inc page.inc \
             oemdep.inc instr386.inc vm386.inc

tabdef.obj: tabdef.asm vdmseg.inc vdmsel.inc desc.inc page.inc

vmtrap.obj: vmtrap.asm vdmseg.inc vdmsel.inc vm386.inc pic_def.equ \
            instr386.inc oemdep.inc

vminst.obj: vminst.asm vdmseg.inc desc.inc vdmsel.inc vm386.inc loadall.inc \
            instr386.inc oemdep.inc

elimtrap.obj: elimtrap.asm vdmseg.inc vdmsel.inc desc.inc elim.inc \
              mach_id.inc page.inc oemdep.inc instr386.inc vm386.inc \
              $(EMM)/emmdef.inc

iotrap.obj: iotrap.asm vdmseg.inc vdmsel.inc

initepg.obj: initepg.asm vdmseg.inc vdmsel.inc desc.inc page.inc \
             instr386.inc $(EMM)/emmdef.inc

vminit.obj: vminit.asm vdmseg.inc vdmsel.inc desc.inc elim.inc

em286ll.obj: em286ll.asm loadall.inc vdmseg.inc desc.inc vdmsel.inc \
             instr386.inc vm386.inc oemdep.inc

em386ll.obj: em386ll.asm loadall.inc vdmseg.inc desc.inc vdmsel.inc \
             instr386.inc vm386.inc oemdep.inc

moveb.obj: moveb.asm vdmseg.inc vdmsel.inc desc.inc instr386.inc oemdep.inc \
           vm386.inc

util.obj: util.asm vdmseg.inc vdmsel.inc desc.inc instr386.inc oemdep.inc

maplin.obj: maplin.asm vdmseg.inc vdmsel.inc instr386.inc oemdep.inc

a20trap.obj: a20trap.asm vdmseg.inc vdmsel.inc

oemproc.obj: oemproc.asm page.inc vdmseg.inc vdmsel.inc desc.inc \
             instr386.inc romxbios.equ

rrtrap.obj: rrtrap.asm vdmseg.inc vdmsel.inc desc.inc instr386.inc vm386.inc

retreal.obj: retreal.asm vdmseg.inc vdmsel.inc instr386.inc oemdep.inc

errhndlr.obj: errhndlr.asm vdmseg.inc vdmsel.inc vm386.inc kbd.inc

ekbd.obj: ekbd.asm vdmseg.inc kbd.inc

initdeb.obj: initdeb.asm vdmseg.inc vdmsel.inc

emminit.obj: emminit.asm vdmseg.inc $(EMM)/emmdef.inc

memmonf.obj: memmonf.asm ascii_sm.equ memm_msg.inc

emm.obj: emm.asm vdmseg.inc vdmsel.inc vm386.inc oemdep.inc $(EMM)/emmdef.inc

mapdma.obj: mapdma.c

#******************************************************************************
# debug modules
#******************************************************************************

#tabdefD.obj: tabdef.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) tabdef.asm,tabdefD.obj;
#tabdefD.lst: tabdef.asm $(MEMMINC)
#	 $(ASM) -l -n $(ADFLAGS) $(AINC) tabdef.asm,tabdefD.obj,tabdefD.lst;
#
#vminstD.obj: vminst.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) vminst.asm,vminstD.obj;
#vminstD.lst: vminst.asm $(MEMMINC)
#	 $(ASM) -l -n $(ADFLAGS) $(AINC) vminst.asm,vminstD.obj,vminstD.lst;

#vmtrapD.obj: vmtrap.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) vmtrap.asm,vmtrapD.obj;
#vmtrapD.lst: vmtrap.asm $(MEMMINC)
#	 $(ASM) -l -n $(ADFLAGS) $(AINC) vmtrap.asm,vmtrapD.obj,vmtrapD.lst;
#
#vdminitD.obj: vdminit.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) vdminit.asm,vdminitD.obj;
#vdminitD.lst: vdminit.asm $(MEMMINC)
#	 $(ASM) -l -n $(ADFLAGS) $(AINC) vdminit.asm,vdminitD.obj,vdminitD.lst;

#initdebD.obj: initdeb.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) initdeb.asm,initdebD.obj;
#initdebD.lst: initdeb.asm $(MEMMINC)
#	 $(ASM) -l -n $(ADFLAGS) $(AINC) initdeb.asm,initdebD.obj,initdebD.lst;

#emmD.obj: emm.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) emm.asm,emmD.obj;
#emmD.lst: emm.asm $(MEMMINC)
#	 $(ASM) -l -n $(ADFLAGS) $(AINC) emm.asm,emmD.obj,emmD.lst;

#kbd.obj kbd.lst: kbd.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) -p $*.asm;

#print.obj print.lst: print.asm $(MEMMINC)
#	 $(ASM) $(ADFLAGS) $(AINC) -p $*.asm;

#memmincD.lst: memminc.asm $(MEMMINC)
#	 $(ASM) -l -n $(ADFLAGS) $(AINC) memminc.asm,memmincD.obj,memmincD.lst;

#******************************************************************************
# EMM386.COM modules
#******************************************************************************

#memmcom.obj: memmcom.asm
#	 $(ASM) $(AFLAGS) $(AINC) $*.asm;
#memmcom.lst: memmcom.asm
#	 $(ASM) -l -n $(AFLAGS) $(AINC) $*.asm;

#memmonf.obj: memmonf.asm memm_msg.inc
#	 $(ASM) $(AFLAGS) $(AINC) $*.asm;
#memmonf.lst: memmonf.asm memm_msg.inc
#	 $(ASM) -l -n $(AFLAGS) $(AINC) $*.asm;

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f emm386.sys
	rm -f emm386.map
	rm -f mapdma.cod
	rm -f resp.txt
