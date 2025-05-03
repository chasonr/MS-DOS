;********************************************************************************
; File: S_DISPLY.ASM
;
; This module contains a subroutine for setting the mode of the display to
; 80X25 text mode.
;
; If ANSI.SYS is loaded, then the calls to change the mode go through it,
; otherwise standard BIOS calls are performed.
;
; If ANSI.SYS is to be used, then a version dated July 15, 1987 or later must
; be used.
;
;********************************************************************************
;RLC .ALPHA						 ;AN000;

DATA	 SEGMENT   BYTE PUBLIC 'DATA'            ;AN000;


; Buffer for IOCTL calls
BUFFER	 LABEL	   BYTE 			 ;AN000;
	      DB	0			 ;AN000; INFO LEVEL
	      DB	0			 ;AN000; RESERVED
	      DW	14			 ;AN000; SIZE
FLAGS	      DW	0			 ;AN000;
D_MODE	      DB	0			 ;AN000; 1 = TEXT, 2 = APA
	      DB	0			 ;AN000; RESERVED
COLORS	      DW	0			 ;AN000;
B_WIDTH       DW	0			 ;AN000; PELS ==> -1 FOR TEXT
B_LENGTH      DW	0			 ;AN000; PELS ==> -1 FOR TEXT
COLS	      DW	0			 ;AN000;
ROWS	      DW	0			 ;AN000;

DATA	 ENDS					 ;AN000;

CODE_FAR SEGMENT BYTE PUBLIC 'CODE'              ;AN000;

    ASSUME    CS:CODE_FAR, DS:DATA		 ;AN000;

;********************************************************************************
; SET_DISPLAY_MODE_ROUTINE: Set the display mode to 80X25 text mode.
;
; INPUT:
;    None.
;
; OUTPUT:
;    If CY = 1, then an error was encountered making a IOCTL call.
;    If CY = 0, there were no errors.
;
; Operation: If ANSY.SYS is loaded, then the mode is set by calls to it,
;    otherwise BIOS calls are used.
;
;********************************************************************************
PUBLIC	 SET_DISPLAY_MODE_ROUTINE		 ;AN000;
SET_DISPLAY_MODE_ROUTINE     PROC FAR		 ;AN000;

    ;**********************************************************************
    ; See if ANSI.SYS is loaded
    ;**********************************************************************
    MOV  AX, 1A00H				 ;AC086;SEH changed from 1600h to avoid MICROSOFT collision ;AN000; Fn. for determining ANSI.SYS state
    INT  2FH					 ;AN000; Returns AL = 0FFh if it is loaded
    cmp AL,0FFH					 ;AN000; Is it loaded?
    je have_ansi_sys
	MOV  AH, 15				 ;AN000; No! Fn. number for getting the current video state
	INT  10H				 ;AN000; Get the video state
	cmp AL,07H				 ;AN000; If in monochrome mode,
	je @F
	cmp AL,0FH				 ;AN000; or monochrome graphics mode,
	jne else_l_1
	@@:
	     MOV  AX, 07H			 ;AN000; Set monochrome mode
	jmp short endif_l_1
	else_l_1:				 ;AN000; Otherwise...
	     MOV  AX, 03H			 ;AN000; Set mode 3: 80 column, color enabled
	endif_l_1:				 ;AN000;
	INT  10H				 ;AN000; Set the mode
    jmp short done
    have_ansi_sys:				 ;AN000;
	 MOV  AX, 440CH 			 ;AN000; Get the info from ANSI.
	 MOV  BX, 0				 ;AN000;
	 MOV  CX, 037FH 			 ;AN000;
	 MOV  DX, OFFSET BUFFER 		 ;AN000;
	 INT  21H				 ;AN000;
	 jnc @F					 ;AN000; Was there an error?
	      JMP  ERROR_SETTING		 ;AN000; Yes! Exit the subroutine.
	 @@:	 				 ;AN000;
	 MOV  D_MODE, 1 			 ;AN000; Set to text mode
	 MOV  B_WIDTH, -1			 ;AN000; -1 for text mode
	 MOV  B_LENGTH, -1			 ;AN000; -1 for text mode
	 MOV  COLS, 80				 ;AN000; Number of columns
	 MOV  ROWS, 25				 ;AN000; Number of rows
	 cmp COLORS,0				 ;AN000; If colors = 0, monochrome
	 je @F
	      MOV  COLORS, 16			 ;AN000; Otherwise set 16 color mode
	 @@: 					 ;AN000;
	 MOV  AX, 440CH 			 ;AN000; Set the new mode
	 MOV  BX, 0				 ;AN000;
	 MOV  CX, 035FH 			 ;AN000;
	 MOV  DX, OFFSET BUFFER 		 ;AN000;
	 INT  21H				 ;AN000;
	 jnc @F					 ;AN000; Was there en error?
	      JMP  ERROR_SETTING		 ;AN000; Yes! Exit the subroutine
	 @@: 					 ;AN000;
	 CLC					 ;AN000; Indicate there were no errors
    done:					 ;AN000;
    JMP  EXIT_SET				 ;AN000;
ERROR_SETTING:					 ;AN000;
    STC 					 ;AN000; Indicate that there were errors
EXIT_SET:					 ;AN000;
    RET 					 ;AN000;

SET_DISPLAY_MODE_ROUTINE     ENDP		 ;AN000;


CODE_FAR ENDS					 ;AN000;

END						 ;AN000;
