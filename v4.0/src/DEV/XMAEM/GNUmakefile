#************************ makefile for dev/xmaem************************

msg	=../../MESSAGES
dos	=../../DOS
inc	=../../INC
hinc	=../../H

country = usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: xmaem.sys

xmaem.cl1: XMAEM.SKL $(msg)/$(COUNTRY).MSG
	dosemu -t --Fdrive_c ../../.. -E "src\domsg1.bat src\dev\xmaem $(subst /,\,$<) $(country)"

indeini.obj:   INDEINI.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indeemu.obj:   INDEEMU.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indeexc.obj:   INDEEXC.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indexma.obj:   INDEXMA.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indedma.obj:   INDEDMA.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indeidt.obj:   INDEIDT.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indegdt.obj:   INDEGDT.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indei15.obj:   INDEI15.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indemsg.obj:   INDEMSG.ASM xmaem.cl1
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

indepat.obj:   INDEPAT.ASM
	dosemu -t --Fdrive_c ../../.. -E "src\domasm.bat src\dev\xmaem $(subst /,\,$<) $(subst /,\,$@)"

OBJS = indeini.obj indeexc.obj indeemu.obj indexma.obj indedma.obj \
       indei15.obj indeidt.obj indegdt.obj indemsg.obj indepat.obj

xmaem.sys:  $(OBJS) XMAEM.LNK
	dosemu -t --Fdrive_c ../../.. -E "src\dolink src\dev\xmaem @xmaem.lnk"

clean:
	rm -f *.obj
	rm -f xmaem.cl1
	rm -f xmaem.sys
	rm -f resp.txt
