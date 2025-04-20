#************************** makefile for mapper ***************************

inc	 = ../INC

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: mapper.lib

f_first.obj: f_first.asm macros.inc find.inc

write.obj:  write.asm macros.inc

beep.obj:   beep.asm macros.inc

exit.obj:   exit.asm macros.inc

delete.obj: delete.asm macros.inc

getcntry.obj: getcntry.asm  macros.inc

f_close.obj: f_close.asm  macros.inc  find.inc

open.obj:   open.asm  macros.inc

read.obj:   read.asm  macros.inc

qcurdir.obj: qcurdir.asm  macros.inc

qcurdsk.obj: qcurdsk.asm  macros.inc

qfilemod.obj: qfilemod.asm macros.inc

sfilemod.obj: sfilemod.asm macros.inc

lseek.obj:  lseek.asm macros.inc

sfileinf.obj: sfileinf.asm macros.inc

close.obj:   close.asm macros.inc

allocseg.obj: allocseg.asm macros.inc

freeseg.obj: freeseg.asm  macros.inc

sel_disk.obj: sel_disk.asm macros.inc

qfsinfo.obj: qfsinfo.asm  macros.inc error.inc

f_next.obj: f_next.asm	macros.inc	find.inc

get_tod.obj: get_tod.asm  macros.inc

devconfg.obj: devconfg.asm  macros.inc

casemap.obj: casemap.asm  macros.inc

dbcs.obj:   dbcs.asm  macros.inc

ioctl.obj:  ioctl.asm  macros.inc

sighand.obj: sighand.asm  macros.inc msc.inc

error.obj:  error.asm  macros.inc

setint24.obj:  setint24.asm  macros.inc

qfileinf.obj: qfileinf.asm  macros.inc

scurpos.obj: scurpos.asm macros.inc

scrollup.obj: scrollup.asm  macros.inc

wchstra.obj: wchstra.asm  macros.inc

setfsinf.obj: setfsinf.asm macros.inc error.inc

OFILES = f_first.obj write.obj beep.obj exit.obj delete.obj getcntry.obj \
         f_close.obj open.obj read.obj qcurdir.obj qcurdsk.obj qfilemod.obj \
         sfilemod.obj lseek.obj sfileinf.obj close.obj allocseg.obj \
         freeseg.obj sel_disk.obj qfsinfo.obj f_next.obj get_tod.obj \
         devconfg.obj casemap.obj dbcs.obj ioctl.obj sighand.obj error.obj \
         setint24.obj qfileinf.obj scurpos.obj scrollup.obj wchstra.obj \
         setfsinf.obj

mapper.lib: $(OFILES)
	rm -f $@
	rm -f resp.txt
	for x in $(OFILES); do echo "+$$x" >>resp.txt; done
	wlib -l=mapper.lst $@ @resp.txt

clean:
	rm -f *.obj
	rm -f *.lst
	rm -f mapper.lib
	rm -f resp.txt
