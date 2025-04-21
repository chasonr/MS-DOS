#************************** makefile for cmd/assign ***************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: assign.com

assign.ctl assign.cl1 assign.cl2 assign.cla: ASSIGN.SKL \
	$(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\cmd\assign $(subst /,\,$<) $(country)"

assgparm.obj: ASSGPARM.ASM \
	$(inc)/psdata.inc \
	$(inc)/parse.asm
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\assign $(subst /,\,$<) $(subst /,\,$@)"

assgmain.obj: ASSGMAIN.ASM \
	$(inc)/dosmac.inc \
	$(inc)/sysvar.inc \
	$(inc)/MULT.INC \
	$(inc)/pdb.inc \
	$(inc)/syscall.inc \
	$(inc)/MSGSERV.ASM \
	$(inc)/SYSMSG.INC \
	ASSGPARM.INC \
	ASSGMSG.INC \
	assign.ctl \
	assign.cla \
	assign.cl1 \
	assign.cl2 \
	$(inc)/curdir.inc
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\cmd\assign $(subst /,\,$<) $(subst /,\,$@)"

OBJS = assgmain.obj assgparm.obj
assign.com: $(OBJS)
	echo 'system dos' >resp.txt
	echo 'option map=assign.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name assign.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q assign.exe  assign.com
	rm assign.exe

clean:
	rm -f *.obj
	rm -f assign.com
	rm -f assign.cl[12a]
	rm -f assign.ctl
	rm -f assign.map
	rm -f resp.txt
