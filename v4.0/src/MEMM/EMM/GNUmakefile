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
HIFLAG	      = /DNOHIMEM
#HIFLAG	=

#	Definitions for assembler
#	(using masm 4.00)
MASM	= masm
#MASM	= /bin/masm400
#MASM	 = masm400
AFLAGS	= /Mx /t /DI386  /i../memm $(HIFLAG)
AINC	= ../MEMM/VDMSEG.INC ../MEMM/VDMSEL.INC EMMDEF.INC

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

emmp.obj:	EMMP.ASM $(AINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\emm $(subst /,\,$<) $(subst /,\,$@) -I..\memm -DI386 -DNOHIMEM"

emmsup.obj:	EMMSUP.ASM $(AINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\emm $(subst /,\,$<) $(subst /,\,$@) -I..\memm -DI386 -DNOHIMEM"

emmdisp.obj:	EMMDISP.ASM $(AINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\emm $(subst /,\,$<) $(subst /,\,$@) -I..\memm -DI386 -DNOHIMEM"

emmdata.obj:	EMMDATA.ASM $(AINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\emm $(subst /,\,$<) $(subst /,\,$@) -I..\memm -DI386 -DNOHIMEM"

emminc.obj:	EMMINC.ASM $(AINC)
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\memm\emm $(subst /,\,$<) $(subst /,\,$@) -I..\memm -DI386 -DNOHIMEM"

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
