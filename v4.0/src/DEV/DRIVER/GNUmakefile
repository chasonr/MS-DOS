#************************ makefile for dev/driver ************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: driver.sys

driver.ctl driver.cl1 driver.cl2 driver.cla: DRIVER.SKL  $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg2.bat src\dev\driver $(subst /,\,$<) $(country)"

driver.obj: DRIVER.ASM  $(inc)/MSBDS.INC $(inc)/VERSIONA.INC \
            $(inc)/PARSE.ASM $(inc)/PSDATA.INC \
            driver.ctl $(inc)/SYSMSG.INC $(inc)/MSGSERV.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\driver $(subst /,\,$<) $(subst /,\,$@)"

OBJS = driver.obj

driver.sys: $(OBJS) DRIVER.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\driver @driver.lnk"
	exe2bin -q driver.exe driver.sys
	rm driver.exe

clean:
	rm -f *.obj
	rm -f driver.sys
	rm -f driver.cl[12a]
	rm -f driver.ctl
	rm -f resp.txt
