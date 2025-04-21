#************************** makefile for cmd/append ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: chkdsk.com

chkdsk.ctl chkdsk.cl1 chkdsk.cl2 chkdsk.cla chkdsk.clb chkdsk.clc chkdsk.cld: \
        CHKDSK.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\chkdsk $(subst /,\,$<) $(country)"

chkinit.obj: CHKINIT.ASM   \
	     CHKEQU.INC CHKMACRO.INC CHKPARSE.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/ioctl.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

chkdsk1.obj: CHKDSK1.ASM \
	     CHKEQU.INC CHKMACRO.INC CHKCHNG.INC \
	     CHKSEG.INC CHKDATA.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

chkdsk2.obj: CHKDSK2.ASM \
	     CHKEQU.INC CHKMACRO.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

chkproc.obj: CHKPROC.ASM \
	     CHKEQU.INC CHKMACRO.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

chkproc2.obj: CHKPROC2.ASM \
	     CHKEQU.INC CHKMACRO.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

chkdisk.obj:  CHKDISK.ASM  \
	     CHKEQU.INC CHKMACRO.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

chkfat.obj:   CHKFAT.ASM   \
	     CHKEQU.INC CHKMACRO.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

chkprmt.obj: CHKPRMT.ASM \
	     CHKEQU.INC CHKMACRO.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

#chkexec.obj: CHKEXEC.ASM  /							;an038;bgb #commented out when received from IBM (mrw)
#	      CHKEQU.INC CHKMACRO.INC CHKCHNG.INC /				;an038;bgb
#	      CHKSEG.INC /						;an038;bgb
#		 $(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc   /	;an038;bgb
#		 $(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	  /	;an038;bgb
#		 $(inc)/syscall.inc						;an038;bgb

chkdisp.obj: CHKDISP.ASM    \
	chkdsk.ctl \
	chkdsk.cla chkdsk.clb chkdsk.clc chkdsk.cld chkdsk.cl1 chkdsk.cl2 \
	     CHKEQU.INC CHKMACRO.INC CHKPARSE.INC CHKMSG.INC CHKCHNG.INC \
	     CHKSEG.INC \
		$(inc)/dossym.inc $(inc)/SYSMSG.INC  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\chkdsk $(subst /,\,$<) $(subst /,\,$@)"

OBJS = chkdisk.obj chkdisp.obj chkdsk1.obj chkdsk2.obj chkfat.obj \
       chkinit.obj chkprmt.obj chkproc2.obj chkproc.obj

chkdsk.com: $(OBJS) CHKDSK.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\chkdsk @chkdsk.lnk"
#	echo 'system dos' >resp.txt
#	echo 'option map=chkdsk.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name chkdsk.exe' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\chkdsk\chkdsk.exe"

clean:
	rm -f *.obj
	rm -f chkdsk.com
	rm -f chkdsk.cl[12a-d]
	rm -f chkdsk.ctl
	rm -f chkdsk.exe
	rm -f chkdsk.map
	rm -f resp.txt
