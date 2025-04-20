#*************************** Makefile for Bios ************************

msg	=../../MSG
dos	=../../DOS
inc	=../../INC

#
###################### Dependencies begin here #########################
#

all:           keyboard.sys

kdfnow.obj:    KDFNOW.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdffr120.obj:  KDFFR120.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdffr189.obj:  KDFFR189.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfeof.obj:    KDFEOF.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfuk166.obj:  KDFUK166.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfuk168.obj:  KDFUK168.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfit141.obj:  KDFIT141.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfit142.obj:  KDFIT142.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfge.obj:     KDFGE.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfsp.obj:     KDFSP.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfnl.obj:     KDFNL.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfno.obj:     KDFNO.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfdk.obj:     KDFDK.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfsg.obj:     KDFSG.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfsf.obj:     KDFSF.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfpo.obj:     KDFPO.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfbe.obj:     KDFBE.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfcf.obj:     KDFCF.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfla.obj:     KDFLA.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

kdfsv.obj:     KDFSV.ASM KEYBMAC.INC KEYBSHAR.INC $(inc)/POSTEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\keyboard $(subst /,\,$<) $(subst /,\,$@)"

OBJS = kdfnow.obj kdfsp.obj kdfpo.obj kdffr120.obj kdffr189.obj kdfdk.obj \
       kdfsg.obj kdfge.obj kdfit141.obj kdfit142.obj kdfuk166.obj \
       kdfuk168.obj kdfsf.obj kdfbe.obj kdfnl.obj kdfno.obj kdfcf.obj \
       kdfsv.obj kdfla.obj kdfeof.obj

keyboard.sys: $(OBJS)
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\keyboard @keyboard.lnk"
	exe2bin -q keyboard.exe keyboard.sys
	rm keyboard.exe

clean:
	rm -f *.obj
	rm -f keyboard.sys
