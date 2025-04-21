#*************************** Makefile for DOS ***************************

msg	=../MESSAGES
inc	=../INC
hinc	=../HINC
dos	=.

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
###################### Dependencies begin here ##########################
#

all: msdos.sys

msdos.cl1: MSDOS.SKL \
	$(msg)/$(COUNTRY).MSG 
	dosemu -t --Fdrive_c ../.. -E "src\domsg1.bat src\dos $(subst /,\,$<) $(country);"

DOSSYM.INC: $(inc)/dosmac.inc $(inc)/bpb.inc \
    $(inc)/buffer.inc $(inc)/sysvar.inc $(inc)/vector.inc \
    $(inc)/MULT.INC $(inc)/dirent.inc $(inc)/dpb.inc $(inc)/curdir.inc \
    $(inc)/CPMFCB.INC $(inc)/FIND.INC $(inc)/pdb.inc $(inc)/exe.inc \
    $(inc)/sf.inc $(inc)/arena.inc $(inc)/intnat.inc $(inc)/mi.inc \
    $(inc)/FILEMODE.INC $(inc)/ERROR.INC $(inc)/syscall.inc
	echo "touch DOSSYM.INC; files that are in ../inc"

$(inc)/nibdos.obj: 
	$(MAKE) -C $(inc) nibdos.obj

$(inc)/const2.obj: 
	$(MAKE) -C $(inc) const2.obj

$(inc)/msdata.obj: 
	$(MAKE) -C $(inc) msdata.obj
		   
$(inc)/mstable.obj:
	$(MAKE) -C $(inc) mstable.obj
		   
$(inc)/msdosme.obj:
	$(MAKE) -C $(inc) msdosme.obj

msdisp.obj: MSDISP.ASM MSSW.ASM DISP.ASM \
	     $(inc)/DOSSYM.INC $(inc)/DOSSEG.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

mscode.obj: MSCODE.ASM MSSW.ASM MS_CODE.ASM \
	     $(inc)/DOSSYM.INC $(inc)/DOSSEG.ASM $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

time.obj: TIME.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
	  $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

getset.obj: GETSET.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

parse.obj: PARSE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

misc.obj: MISC.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/BUGTYP.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

misc2.obj: MISC2.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/BUGTYP.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

crit.obj: CRIT.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/BUGTYP.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

cpmio.obj: CPMIO.ASM $(inc)/DOSSEG.ASM \
    $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc \
    KSTRIN.ASM STRIN.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

cpmio2.obj: CPMIO2.ASM $(inc)/DOSSEG.ASM \
    $(inc)/DOSSYM.INC $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

fcbio.obj: FCBIO.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/sf.inc $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

fcbio2.obj: FCBIO2.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

search.obj: SEARCH.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

path.obj: PATH.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

ioctl.obj: IOCTL.ASM $(inc)/ioctl.inc $(inc)/DOSSEG.ASM \
    $(inc)/DOSSYM.INC $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

delete.obj: DELETE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/sf.inc $(inc)/FASTXXXX.INC $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

rename.obj: RENAME.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/sf.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

finfo.obj: FINFO.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

dup.obj: DUP.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

create.obj: CREATE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

open.obj: OPEN.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

dinfo.obj: DINFO.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
   $(inc)/devsym.inc $(inc)/BUGTYP.ASM $(inc)/buffer.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

isearch.obj: ISEARCH.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

abort.obj: ABORT.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/sf.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

close.obj: CLOSE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/buffer.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

dircall.obj: DIRCALL.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/buffer.inc $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

disk.obj: DISK.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

disk2.obj: DISK2.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/buffer.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

disk3.obj: DISK3.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

dir.obj: DIR.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
	 $(inc)/buffer.inc $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

dir2.obj: DIR2.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
	  $(inc)/buffer.inc $(inc)/FASTOPEN.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

dev.obj: DEV.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

mknode.obj: MKNODE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc  $(inc)/buffer.inc $(inc)/FASTOPEN.INC \
    $(inc)/FILEMODE.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

rom.obj: ROM.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc  $(inc)/buffer.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

fcb.obj: FCB.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

msctrlc.obj: MSCTRLC.ASM MSSW.ASM CTRLC.ASM \
    $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC $(inc)/devsym.inc \
    $(inc)/BUGTYP.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

fat.obj: FAT.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/buffer.inc $(inc)/curdir.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

buf.obj: BUF.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/buffer.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

proc.obj: PROC.ASM \
    $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC $(inc)/devsym.inc \
    $(inc)/curdir.inc \
    EXEC.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

alloc.obj: ALLOC.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

srvcall.obj: SRVCALL.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

util.obj: UTIL.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

macro.obj: MACRO.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc  $(inc)/curdir.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

macro2.obj: MACRO2.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/curdir.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

handle.obj: HANDLE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/BUGTYP.ASM
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

file.obj: FILE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/BUGTYP.ASM $(inc)/FASTOPEN.INC \
    $(inc)/FILEMODE.INC
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

lock.obj: LOCK.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

share.obj: SHARE.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

extattr.obj: EXTATTR.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/EA.INC $(inc)/buffer.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

ifs.obj: IFS.ASM $(inc)/DOSSEG.ASM $(inc)/DOSSYM.INC \
    $(inc)/devsym.inc $(inc)/doscntry.inc $(inc)/buffer.inc
	dosemu -t --Fdrive_c ../.. -E "src\domasm.bat src\dos $(subst /,\,$<) $(subst /,\,$@);"

OBJS = $(inc)/nibdos.obj $(inc)/const2.obj $(inc)/msdata.obj \
       $(inc)/mstable.obj msdisp.obj mscode.obj $(inc)/msdosme.obj time.obj \
       getset.obj parse.obj misc.obj misc2.obj crit.obj cpmio.obj cpmio2.obj \
       fcbio.obj fcbio2.obj search.obj path.obj ioctl.obj delete.obj \
       rename.obj finfo.obj dup.obj create.obj open.obj dinfo.obj \
       isearch.obj abort.obj close.obj dircall.obj disk.obj disk2.obj \
       disk3.obj dir.obj dir2.obj dev.obj mknode.obj rom.obj fcb.obj \
       msctrlc.obj fat.obj buf.obj proc.obj alloc.obj srvcall.obj util.obj \
       handle.obj macro.obj macro2.obj file.obj lock.obj share.obj \
       extattr.obj ifs.obj

msdos.sys: msdos.cl1 $(OBJS)
	dosemu -t --Fdrive_c ../.. -E "src\dolink src\dos @msdos.lnk"
#	echo 'system dos' >resp.txt
#	echo 'option map=msdos.map' >>resp.txt
#	echo 'option nocaseexact' >>resp.txt
#	echo 'name msdos.exe' >>resp.txt
#	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
#	wlink @resp.txt
	exe2bin -q msdos.exe msdos.sys
	rm msdos.exe

clean:
	rm -f *.obj
	rm -f msdos.cl1
	rm -f msdos.cl3
	rm -f msdos.sys
	rm -f msdos.map
	rm -f resp.txt
