#************************ makefile for cmd/share *************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: share.exe

share.ctl share.cl1 share.cl2 share.cla: SHARE.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\share $(subst /,\,$<) $(country)"

$(inc)/DOSSYM.INC: $(inc)/DOSMAC.INC $(inc)/BPB.INC $(inc)/CURDIR.INC \
                   $(inc)/BUFFER.INC $(inc)/SYSVAR.INC $(inc)/VECTOR.INC \
                   $(inc)/MULT.INC $(inc)/DIRENT.INC $(inc)/DPB.INC \
                   $(inc)/CPMFCB.INC $(inc)/FIND.INC $(inc)/PDB.INC \
                   $(inc)/EXE.INC $(inc)/SF.INC $(inc)/ARENA.INC \
                   $(inc)/INTNAT.INC $(inc)/MI.INC $(inc)/FILEMODE.INC \
                   $(inc)/ERROR.INC $(inc)/SYSCALL.INC
	              	   echo " touch DOSSYM.INC "

gshare.obj: GSHARE.ASM $(inc)/DOSSYM.INC $(inc)/MFT.INC \
            $(inc)/BUGTYP.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\share $(subst /,\,$<) $(subst /,\,$@)"

gshare2.obj: GSHARE2.ASM $(inc)/DOSSYM.INC $(inc)/DOSSEG.ASM $(inc)/MFT.INC \
             $(inc)/BUGTYP.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\share $(subst /,\,$<) $(subst /,\,$@)"

sharesr.obj: SHARESR.ASM $(inc)/PARSE.ASM $(inc)/PSDATA.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\share $(subst /,\,$<) $(subst /,\,$@)"

sharelnk.obj: SHARELNK.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\share $(subst /,\,$<) $(subst /,\,$@)"

$(inc)/nibdos.obj:
	$(MAKE) -C $(inc) nibdos.obj

$(inc)/const2.obj:
	$(MAKE) -C $(inc) const2.obj

$(inc)/msdata.obj:
	$(MAKE) -C $(inc) msdata.obj

$(inc)/msdosme.obj:
	$(MAKE) -C $(inc) msdosme.obj

OBJS = gshare.obj gshare2.obj sharesr.obj sharelnk.obj $(inc)/nibdos.obj \
       $(inc)/const2.obj $(inc)/msdata.obj $(inc)/msdosme.obj

share.exe: share.ctl $(OBJS) SHARE.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\share @share.lnk"

clean:
	rm -f *.obj
	rm -f share.cl[12a]
	rm -f share.ctl
	rm -f share.exe
	rm -f share.map
	rm -f resp.txt
