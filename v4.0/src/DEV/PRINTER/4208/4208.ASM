;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;    DESCRIPTION :  Code Page Switching 4208 Printer Font File
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ESC1	EQU	01BH			;
					;
CSEG	SEGMENT 			;
	ASSUME CS:CSEG,DS:CSEG		;
BEGIN:	ORG    0			;
					;
FNTHEAD:DB     0FFH,"FONT   "           ; FILE TAG
	DB     8 DUP(0) 		; RESERVED
	DW     1			; CNT OF POINTERS IN HEADER
	DB     1			; TYPE FOR INFO POINTER
	DW     OFFSET INFO,0		; POINTER TO INFO IN FILE
					;
info :	DW	9			; COUNT OF ENTRIES
					;
QUI437: DW     LEN_437			; SIZE OF ENTRY HEADER
	DW     QUI862,0 		; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     437			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA437,0 	; POINTER TO FONTS
LEN_437 EQU    ($-QUI437)-2		;
					;
QUI862: DW     LEN_862			; SIZE OF ENTRY HEADER
	DW     QUI864,0 		; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     862			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA862,0 	; POINTER TO FONTS
LEN_862 EQU    ($-QUI862)-2		;
					;
QUI864: DW     LEN_864			; SIZE OF ENTRY HEADER
	DW     QUI850,0 		; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     864			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA864,0 	; POINTER TO FONTS
LEN_864 EQU    ($-QUI864)-2		;
					;
QUI850: DW     LEN_850			; SIZE OF ENTRY HEADER
	DW     QUI851,0 		; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     850			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA850,0 	; POINTER TO FONTS
LEN_850 EQU    ($-QUI850)-2		;
					;
QUI851: DW     LEN_851			; SIZE OF ENTRY HEADER
	DW     QUI853,0 		; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     851			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA851,0 	; POINTER TO FONTS
LEN_851 EQU    ($-QUI851)-2		;
					;
QUI853: DW     LEN_853			; SIZE OF ENTRY HEADER
	DW     QUI855,0 		; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     853			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA853,0 	; POINTER TO FONTS
LEN_853 EQU    ($-QUI853)-2		;
					;
QUI855: DW     LEN_855			; SIZE OF ENTRY HEADER
	DW     QUI863,0			; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     855			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA855,0 	; POINTER TO FONTS
LEN_855 EQU    ($-QUI855)-2		;
					;
QUI863: DW     LEN_863			; SIZE OF ENTRY HEADER
	DW     0,0			; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     863			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     OFFSET DATA863,0 	; POINTER TO FONTS
LEN_863 EQU    ($-QUI863)-2		;
					;
QUI000: DW     LEN_000			; SIZE OF ENTRY HEADER
	DW     0,0			; POINTER TO NEXT HEADER
	DW     2			; DEVICE TYPE
	DB     "4208    "               ; DEVICE SUBTYPE ID
	DW     000			; CODE PAGE ID
	DW     3 DUP(0) 		; RESERVED
	DW     0,0 			; POINTER TO FONTS
LEN_000 EQU    ($-QUI000)-2		;
					;
DATA437:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,2,0,0,0,0,0,0,0   ; select code page ******
	dB     ESC1,"6"                  ;
					;
DATA862:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;
					;
DATA864:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;
					;
DATA850:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;
					;
DATA851:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;
					;
DATA853:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;
					;
DATA855:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;

DATA863:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;

DATA000:DW     1			; CART/NON-CART
	DW     1			; # OF FONTS
	DW     16			; LENGTH OF DATA
	DW     2			; SELECTION TYPE
	DW     12			; SELECTION length
	DB     ESC1,73,14,ESC1,73,7,ESC1,73,6,00 ; select code page ******
	dB     ESC1,"6"                  ;

    db 0Ah,0Dh
    db "The IBM Personal Computer Printer Code Page Driver",0Ah,0Dh
    db "Version 3.30 (C) Copyright IBM Corp 1987",0Ah,0Dh
    db "Licensed Material - Program Property of IBM",1Ah,1Ah
    db "@@@### DOS 3.30 Driver DRV05H, 10/21/86",0Dh,0Ah,1Ah,0
    db 61 dup (' ')

CSEG	ENDS				;
	END BEGIN			;
