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

all: ifsfunc.exe

ifsfunc.ctl ifsfunc.cl1 ifsfunc.cl2 ifsfunc.cla: IFSFUNC.SKL  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\ifsfunc $(subst /,\,$<) $(country)"

$(inc)/dossym.inc:	 $(inc)/versiona.inc $(inc)/dosmac.inc	      \
     $(inc)/bpb.inc	 $(inc)/buffer.inc   $(inc)/sysvar.inc	      \
     $(inc)/vector.inc	 $(inc)/mult.inc     $(inc)/dirent.inc	      \
     $(inc)/dpb.inc	 $(inc)/curdir.inc   $(inc)/cpmfcb.inc	      \
     $(inc)/find.inc	 $(inc)/pdb.inc      $(inc)/exe.inc	      \
     $(inc)/sf.inc	 $(inc)/arena.inc    $(inc)/intnat.inc	      \
     $(inc)/mi.inc	 $(inc)/filemode.inc $(inc)/error.inc	      \
     $(inc)/syscall.inc
	echo " touch $(inc)/dossym.inc "

ifssess.obj: IFSSESS.ASM $(inc)/ifssym.inc	   IFSFSYM.INC	      \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifsdir.obj: IFSDIR.ASM	 $(inc)/ifssym.inc	    IFSFSYM.INC       \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifsfile.obj: IFSFILE.ASM $(inc)/ifssym.inc	   IFSFSYM.INC	      \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm	      \
     $(inc)/doscntry.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifshand.obj: IFSHAND.ASM $(inc)/ifssym.inc	   IFSFSYM.INC	      \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifsdev.obj:  IFSDEV.ASM  $(inc)/ifssym.inc	    IFSFSYM.INC       \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifsutil.obj: IFSUTIL.ASM $(inc)/ifssym.inc	    IFSFSYM.INC       \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm	      \
     $(inc)/bugtyp.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifserror.obj: IFSERROR.ASM $(inc)/ifssym.inc	     IFSFSYM.INC      \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm	      \
     ifsfunc.ctl  ifsfunc.cla  ifsfunc.cl1  ifsfunc.cl2
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifsfdos.obj:  IFSFDOS.ASM $(inc)/ifssym.inc	    IFSFSYM.INC       \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm	      \
     $(inc)/msdata.asm	 $(inc)/bugtyp.asm   $(inc)/SYSMSG.INC	      \
     $(inc)/psdata.inc	 $(inc)/MSGSERV.ASM	  IFSPARSE.INC	      \
     $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

ifsinit.obj:  IFSINIT.ASM $(inc)/ifssym.inc	    IFSFSYM.INC       \
     $(inc)/dossym.inc	 $(inc)/devsym.inc   $(inc)/dosseg.asm	      \
     $(inc)/msdata.asm	 $(inc)/bugtyp.asm   $(inc)/SYSMSG.INC	      \
     $(inc)/psdata.inc	 $(inc)/MSGSERV.ASM	  IFSPARSE.INC	      \
     $(inc)/parse.asm						      \
     ifsfunc.ctl  ifsfunc.cla  ifsfunc.cl1  ifsfunc.cl2
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

$(inc)/nibdos.obj:
	$(MAKE) -C $(inc) nibdos.obj

$(inc)/const2.obj:
	$(MAKE) -C $(inc) const2.obj

$(inc)/msdata.obj:
	$(MAKE) -C $(inc) msdata.obj

$(inc)/mstable.obj:
	$(MAKE) -C $(inc) mstable.obj

$(inc)/msdosme.obj:
	$(MAKE) -C $(inc) msdosme.obj

$(dos)/msdisp.obj:
	$(MAKE) -C $(dos) msdisp.obj

$(dos)/mscode.obj:
	$(MAKE) -C $(dos) mscode.obj

ifsflink.obj: IFSFLINK.ASM					      \
     $(inc)/dossym.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\ifsfunc $(subst /,\,$<) $(subst /,\,$@)"

OBJS = ifssess.obj ifsdir.obj ifsfile.obj ifshand.obj ifsdev.obj ifsutil.obj \
       ifserror.obj ifsfdos.obj ifsinit.obj $(inc)/nibdos.obj \
       $(inc)/const2.obj $(inc)/msdata.obj $(inc)/mstable.obj \
       $(dos)/msdisp.obj $(dos)/mscode.obj $(inc)/msdosme.obj ifsflink.obj

ifsfunc.exe: ifssess.obj ifsdir.obj  ifsfile.obj  ifshand.obj	      \
	     ifsdev.obj  ifsutil.obj ifserror.obj ifsfdos.obj	      \
	     ifsinit.obj					      \
	     $(inc)/nibdos.obj	$(inc)/const2.obj  $(inc)/msdata.obj \
	     $(inc)/mstable.obj  $(dos)/msdisp.obj		     \
	     $(dos)/mscode.obj  $(inc)/msdosme.obj		     \
	     ifsflink.obj  IFSFUNC.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\ifsfunc @ifsfunc.lnk"

clean:
	rm -f *.obj
	rm -f ifsfunc.cl[12a]
	rm -f ifsfunc.ctl
	rm -f ifsfunc.exe
	rm -f ifsfunc.map
	rm -f resp.txt
