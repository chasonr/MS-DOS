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

all: tree.com

tree.ctl tree.cl1 tree.cl2 tree.cla: TREE.SKL \
    $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\tree $(subst /,\,$<) $(country)"

tree.obj: TREE.ASM \
    TREEQU.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\tree $(subst /,\,$<) $(subst /,\,$@)"

treesysp.obj: TREESYSP.ASM \
    $(inc)/psdata.inc \
    $(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\tree $(subst /,\,$<) $(subst /,\,$@)"

treesysm.obj: TREESYSM.ASM \
    $(inc)/copyrigh.inc \
    $(inc)/versiona.inc \
    $(inc)/sysmsg.inc \
    $(inc)/msgserv.asm \
    tree.ctl \
    tree.cl1 \
    tree.cl2 \
    tree.cla \
    $(inc)/msghan.inc \
    TREEMS.INC
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\tree $(subst /,\,$<) $(subst /,\,$@)"

treepar.obj: TREEPAR.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\tree $(subst /,\,$<) $(subst /,\,$@)"

OBJS = tree.obj treepar.obj treesysp.obj treesysm.obj

tree.com: $(OBJS) TREE.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\cmd\tree @tree.lnk"
	exe2bin -q tree.exe tree.com
	rm tree.exe

clean:
	rm -f *.obj
	rm -f tree.com
	rm -f tree.cl[12a]
	rm -f tree.ctl
	rm -f resp.txt
