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


#	Definition for turning OFF high memory allocation
#		HIFLAG = -DNOHIMEM => turns it off
#		HIFLAG =	   => turns on high memory allocation
HIFLAG        = -DNOHIMEM
#HIFLAG	=

#	Definitions for assembler
#ASM = c:/bin/masm400
#ASM	   = masm400
ASM		= masm
AFLAGS		= -Mx -t -DI386 -DNoBugMode $(HIFLAG)
ADFLAGS 	= -Mx -t -DI386 $(HIFLAG)
AINC		= -i../emm

#	Defines for C Compiler
C	= cl
CFLAGS	=/AS /G2 /Oat /Gs /Ze /Zl /Fc /c

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
	$(ASM) $(AFLAGS) $(AINC) -p $*.asm;

.asm.lst:
	$(ASM) -l -n $(AFLAGS) $(AINC) -p $*.asm;

#******************************************************************************
#	List of include files required
#******************************************************************************
MEMMINC = ASCII_SM.EQU DRIVER.EQU PIC_DEF.EQU ROMSTRUC.EQU ROMXBIOS.EQU \
		DESC.INC ELIM.INC EMM386.INC INSTR386.INC KBD.INC LOADALL.INC \
		OEMDEP.INC PAGE.INC VDMSEG.INC VDMSEL.INC VM386.INC MACH_ID.INC


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

MEMMLIBS	= ../EMM/emmlib.lib

BUGLIBS 	= ../deb386/buglib.lib ../EMM/emmlib.lib

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
#emm386: emm386.exe emm386.com emm386d.exe
emm386: emm386.exe

#	production version of EMM386 device driver
#
emm386.exe: $(MEMMOBJ) $(MEMMLIBS) EMM386.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\memm\memm @emm386.lnk"
	rm -f emm386.sys
	mv emm386.exe emm386.sys

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

memm386.obj: MEMM386.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
memm386.lst:  MEMM386.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

elimfunc.obj: ELIMFUNC.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
elimfunc.lst:  ELIMFUNC.ASM  $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

init.obj: INIT.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
init.lst: INIT.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

allocmem.obj: ALLOCMEM.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
allocmem.lst: ALLOCMEM.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

rom_srch.obj: ROM_SRCH.ASM  $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
rom_srch.lst: ROM_SRCH.ASM  $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

inittab.obj inittab.lst: INITTAB.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

emmmes.obj emmmes.lst: EMMMES.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

extpool.obj extpool.lst: EXTPOOL.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

shiphi.obj shiphi.lst: SHIPHI.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

m_state.obj m_state.lst: M_STATE.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

ppage.obj ppage.lst: PPAGE.ASM $(MEMMINC) ../EMM/EMMDEF.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

#******************************************************************************
# VDM modules
#******************************************************************************

vdminit.obj vdminit.lst: VDMINIT.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

i286.obj i286.lst: I286.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

i386.obj i386.lst: I386.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

trapdef.obj trapdef.lst: TRAPDEF.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

tabdef.obj tabdef.lst: TABDEF.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

vmtrap.obj vmtrap.lst: VMTRAP.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

vminst.obj vminst.lst: VMINST.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

elimtrap.obj: ELIMTRAP.ASM $(MEMMINC) ../EMM/EMMDEF.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
elimtrap.lst: ELIMTRAP.ASM $(MEMMINC) ../EMM/EMMDEF.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

iotrap.obj iotrap.lst: IOTRAP.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

initepg.obj: INITEPG.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
initepg.lst: INITEPG.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

vminit.obj vminit.lst: VMINIT.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

em286ll.obj em286ll.lst: EM286LL.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

em386ll.obj em386ll.lst: EM386LL.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

moveb.obj: MOVEB.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
moveb.lst: MOVEB.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

util.obj: UTIL.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"
util.lst: UTIL.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

maplin.obj maplin.lst: MAPLIN.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

a20trap.obj a20trap.lst: A20TRAP.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

oemproc.obj oemproc.lst: OEMPROC.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

rrtrap.obj rrtrap.lst: RRTRAP.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

retreal.obj retreal.lst: RETREAL.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

errhndlr.obj errhndlr.lst: ERRHNDLR.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

ekbd.obj ekbd.lst: EKBD.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

initdeb.obj initdeb.lst: INITDEB.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

emminit.obj emminit.lst: EMMINIT.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

memmonf.obj memmonf.lst: MEMMONF.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

emm.obj emm.lst: EMM.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

mapdma.obj mapdma.lst: MAPDMA.C
	dosemu -t --Fdrive_c ../../.. -E "src\domsc3.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@)"

memminc.lst: MEMMINC.ASM $(MEMMINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\memm $(subst /,\,$<) $(subst /,\,$@) -l -n -DI386 -DNoBugMode -DNOHIMEM -i..\EMM"

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
	rm -f *.lst
	rm -f emm386.sys
	rm -f emm386.map
	rm -f mapdma.cod
	rm -f resp.txt
