#******************************************************************************
#	title	MAKEFILE - EMMLIB.LIB build file
#******************************************************************************
#
#   (C) Copyright MICROSOFT Corp. 1986
#
#   Title:    MEMM - MICROSOFT Expanded Memory Manager 386
#		EMMLIB.LIB - EMM functions library
#
#   Module:   MAKEFILE for EMMLIB - EMM library
#
#   Version:  0.02
#
#   Date:     May 12, 1986
#
#******************************************************************************
#
#   Change log:
#
#     DATE    REVISION			DESCRIPTION
#   --------  --------	-------------------------------------------------------
#   06/12/86  Original
#   06/25/86  0.02	Added EMMDEF.INC (SBP).
#
#******************************************************************************
#
#   Functional Description:
#
#   This file assembles and links EMMLIB.LIB
#
#******************************************************************************
.SUFFIXES:
.SUFFIXES:	.c .asm .obj .lst .def .lnk .lrf .exe .com

#	Definition for turning OFF high memory allocation
#		HIFLAG = -DNOHIMEM => turns it off
#		HIFLAG =	   => turns on high memory allocation
HIFLAG	      = -DNOHIMEM
#HIFLAG	=

#	Definitions for assembler
#	(using masm 4.00)
MASM	= masm
#MASM	= /bin/masm400
#MASM	 = masm400
MEMM = ../MEMM
AINC	= $(MEMM)/vdmseg.inc $(MEMM)/vdmsel.inc emmdef.inc

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(MEMM) -Fl $(HIFLAG) -DI386

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

#	Definitions for linker for old style .exe files
#LINK	= /bin/link
LINK	 = link
LFLAGS	= /NOI /M
LIBS	=

#	Definitions for librarian
#LIB	= /bin/lib
LIB	 = lib

#	Defines for C Compiler
C	= cl
#C	= /bin/msc
#C	 = msc
CFLAGS	=/ASw /G2 /Oat /Gs /Ze /Zl /Fc /c

#
# definition of objects
#
OBJS=emmfunct.obj emm40.obj emmp.obj emmsup.obj emmdisp.obj emmdata.obj emminc.obj

emmlib.lib:	$(OBJS)
	rm -f emmlib.lib
	for x in $(OBJS); do wlib emmlib.lib +$$x; done

emmfunct.obj:	EMMFUNCT.C EMM.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc3.bat src\memm\emm $(subst /,\,$<) $(subst /,\,$@)"

emm40.obj:	EMM40.C EMM.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc3.bat src\memm\emm $(subst /,\,$<) $(subst /,\,$@)"

emmp.obj:	emmp.asm $(AINC) $(MEMM)/page.inc $(MEMM)/vm386.inc \
            $(MEMM)/desc.inc

emmsup.obj:	emmsup.asm $(AINC) $(MEMM)/desc.inc $(MEMM)/page.inc

emmdisp.obj:	emmdisp.asm $(AINC)

emmdata.obj:	emmdata.asm $(AINC) $(MEMM)/page.inc

emminc.obj:	emminc.asm $(AINC) $(MEMM)/desc.inc $(MEMM)/oemdep.inc \
            $(MEMM)/page.inc

clean:
	rm -f *.obj
	rm -f emm40.cod
	rm -f emmdata.lst
	rm -f emmdisp.lst
	rm -f emmfunct.cod
	rm -f emminc.lst
	rm -f emmlib.bak
	rm -f emmlib.lib
	rm -f emmp.lst
	rm -f emmsup.lst
	rm -f resp.txt
