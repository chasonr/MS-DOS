#*************************** makefile for inc ****************************

msg	=../MESSAGES
dos	=../DOS
inc	=../INC
hinc	=../H

#
#######################	dependencies begin here. #########################
#

all: 		errtst.obj sysvar.obj cds.obj dpb.obj nibdos.obj \
		const2.obj msdata.obj msdosme.obj mstable.obj printf.obj \
		string.obj MSGSERV.ASM

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

nibdos.obj:	NIBDOS.ASM $(dos)/MSSW.ASM $(dos)/MSCONST.ASM \
           	DOSSYM.INC DOSSEG.ASM MSHEAD.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

const2.obj: 	CONST2.ASM DOSSYM.INC devsym.inc \
         	DOSSEG.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

msdata.obj: 	MSDATA.ASM $(dos)/MSSW.ASM DOSSEG.ASM \
            	dosmac.inc MSDATA.ASM $(dos)/MSINIT.ASM \
            	devsym.inc vector.inc buffer.inc \
            	dirent.inc dpb.inc curdir.inc \
            	FIND.INC pdb.inc \
            	sf.inc arena.inc mi.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

msdosme.obj: 	MSDOSME.ASM $(dos)/MSSW.ASM DOSSEG.ASM \
             	$(dos)/DOSMES.ASM dosmac.inc intnat.inc \
             	DIVMES.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

mstable.obj:	MSTABLE.ASM $(dos)/MSSW.ASM	      \
     		$(dos)/MS_TABLE.ASM DOSSYM.INC DOSSEG.ASM     \
     		$(dos)/MISC2.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

printf.obj:	PRINTF.ASM arena.inc bpb.inc buffer.inc CPMFCB.INC \
        	curdir.inc dbcs.sw dirent.inc dosmac.inc dpb.inc ERROR.INC \
        	exe.inc FILEMODE.INC FIND.INC intnat.inc mi.inc MULT.INC \
        	pdb.inc sf.inc syscall.inc sysvar.inc vector.inc versiona.inc \
        	version.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

clean:
	rm -f *.obj
