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

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: chkdsk.com

chkdsk.ctl chkdsk.cl1 chkdsk.cl2 chkdsk.cla chkdsk.clb chkdsk.clc chkdsk.cld: \
        chkdsk.skl $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG chkdsk.skl

chkinit.obj: chkinit.asm   \
	     chkequ.inc chkmacro.inc chkparse.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/ioctl.inc

chkdsk1.obj: chkdsk1.asm \
	     chkequ.inc chkmacro.inc chkchng.inc \
	     chkseg.inc chkdata.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc

chkdsk2.obj: chkdsk2.asm \
	     chkequ.inc chkmacro.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc

chkproc.obj: chkproc.asm \
	     chkequ.inc chkmacro.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc

chkproc2.obj: chkproc2.asm \
	     chkequ.inc chkmacro.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc

chkdisk.obj:  chkdisk.asm  \
	     chkequ.inc chkmacro.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc

chkfat.obj:   chkfat.asm   \
	     chkequ.inc chkmacro.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc

chkprmt.obj: chkprmt.asm \
	     chkequ.inc chkmacro.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc

chkdisp.obj: chkdisp.asm    \
	chkdsk.ctl \
	chkdsk.cla chkdsk.clb chkdsk.clc chkdsk.cld chkdsk.cl1 chkdsk.cl2 \
	     chkequ.inc chkmacro.inc chkparse.inc chkmsg.inc chkchng.inc \
	     chkseg.inc \
		$(inc)/dossym.inc $(inc)/sysmsg.inc  $(inc)/devsym.inc	 \
		$(inc)/cpmfcb.inc $(inc)/dosmac.inc $(inc)/ioctl.inc	 \
		$(inc)/syscall.inc
	$(AS) $(AFLAGS) -DNO_TEMPS -Fo$@ $<

OBJS = chkdisk.obj chkdisp.obj chkdsk1.obj chkdsk2.obj chkfat.obj \
       chkinit.obj chkprmt.obj chkproc2.obj chkproc.obj

chkdsk.com: $(OBJS) CHKDSK.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=chkdsk.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name chkdsk.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	../../bldtools/make-com.rb chkdsk.exe chkdsk.com

clean:
	rm -f *.obj
	rm -f *.lst
	rm -f *.err
	rm -f chkdsk.com
	rm -f chkdsk.cl[12a-d]
	rm -f chkdsk.ctl
	rm -f chkdsk.exe
	rm -f chkdsk.map
	rm -f resp.txt
