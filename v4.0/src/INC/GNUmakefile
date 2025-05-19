#*************************** makefile for inc ****************************

msg	=../MESSAGES
dos	=../DOS
inc	=../INC
hinc	=../H

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .c .asm .obj

CC = wcl
CFLAGS = -q -ms -os -zp=1 -I$(hinc) -wx

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(dos) -Fl -Sa

.c.obj:
	$(CC) $(CFLAGS) -c -fo=$@ $<

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

DOSSYM_INC = dossym.inc arena.inc bpb.inc buffer.inc cpmfcb.inc curdir.inc \
             dbcs.sw dirent.inc dosmac.inc dpb.inc error.inc exe.inc \
             filemode.inc find.inc intnat.inc mi.inc mult.inc pdb.inc sf.inc \
             syscall.inc sysvar.inc vector.inc versiona.inc version.inc

all: 		errtst.obj sysvar.obj cds.obj dpb.obj nibdos.obj \
		const2.obj msdata.obj msdosme.obj mstable.obj \
		string.obj msgserv.asm

msdos.cl1 msdos.cl3:
	$(MAKE) -C $(dos) msdos.cl1

errtst.obj: 	errtst.c \
  		$(hinc)/errtst.h  \
  		$(hinc)/comsub.h  \
  		$(hinc)/dpb.h \
  		$(hinc)/jointype.h

sysvar.obj: 	sysvar.c \
  		$(hinc)/sysvar.h \
  		$(hinc)/jointype.h

cds.obj: 	cds.c \
  		$(hinc)/sysvar.h  \
  		$(hinc)/cds.h  \
  		$(hinc)/dpb.h \
  		$(hinc)/jointype.h

dpb.obj: 	dpb.c \
  		$(hinc)/types.h \
  		$(hinc)/sysvar.h \
  		$(hinc)/dpb.h \
  		$(hinc)/cds.h

string.obj:	string.c \
		$(hinc)/types.h  \
		$(hinc)/internat.h

nibdos.obj:	 nibdos.asm $(dos)/mssw.asm $(dos)/msconst.asm \
           	 $(DOSSYM_INC) dosseg.asm mshead.asm bugtyp.asm devsym.inc

const2.obj:  const2.asm $(DOSSYM_INC) devsym.inc \
             dosseg.asm

msdata.obj:  msdata.asm $(dos)/mssw.asm dosseg.asm \
             $(dos)/msinit.asm doscntry.inc fastopen.inc ms_data.asm \
             devsym.inc $(DOSSYM_INC)

msdosme.obj: msdosme.asm $(dos)/mssw.asm dosseg.asm \
             $(dos)/dosmes.asm divmes.asm doscntry.inc yesno.asm \
             $(DOSSYM_INC) $(dos)/msdos.cl1 $(dos)/msdos.cl3

mstable.obj: mstable.asm $(dos)/mssw.asm	      \
             $(dos)/ms_table.asm $(DOSSYM_INC) dosseg.asm     \
             ea.inc fastopen.inc

#printf.obj:	printf.asm arena.inc bpb.inc buffer.inc cpmfcb.inc \
#        	curdir.inc dbcs.sw dirent.inc dosmac.inc dpb.inc error.inc \
#        	exe.inc filemode.inc find.inc intnat.inc mi.inc mult.inc \
#        	pdb.inc sf.inc syscall.inc sysvar.inc vector.inc versiona.inc \
#        	version.inc

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
