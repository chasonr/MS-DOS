#************************** makefile for cmd/append ***************************

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

all: command.com

DOSSYM_INC = $(inc)/dossym.inc $(inc)/arena.inc $(inc)/bpb.inc \
             $(inc)/buffer.inc $(inc)/cpmfcb.inc $(inc)/curdir.inc \
             $(inc)/dbcs.sw $(inc)/dirent.inc $(inc)/dosmac.inc \
             $(inc)/dpb.inc $(inc)/error.inc $(inc)/exe.inc \
             $(inc)/filemode.inc $(inc)/find.inc $(inc)/intnat.inc \
             $(inc)/mi.inc $(inc)/mult.inc $(inc)/pdb.inc $(inc)/sf.inc \
             $(inc)/syscall.inc $(inc)/sysvar.inc $(inc)/vector.inc \
             $(inc)/versiona.inc $(inc)/version.inc

command.ctl command.cl1 command.cl2 command.cl3 command.cl4 command.cl5 command.cla command.clb command.clc command.cld command.cle command.clf: \
        COMMAND.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\command $(subst /,\,$<) $(country)"

command1.obj:  command1.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comsw.asm comequ.asm resmsg.equ \
    envdata.asm

command2.obj:  command2.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comsw.asm comequ.asm resmsg.equ \
    envdata.asm

copy.obj:  copy.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm

copypr1.obj:  copypr1.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm

copypr2.obj:  copypr2.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm

cparse.obj:  cparse.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm

init.obj:  init.asm command.ctl $(DOSSYM_INC) $(inc)/devsym.inc \
    comsw.asm comseg.asm comequ.asm resmsg.equ $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm

iparse.obj:  iparse.asm comseg.asm $(inc)/parse.asm $(inc)/psdata.inc

parse2.obj:  parse2.asm $(DOSSYM_INC) $(inc)/devsym.inc comsw.asm \
    comseg.asm comequ.asm

path1.obj:  path1.asm $(DOSSYM_INC) $(inc)/devsym.inc comsw.asm \
    comseg.asm comequ.asm

path2.obj:  path2.asm $(DOSSYM_INC) $(inc)/devsym.inc comsw.asm \
    comseg.asm comequ.asm

rdata.obj:  rdata.asm command.ctl command.cla \
    command.clc command.cld command.cle comsw.asm comseg.asm $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm

rucode.obj:  rucode.asm command.ctl $(DOSSYM_INC) $(inc)/devsym.inc \
    $(inc)/doscntry.inc resmsg.equ $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm comsw.asm comseg.asm comequ.asm

tbatch.obj:  tbatch.asm comsw.asm $(DOSSYM_INC) $(inc)/doscntry.inc \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tbatch2.obj:  tbatch2.asm comsw.asm $(DOSSYM_INC) $(inc)/doscntry.inc \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tcmd1a.obj:  tcmd1a.asm comsw.asm $(DOSSYM_INC) $(inc)/ioctl.inc \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tcmd1b.obj:  tcmd1b.asm comsw.asm $(DOSSYM_INC) $(inc)/ioctl.inc \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm $(inc)/ea.inc

tcmd2a.obj:  tcmd2a.asm comsw.asm $(DOSSYM_INC) $(inc)/ioctl.inc \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tcmd2b.obj:  tcmd2b.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tcode.obj:  tcode.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm \
    $(inc)/mshalo.asm

tdata.obj:  tdata.asm command.ctl command.cl1 command.cl2 command.clf \
    comsw.asm comseg.asm $(inc)/curdir.inc \
    $(inc)/error.inc ifequ.asm comequ.asm $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm tranmsg.asm  $(inc)/ea.inc

tenv.obj:  tenv.asm comsw.asm $(DOSSYM_INC) $(inc)/devsym.inc \
    comseg.asm comequ.asm ifequ.asm $(inc)/doscntry.inc

tenv2.obj:  tenv2.asm comsw.asm $(DOSSYM_INC) $(inc)/devsym.inc \
    comseg.asm comequ.asm ifequ.asm

tfor.obj:  tfor.asm comsw.asm $(DOSSYM_INC) $(inc)/devsym.inc \
    comseg.asm comequ.asm ifequ.asm fordata.asm

tmisc1.obj:  tmisc1.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tmisc2.obj:  tmisc2.asm comsw.asm $(DOSSYM_INC) $(inc)/ioctl.inc \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tparse.obj:  tparse.asm comseg.asm $(inc)/parse.asm $(inc)/psdata.inc

tpipe.obj:  tpipe.asm comsw.asm $(DOSSYM_INC) \
    $(inc)/devsym.inc comseg.asm comequ.asm ifequ.asm

tprintf.obj:  tprintf.asm command.ctl comsw.asm $(inc)/dosmac.inc \
    comseg.asm comequ.asm $(inc)/sysmsg.inc $(inc)/msgserv.asm

tspc.obj:  tspc.asm comsw.asm $(DOSSYM_INC) comequ.asm \
    ifequ.asm comseg.asm  $(inc)/ea.inc

tucode.obj:  tucode.asm $(inc)/dosmac.inc $(DOSSYM_INC) \
    comsw.asm comseg.asm comequ.asm ifequ.asm

uinit.obj:  uinit.asm command.ctl command.clb comsw.asm comseg.asm ifequ.asm \
    $(inc)/sysmsg.inc $(inc)/msgserv.asm

OBJS = command1.obj command2.obj rucode.obj rdata.obj init.obj iparse.obj \
       uinit.obj tcode.obj tbatch.obj tbatch2.obj tfor.obj tcmd1a.obj \
       tcmd1b.obj tcmd2a.obj tcmd2b.obj tenv.obj tenv2.obj tmisc1.obj \
       tmisc2.obj tpipe.obj parse2.obj path1.obj path2.obj tucode.obj \
       copy.obj copypr1.obj copypr2.obj cparse.obj tparse.obj tprintf.obj \
       tdata.obj tspc.obj

command.com:  $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=command.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name command.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q command.exe command.com
	rm command.exe

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f command.com
	rm -f command.cl[1-4a-f]
	rm -f command.ctl
	rm -f command.map
	rm -f resp.txt
