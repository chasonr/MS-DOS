#************************* makefile for messages **************************

country    =usa-ms

COUNTRY = $(shell echo $(country) | tr '[a-z]' '[A-Z]')

#
#######################	dependencies begin here. #########################
#

all: $(country).idx

$(country).idx: $(COUNTRY).MSG
	dosemu -t --Fdrive_c ../.. -E "\src\tools\buildidx \src\messages\$(COUNTRY).MSG"
	mv $(country).msg $(COUNTRY).MSG

clean:
	@rm -f usa-ms.idx
