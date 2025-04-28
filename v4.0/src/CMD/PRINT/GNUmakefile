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

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: print.com

PRIDEFS_INC = pridefs.inc print.ctl $(inc)/sysvar.inc $(inc)/devsym.inc \
              $(inc)/syscall.inc $(inc)/error.inc $(inc)/find.inc \
              $(inc)/dpl.asm $(inc)/pdb.inc $(inc)/syscall.inc \
              $(inc)/mi.inc $(inc)/sysmsg.inc $(inc)/versiona.inc \
              $(inc)/version.inc $(inc)/versiona.inc $(inc)/msgserv.asm \
              $(inc)/copyrigh.inc

print.ctl print.cl1 print.cl2 print.cla print.clb print.clc print.cld: \
        PRINT.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\print $(subst /,\,$<) $(country)"

print_r.obj: print_r.asm $(PRIDEFS_INC) $(inc)/ea.inc $(inc)/copyrigh.inc

print_rm.obj: print_rm.asm $(PRIDEFS_INC)

print_t.obj: print_t.asm $(PRIDEFS_INC)

print_tm.obj: print_tm.asm $(PRIDEFS_INC) $(inc)/parse.asm \
    print.cl1 print.cl2 print.cla print.clb print.clc print.cld

OBJS = print_rm.obj print_r.obj print_t.obj print_tm.obj

print.com: $(OBJS) print.cla
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option stack=200' >>resp.txt
	echo 'option map=print.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name print.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	dosemu -t --Fdrive_c ../../.. -E "src\tools\convert src\cmd\print\print.exe"

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f print.com
	rm -f print.exe
	rm -f print.cl[12a-d]
	rm -f print.ctl
	rm -f print.map
	rm -f resp.txt
