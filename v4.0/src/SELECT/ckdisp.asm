;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;RLC .ALPHA					;AN000;
					;
	PUBLIC	MONO, CGA, EGA, LCD	;AN000;
	PUBLIC	 ACTIVE, ALTERNATE	;AN000;
					;
	EXTRN  IN_CURNOR:WORD		;AN000;JW
					;
DATA	SEGMENT BYTE PUBLIC 'DATA'      ;AN000;
MONO	EQU    1			;AN000;
CGA	EQU    2			;AN000;
EGA	EQU    3			;AN000;
LCD	EQU    4			;AN000;
					;
READ_DISPLAY   EQU   1AH		;AN000;
ALT_SELECT     EQU   12H		;AN000;
EGA_INFO       EQU   10H		;AN000;
MONOCHROME     EQU   1			;AN000;
BASE_COLOR     EQU   0B800H		;AN000;
BASE_MONO      EQU   0B000H		;AN000;
GET_SYS_ID     EQU   0C0H		;AN000;
LCD_MODEL      EQU   0F9H		;AN000;
GET_STATUS     EQU   43H		;AN000;
ON	       EQU   1			;AN000;
					;
SYSTEM_ID      STRUC			;AN000;
	       DW    ?			;AN000;
MODEL_BYTE     DB    ?			;AN000;
SYSTEM_ID      ENDS			;AN000;
					;
ACTIVE	   DB	0			;AN000;
ALTERNATE  DB	0			;AN000;
					;
DATA	       ENDS			;AN000;DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SERVICE SEGMENT PARA PUBLIC 'SERVICE'        ;AN000;segment for far routine
	ASSUME	CS:SERVICE,DS:DATA	     ;AN000;
					     ;
	PUBLIC	VIDEO_CHECK		     ;AN000;
VIDEO_CHECK PROC   FAR			     ;AN000;
	    PUSH   AX			     ;AN000;
	    PUSH   BX			     ;AN000; save all registers
	    PUSH   CX			     ;AN000;
	    PUSH   DX			     ;AN000;
	    PUSH   SI			     ;AN000;
	    PUSH   DI			     ;AN000;
	    PUSH   ES			     ;AN000;
	    XOR    AL,AL		     ;AN000;
	    MOV    AH,READ_DISPLAY	     ;AN000; check for VGA first.
	    INT    10H			     ;AN000;
	    cmp AL,READ_DISPLAY		     ;AN000; VGA present?
	    jne else_l_4
					     ;AN000; yes....BL contains active..
	      cmp BL,MONO		     ;AN000; display code.
	      jne select_l_1_1
		MOV    ACTIVE,MONO	     ;AN000;
	      jmp endselect_l_1
	      select_l_1_1:
	      cmp BL,CGA	 	     ;AN000;
	      jne select_l_1_2
		MOV    ACTIVE,CGA	     ;AN000;
	      jmp endselect_l_1
	      select_l_1_2:
	      cmp BL,CGA		     ;AN000;
	      jbe endselect_l_1
		MOV    ACTIVE,EGA	     ;AN000;
	      endselect_l_1:		     ;AN000;
					     ;AN000; ...and BH contains alternate..
	      cmp BH,MONO		     ;AN000; display code.
	      jne select_l_2_1
		MOV    ALTERNATE,MONO	     ;AN000;
	      jmp endif_l_4
	      select_l_2_1:
	      cmp BH,CGA	 	     ;AN000;
	      jne select_l_2_2
		MOV    ALTERNATE,CGA	     ;AN000;
	      jmp endif_l_4
	      select_l_2_2:
	      cmp BH,CGA		     ;AN000;
	      jbe endif_l_4
		MOV    ALTERNATE,EGA	     ;AN000;
	      endselect_l_2:		     ;AN000;
	    jmp short endif_l_4
	    else_l_4:			     ;AN000; VGA not there..check for EGA.
	      MOV    AH,ALT_SELECT	     ;AN000;
	      MOV    BL,EGA_INFO	     ;AN000;
	      INT    10H		     ;AN000;
	      cmp BL,EGA_INFO		     ;AN000; EGA present?
	      je else_l_3
		MOV    ACTIVE,EGA	     ;AN000; yes....set as active.
		cmp BH,MONOCHROME	     ;AN000; if monochrome attached to EGA then..
		jne else_l_1
		  MOV	 AX,BASE_COLOR	     ;AN000; check if CGA is an alternate.
		  CALL	 CHECK_BUFF	     ;AN000;
		  cmp AH,AL		     ;AN000; CGA there?
		  jne endif_l_3
		    MOV    ALTERNATE,CGA     ;AN000; yes....alternate display.
		jmp short endif_l_3	     ;AN000;
		else_l_1:		     ;AN000; if color attached to EGA then...
		  MOV	 AX,BASE_MONO	     ;AN000; check if monochrome is an alternate.
		  CALL	 CHECK_BUFF	     ;AN000;
		  cmp AH,AL		     ;AN000; MONO there?
		  jne endif_l_3
		    MOV    ALTERNATE,MONO    ;AN000; yes....alternate display.
		endif_l_1:		     ;AN000;
	      jmp short endif_l_3	     ;AN000;
	      else_l_3:			     ;AN000; EGA not present so...
		MOV    AH,GET_SYS_ID	     ;AN000; check for LCD.
		INT    15H		     ;AN000;
		cmp ES:[BX].MODEL_BYTE,LCD_MODEL ;AN000; if model byte says convertible..
		jne else_l_2
		MOV    AH,GET_STATUS	     ;AN000; and..
		INT    15H		     ;AN000;
		test AL,ON		     ;AN000; if LCD screen attached..then
		jnz else_l_2
		  MOV	 ACTIVE,LCD	     ;AN000; set LCD as active display.
		jmp short endif_l_2
		else_l_2:		     ;AN000;
		  MOV	 AX,BASE_MONO	     ;AN000; not LCD...check for..
		  CALL	 CHECK_BUFF	     ;AN000; MONO....
		  cmp AH,AL		     ;AN000;
		  jne @F
		    MOV    ACTIVE,MONO	     ;AN000; MONO found...set as active.
		    MOV    IN_CURNOR,0B0CH   ;AN000;JW set mono cursor size
		  @@:			     ;AN000;
		  MOV	 AX,BASE_COLOR	     ;AN000; ..and check for color.
		  CALL	 CHECK_BUFF	     ;AN000;
		  cmp AH,AL		     ;AN000;
		  jne @F
		    MOV    ALTERNATE,CGA     ;AN000; color found...set CGA as alternate.
		  @@:			     ;AN000;
		endif_l_2:		     ;AN000;
	      endif_l_3:		     ;AN000;
	    endif_l_4:			     ;AN000;
	    POP    ES			     ;AN000;
	    POP    DI			     ;AN000; restore registers.
	    POP    SI			     ;AN000;
	    POP    DX			     ;AN000;
	    POP    CX			     ;AN000;
	    POP    BX			     ;AN000;
	    POP    AX			     ;AN000;
	    RET 			     ;AN000;
VIDEO_CHECK ENDP			     ;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHECK_BUFF  PROC   NEAR 	;AN000; write to video buffer to see if it is present
	    PUSH   DS		;AN000;
	    MOV    DS,AX	;AN000; load DS with address of buffer
	    MOV    CH,DS:0	;AN000; save buffer information (if present)
	    MOV    AL,55H	;AN000; prepare to write sample data
	    MOV    DS:0,AL	;AN000; write to buffer
	    PUSH   BX		;AN000; terminate the bus so that lines..
	    POP    BX		;AN000; are reset
	    MOV    AH,DS:0	;AN000; bring sample data back...
	    MOV    DS:0,CH	;AN000; repair damage to buffer
	    POP    DS		;AN000;
	    RET 		;AN000;
CHECK_BUFF  ENDP		;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SERVICE     ENDS		;AN000;
	    END 		;AN000;
