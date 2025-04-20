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
  		DPB.INC
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\inc $(subst /,\,$<) $(subst /,\,$@)"

string.obj:	STRING.C \
		$(hinc)/TYPES.H  \
		$(hinc)/INTERNAT.H
	dosemu -t --Fdrive_c ../.. -E "src\domsc.bat src\inc $(subst /,\,$<) $(subst /,\,$@)"

nibdos.obj:	NIBDOS.ASM $(dos)/MSSW.ASM $(dos)/MSCONST.ASM \
           	DOSSYM.INC DOSSEG.ASM MSHEAD.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

const2.obj: 	CONST2.ASM DOSSYM.INC DEVSYM.INC \
         	DOSSEG.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

msdata.obj: 	MSDATA.ASM $(dos)/MSSW.ASM DOSSEG.ASM \
            	DOSMAC.INC MSDATA.ASM $(dos)/MSINIT.ASM \
            	DEVSYM.INC VECTOR.INC BUFFER.INC \
            	DIRENT.INC DPB.INC CURDIR.INC \
            	FIND.INC PDB.INC \
            	SF.INC ARENA.INC MI.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

msdosme.obj: 	MSDOSME.ASM $(dos)/MSSW.ASM DOSSEG.ASM \
             	$(dos)/DOSMES.ASM DOSMAC.INC INTNAT.INC \
             	DIVMES.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

mstable.obj:	MSTABLE.ASM $(dos)/MSSW.ASM	      \
     		$(dos)/MS_TABLE.ASM DOSSYM.INC DOSSEG.ASM     \
     		$(dos)/MISC2.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

printf.obj:	PRINTF.ASM ARENA.INC BPB.INC BUFFER.INC CPMFCB.INC \
        	CURDIR.INC dbcs.sw DIRENT.INC DOSMAC.INC DPB.INC ERROR.INC \
        	EXE.INC FILEMODE.INC FIND.INC INTNAT.INC MI.INC MULT.INC \
        	PDB.INC SF.INC SYSCALL.INC SYSVAR.INC VECTOR.INC VERSIONA.INC \
        	VERSION.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\inc $(subst /,\,$<) $(subst /,\,$@);"

clean:
	rm -f *.obj
