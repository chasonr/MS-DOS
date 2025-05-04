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

.SUFFIXES: .asm .obj

AS = jwasm
AFLAGS = -q -Zm -Zg -I$(inc) -Fl

.asm.obj:
	$(AS) $(AFLAGS) -Fo$@ $<

all: driver.sys

driver.ctl driver.cl1 driver.cl2 driver.cla: driver.skl  $(msg)/$(COUNTRY).MSG
	../../bldtools/buildmsg.rb $(msg)/$(COUNTRY).MSG driver.skl

driver.obj: driver.asm  $(inc)/msbds.inc $(inc)/versiona.inc \
            $(inc)/parse.asm $(inc)/psdata.inc \
            $(inc)/sysmsg.inc $(inc)/msgserv.asm $(inc)/copyrigh.inc \
            driver.ctl driver.cl1 driver.cl2 driver.cla

OBJS = driver.obj

driver.sys: $(OBJS) DRIVER.LNK
	echo 'system dos' >resp.txt
	echo 'option packcode=0' >>resp.txt
	echo 'option packdata=0' >>resp.txt
	echo 'option map=driver.map' >>resp.txt
	echo 'option nocaseexact' >>resp.txt
	echo 'name driver.exe' >>resp.txt
	for x in $(OBJS); do echo "file $$x" >>resp.txt; done
	wlink @resp.txt
	exe2bin -q driver.exe driver.sys

clean:
	rm -f *.obj
	rm -f *.err
	rm -f *.lst
	rm -f driver.sys
	rm -f driver.exe
	rm -f driver.map
	rm -f driver.cl[12a]
	rm -f driver.ctl
	rm -f resp.txt
