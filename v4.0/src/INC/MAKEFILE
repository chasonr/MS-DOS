#*************************** makefile for inc ****************************

msg	=..\messages
dos	=..\dos
inc	=..\inc
hinc	=..\h

#
#######################	dependencies begin here. #########################
#

all: 		errtst.obj sysvar.obj cds.obj dpb.obj nibdos.obj \
		const2.obj msdata.obj msdosme.obj mstable.obj printf.obj \
		string.obj msgserv.asm

errtst.obj: 	errtst.c \
  		$(hinc)\types.h  \
  		$(hinc)\comsub.h  \
  		$(hinc)\dpb.h

sysvar.obj: 	sysvar.c \
  		$(hinc)\types.h  \
  		$(hinc)\sysvar.h

cds.obj: 	cds.c \
  		$(hinc)\types.h  \
  		$(hinc)\sysvar.h  \
  		$(hinc)\cds.h  \
  		$(hinc)\dpb.h

dpb.obj: 	dpb.c \
  		$(hinc)\dpb.h \
  		dpb.inc

string.obj:	string.c \
		$(hinc)\types.h  \
		$(hinc)\internat.h

nibdos.obj:	nibdos.asm $(dos)\mssw.asm $(dos)\msconst.asm \
           	dossym.inc dosseg.asm mshead.asm

const2.obj: 	const2.asm dossym.inc devsym.inc \
         	dosseg.asm

msdata.obj: 	msdata.asm $(dos)\mssw.asm dosseg.asm \
            	dosmac.inc msdata.asm $(dos)\msinit.asm \
            	devsym.inc vector.inc buffer.inc \
            	dirent.inc dpb.inc curdir.inc \
            	find.inc pdb.inc \
            	sf.inc arena.inc mi.inc

msdosme.obj: 	msdosme.asm $(dos)\mssw.asm dosseg.asm \
             	$(dos)\dosmes.asm dosmac.inc intnat.inc \
             	divmes.asm

mstable.obj:	mstable.asm $(dos)\mssw.asm	      \
     		$(dos)\ms_table.asm dossym.inc dosseg.asm     \
     		$(dos)\misc2.asm

printf.obj:	printf.asm arena.inc bpb.inc buffer.inc cpmfcb.inc \
        	curdir.inc dbcs.sw dirent.inc dosmac.inc dpb.inc error.inc \
        	exe.inc filemode.inc find.inc intnat.inc mi.inc mult.inc \
        	pdb.inc sf.inc syscall.inc sysvar.inc vector.inc versiona.inc \
        	version.inc

clean:
	@if exist *.obj del *.obj
