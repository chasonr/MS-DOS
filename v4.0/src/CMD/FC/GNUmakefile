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

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all:	fc.exe

$(inc)/kstring.obj: $(inc)/KSTRING.C $(hinc)/INTERNAT.H
	dosemu -t --Fdrive_c ../../.. -E "src\domsc.bat src\cmd\fc $(subst /,\,$<) $(subst /,\,$@)"

getl.obj: getl.asm $(inc)/cmacros.inc $(inc)/version.inc

itoupper.obj: itoupper.asm  $(inc)/cmacros.inc $(inc)/version.inc

maxmin.obj: maxmin.asm $(inc)/cmacros.inc $(inc)/version.inc

messages.obj: messages.asm

move.obj: move.asm $(inc)/cmacros.inc $(inc)/version.inc

string.obj: string.asm $(inc)/cmacros.inc $(inc)/version.inc

xtab.obj: xtab.asm $(inc)/cmacros.inc $(inc)/version.inc

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
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\fc /map @fc.lnk,"
#	echo 'system dos' >resp.txt
#	echo 'option map=fc.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name fc.exe' >>resp.txt
#	for x in $(OBJ); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f fc.exe
	rm -f fc.map
	rm -f resp.txt
