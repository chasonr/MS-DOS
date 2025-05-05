# Makefile for bldtools

all : com-tail.bin

############################# Build com-tail.bin #############################

com-tail.bin : com-tail.asm
	jwasm -q -bin -Fo$@ $<

##############################################################################

clean:
	rm -f com-tail.bin
