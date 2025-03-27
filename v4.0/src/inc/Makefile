#*************************** makefile for inc ****************************

msg	=../messages
dos	=../dos
hinc	=../h

COUNTRY = usa-ms

AS = jwasm
ASFLAGS = -Zm -Zg -I$(dos) -Fl

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

.asm.obj:
	$(AS) $(ASFLAGS) -Fo$@ $<

DOSSYM_INC = dossym.inc dbcs.sw dosmac.inc versiona.inc bpb.inc buffer.inc \
             sysvar.inc version.inc vector.inc mult.inc dirent.inc dpb.inc \
             curdir.inc cpmfcb.inc find.inc pdb.inc exe.inc sf.inc arena.inc \
             intnat.inc mi.inc filemode.inc error.inc syscall.inc

all: 		errtst.obj sysvar.obj cds.obj dpb.obj nibdos.obj \
		const2.obj msdata.obj msdosme.obj mstable.obj printf.obj \
		string.obj msgserv.asm

errtst.obj: 	errtst.c \
  		$(hinc)/types.h  \
  		$(hinc)/comsub.h  \
  		$(hinc)/dpb.h

sysvar.obj: 	sysvar.c \
  		$(hinc)/types.h  \
  		$(hinc)/sysvar.h

cds.obj: 	cds.c \
  		$(hinc)/types.h  \
  		$(hinc)/sysvar.h  \
  		$(hinc)/cds.h  \
  		$(hinc)/dpb.h

dpb.obj: 	dpb.c \
  		$(hinc)/dpb.h \
  		dpb.inc

string.obj:	string.c \
		$(hinc)/types.h  \
		$(hinc)/internat.h

nibdos.obj:	nibdos.asm bugtyp.asm devsym.inc $(dos)/msconst.asm \
            $(dos)/mssw.asm dosseg.asm $(DOSSYM_INC) mshead.asm

const2.obj: const2.asm const2.asm devsym.inc dosseg.asm $(DOSSYM_INC)

msdata.obj: msdata.asm arena.inc buffer.inc curdir.inc devsym.inc dirent.inc \
            doscntry.inc dosmac.inc $(dos)/msinit.asm $(dos)/mssw.asm \
            dosseg.asm dpb.inc fastopen.inc find.inc mi.inc ms_data.asm \
            msdata.asm pdb.inc sf.inc sysvar.inc vector.inc version.inc

msdosme.obj: msdosme.asm divmes.asm doscntry.inc $(dos)/dosmes.asm \
             $(dos)/msdos.cl1 $(dos)/msdos.cl3 $(dos)/mssw.asm dosseg.asm \
             $(DOSSYM_INC) msdosme.asm yesno.asm

mstable.obj: mstable.asm copyrigh.inc $(dos)/mssw.asm $(dos)/ms_table.asm \
             dosseg.asm $(DOSSYM_INC) ea.inc fastopen.inc mstable.asm

printf.obj:	printf.asm arena.inc bpb.inc buffer.inc cpmfcb.inc \
        	curdir.inc dbcs.sw dirent.inc dosmac.inc dpb.inc error.inc \
        	exe.inc filemode.inc find.inc intnat.inc mi.inc mult.inc \
        	pdb.inc sf.inc syscall.inc sysvar.inc vector.inc versiona.inc \
        	version.inc

clean:
	@rm -f *.obj *.lst *.err
