#*************************** makefile for inc ****************************

msg	=../MESSAGES
dos	=../DOS
inc	=../INC
hinc	=../H

#
#######################	dependencies begin here. #########################
#

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(dos) -Fl -Sa

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

DOSSYM_INC = dossym.inc arena.inc bpb.inc buffer.inc cpmfcb.inc curdir.inc \
             dbcs.sw dirent.inc dosmac.inc dpb.inc error.inc exe.inc \
             filemode.inc find.inc intnat.inc mi.inc mult.inc pdb.inc sf.inc \
             syscall.inc sysvar.inc vector.inc versiona.inc version.inc

all: 		errtst.obj sysvar.obj cds.obj dpb.obj nibdos.obj \
		const2.obj msdata.obj msdosme.obj mstable.obj printf.obj \
		string.obj MSGSERV.ASM

msdos.cl1 msdos.cl3:
	$(MAKE) -C $(dos) msdos.cl1

errtst.obj: 	ERRTST.C \
  		$(hinc)/TYPES.H  \
  		$(hinc)/COMSUB.H  \
  		$(hinc)/DPB.H
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\inc $(subst /,\,$<) $(subst /,\,$@)"

sysvar.obj: 	SYSVAR.C \
  		$(hinc)/TYPES.H  \
  		$(hinc)/SYSVAR.H
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\inc $(subst /,\,$<) $(subst /,\,$@)"

cds.obj: 	CDS.C \
  		$(hinc)/TYPES.H  \
  		$(hinc)/SYSVAR.H  \
  		$(hinc)/CDS.H  \
  		$(hinc)/DPB.H
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\inc $(subst /,\,$<) $(subst /,\,$@)"

dpb.obj: 	DPB.C \
  		$(hinc)/DPB.H \
  		dpb.inc
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\inc $(subst /,\,$<) $(subst /,\,$@)"

string.obj:	STRING.C \
		$(hinc)/TYPES.H  \
		$(hinc)/INTERNAT.H
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\inc $(subst /,\,$<) $(subst /,\,$@)"

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

printf.obj:	PRINTF.ASM arena.inc bpb.inc buffer.inc cpmfcb.inc \
        	curdir.inc dbcs.sw dirent.inc dosmac.inc dpb.inc error.inc \
        	exe.inc filemode.inc find.inc intnat.inc mi.inc mult.inc \
        	pdb.inc sf.inc syscall.inc sysvar.inc vector.inc versiona.inc \
        	version.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
