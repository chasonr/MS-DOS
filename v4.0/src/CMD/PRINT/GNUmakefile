#************************** makefile for cmd/... ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: print.com

print.ctl print.cl1 print.cl2 print.cla print.clb print.clc print.cld: \
        PRINT.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\print $(subst /,\,$<) $(country)"

print_r.obj: PRINT_R.ASM \
    PRIDEFS.INC print.ctl \
    $(inc)/devsym.inc \
    $(inc)/syscall.inc \
    $(inc)/error.inc \
    $(inc)/sysvar.inc \
    $(inc)/find.inc \
    $(inc)/ea.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\print $(subst /,\,$<) $(subst /,\,$@)"

print_rm.obj: PRINT_RM.ASM \
    PRIDEFS.ASM print.ctl \
    $(inc)/parse.asm \
    $(inc)/psdata.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\print $(subst /,\,$<) $(subst /,\,$@)"

print_t.obj: PRINT_T.ASM \
    PRIDEFS.ASM \
    $(inc)/devsym.inc \
    $(inc)/syscall.inc \
    $(inc)/error.inc \
    $(inc)/sysvar.inc \
    $(inc)/find.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\print $(subst /,\,$<) $(subst /,\,$@)"

print_tm.obj: PRINT_TM.ASM \
    PRIDEFS.ASM print.ctl \
    $(inc)/parse.asm \
    $(inc)/psdata.inc \
    $(inc)/msgserv.asm \
    $(inc)/sysmsg.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\print $(subst /,\,$<) $(subst /,\,$@)"

OBJS = print_rm.obj print_r.obj print_t.obj print_tm.obj

print.com: $(OBJS) print.cla
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\print @print.lnk"
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\print\print.exe"
	rm print.exe

clean:
	rm -f *.obj
	rm -f print.com
	rm -f print.cl[12a-d]
	rm -f print.ctl
	rm -f print.map
