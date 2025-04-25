	INCLUDE syshdr.inc

; include SYSMSG.INC

.xlist
.xcref

	include sysmsg.inc		;				       ;AN000;

.cref
.list

	MSG_UTILNAME <sys>		;				       ;AN000;

CODE	SEGMENT PARA PUBLIC

ASSUME	CS:CODE,DS:nothing,ES:nothing

	PUBLIC	SYSDISPMSG, SYSLOADMSG, SYSPARSE
	PUBLIC	Data_Space

;;dcl	MSG_SERVICES <MSGDATA>		;				      ;AN000;

;  MSG_SERVICES <sys.cl1,sys.cl2,sys.cla,sys.clb,sys.clc,sys.cld>		;AN000;

.xlist
.xcref

	MSG_SERVICES <sys.cl1,sys.cl2,sys.cla,sys.clb,sys.clc,sys.cld> ;       ;AN000;

.cref
.list

;  MSG_SERVICES <LOADmsg,DISPLAYmsg,INPUTmsg,CHARmsg,NOVERCHECKmsg>

.xlist
.xcref

	MSG_SERVICES <LOADmsg,DISPLAYmsg,INPUTmsg,CHARmsg,NOVERCHECKmsg> ;		     ;AN000;

.cref
.list


false	=	0			;				       ;AN000;

DateSW	equ	false			;				       ;AN000;
TimeSW	equ	false			;				       ;AN000;
CmpxSW	equ	false			;				       ;AN000;
KeySW	equ	false			;				       ;AN000;
QusSW	equ	false			;				       ;AN000;
Val1SW	equ	false			;				       ;AN000;
Val2SW	equ	false			;				       ;AN000;
Val3SW	equ	false			;				       ;AN000;
SwSW	equ	false			;				       ;AN000;
NumSW	equ	false			;				       ;AN000;
CAPSW	equ	false			; Perform CAPS if specified	       ;AN000;


ASSUME	CS:CODE,DS:CODE,ES:nothing

; include parse.asm

;;xlist
;xcref

include parse.asm			;				       ;AN000;

.cref
.list

Data_Space LABEL BYTE			;				       ;AN000;



CODE	Ends

include msgdcl.inc

	End
