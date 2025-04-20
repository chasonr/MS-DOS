#**     makefile for fc

#DEST	=FC
#MSG	=MESSAGES

#	Path Definitions

BIOS	=../../BIOS
BOOT	=../../BOOT
dos	=../../DOS
inc	=../../INC
hinc	=../../H
H	=../../H

#	List of object files required

OBJ	= fc.obj \
	  error.obj \
	  fgetl.obj \
	  getl.obj \
	  itoupper.obj \
	  $(inc)/kstring.obj \
	  maxmin.obj \
	  move.obj \
	  ntoi.obj \
	  string.obj \
	  update.obj \
	  xtab.obj \
	  messages.obj

#       Rules and Dependencies follow

all:	fc.exe

$(inc)/printf.obj: $(inc)/PRINTF.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

$(inc)/kstring.obj: $(inc)/KSTRING.C $(hinc)/INTERNAT.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

getl.obj: GETL.ASM $(inc)/CMACROS.INC $(inc)/VERSION.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

itoupper.obj: ITOUPPER.ASM  $(inc)/CMACROS.INC $(inc)/VERSION.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

maxmin.obj: MAXMIN.ASM $(inc)/CMACROS.INC $(inc)/VERSION.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

messages.obj: MESSAGES.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

move.obj: MOVE.ASM $(inc)/CMACROS.INC $(inc)/VERSION.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

string.obj: STRING.ASM $(inc)/CMACROS.INC $(inc)/VERSION.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

xtab.obj: XTAB.ASM $(inc)/CMACROS.INC $(inc)/VERSION.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

error.obj: ERROR.C TOOLS.H TTYPES.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

fc.obj: FC.C FC.H TOOLS.H TTYPES.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

fgetl.obj: FGETL.C TOOLS.H TTYPES.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

ntoi.obj: NTOI.C TOOLS.H TTYPES.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

update.obj: UPDATE.C TOOLS.H TTYPES.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

fc.exe: $(OBJ) FC.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\fc @fc.lnk,"
#	echo 'system dos' >resp.txt
#	echo 'option map=fc.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name fc.exe' >>resp.txt
#	for x in $(OBJ); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f fc.exe
	rm -f fc.map
	rm -f resp.txt
