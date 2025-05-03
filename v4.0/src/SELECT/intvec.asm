;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;
;
;
;	Change History:
;
;
;	;AN000;   S.R.
;	;AN000;   D.T.
;	;AN001;   DCR219 
;	;AN002;   P1132 & P1136 
;	;AN003;   P1757 
;	;AN004;   P2683 - bad diskette in b:
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INCLUDE mac_equ.inc			;AN000;
INCLUDE panel.mac			;AN000;
INCLUDE macros.inc			;AN000;
INCLUDE macros8.inc			;AN000;
INCLUDE varstruc.inc			;AN000;
INCLUDE ext.inc 			;AN000;
INCLUDE pan-list.inc			;AN000;
INCLUDE casextrn.inc			;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					  ;
EXTRN HANDLE_PANEL_CALL2:FAR		  ;AN000;
EXTRN HANDLE_PANEL_CALL3:FAR		  ;AN111;JW
EXTRN FIND_FILE_ROUTINE:FAR		  ;AN000;
EXTRN DISPLAY_MESSAGE_ROUTINE:FAR	  ;AN000;DT
EXTRN BEEP_ROUTINE:FAR			  ;AN000;DT
					  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'        ;AN000;
NULl_DEVICE		DB	  'nul',0 ;AN000;
CON_DEVICE		DB	  'con',0 ;AN000;
SUB_PROGRAM		DB	  0	  ;AN000;
EXEC_ERR		DB	  0	  ;AN000;
	PUBLIC DSKCPY_WHICH,DSKCPY_PAN1,DSKCPY_PAN2;AN000;
	PUBLIC DSKCPY_PAN3,DSKCPY_OPTION,DSKCPY_SOURCE;AN000;
DSKCPY_WHICH		DB	  0	  ;AN000;DT
;DSKCPY_TO_A_720 EQU	0		  ;AN000;DT (MACROS8.INC for actual equates)
;DSKCPY_TO_A_360 EQU	1		  ;AN000;DT
;DSKCPY_TO_B	 EQU	2		  ;AN000;DT

DSKCPY_OPTION		DB	  0	  ;AN000;DT
;SOURCE1	 EQU	0		  ;AN000;DT
;NO_SOURCE1	 EQU	1		  ;AN000;DT

DSKCPY_SOURCE		DW	  0	  ;AN000;DT offset of filename to check for on diskette
DSKCPY_PAN1		DW	  0	  ;AN000;DT
DSKCPY_PAN2		DW	  0	  ;AN000;DT
DSKCPY_PAN3		DW	  0	  ;AN000;DT

	PUBLIC DSKCPY_ERR		  ;AN000;
DSKCPY_ERR		DB	  0	  ;AN000;
;DSKCPY_EXIT	 EQU	1

DATA	       ENDS			  ;AN000; DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	EXTRN	CHK_W_PROTECT_FLAG:BYTE   ;AN000;
	EXTRN	W_PROTECT_FLAG:BYTE	  ;AN000;
	EXTRN	EXIT_SELECT:FAR 	  ;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CODE_FAR    SEGMENT PARA PUBLIC 'CODE'  ;AN000; Segment for far routine
	ASSUME	CS:CODE_FAR,DS:DATA	;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; The critical error handler.  This routine should be placed in the CODE segment.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OLD_STACK_SEG	DW	?			;AN001;GHG
OLD_STACK_OFF	DW	?			;AN001;GHG
						;GHG
	PUBLIC	INT_24_VECTOR			;AN000;
INT_24_VECTOR:					;AN000;

    PUSHH     <BX,CX,DX,SI,DI,ES,DS>		;AN000;
    MOV     AX,DATA				;AN000;
    MOV     DS,AX				;AN000;
    MOV     ES,AX				;AN000;
						;
    MOV     AX,CS			      ;AN002;S;GHG
    CLI 				      ;AN002;S;GHG
    MOV     OLD_STACK_SEG,SS		      ;AN002;S;GHG
    MOV     OLD_STACK_OFF,SP		      ;AN002;S;GHG
    MOV     SS,AX			      ;AN002;S;GHG
    LEA     SP,NEW_STACK_START		      ;AN002;S;GHG
    STI 				      ;AN002;S;GHG
						;
    AND  DI, 0FFH				;AN000; Mask off the high byte
    cmp CHK_W_PROTECT_FLAG,TRUE			;AN000; Is this a check for write protect?
    jne endif_l_1
	 cmp DI,0				;AN000; Is this a write protect error?
	 jne @F
	      MOV  W_PROTECT_FLAG, TRUE 	;AN000; If so, indicate to the calling program
	 @@:	 				;AN000;
	 MOV  AL, 3				;AN000; Get DOS to trash this call
	 JMP  EXIT_THE_INT			;AN000; Exit the interrupt
    endif_l_1:					;AN000;
						;
    cmp DI,0					;AN002;GHG
    jne elseif_l_2
	  HANDLE_ERROR	     PAN_WRITE_PROT,2	;AN002;GHG
	  MOV	AL,1				;AN002;GHG
    jmp short endif_l_2
    elseif_l_2:
    cmp DI,2		 			;AN002;GHG
    jne else_l_2
	  HANDLE_ERROR	     PAN_DRIVE_ERROR,2	;AN002;GHG
	  MOV	AL,1				;AN002;GHG
    jmp short endif_l_2
    else_l_2:					;AN002;GHG
	 cmp SUB_PROGRAM,TRUE			;AN000;
	 jne @F
	      JMP  END_SUB_PROGRAM		;AN000;
	 @@:	 				;AN000;
	 MOV  AL, 3				;AN000; Fail this system call
    endif_l_2:					;AN000;
EXIT_THE_INT:					;AN000;
    MOV    SS,OLD_STACK_SEG		      ;AN002;S;GHG
    MOV    SP,OLD_STACK_OFF		      ;AN002;S;GHG
    POPP   <DS,ES,DI,SI,DX,CX,BX>		;AN000;
    IRET					;AN000; Return from the interrupt
						;
END_SUB_PROGRAM:				;AN000;
    MOV    SS,OLD_STACK_SEG		      ;AN002;S;GHG
    MOV    SP,OLD_STACK_OFF		      ;AN002;S;GHG
    POPP      <DS,ES,DI,SI,DX,CX,BX>		;AN000;
    ADD  SP, 6					;AN000;
						;
    MOV  AH, 4CH				;AN000;
    MOV  AL, 01 				;AN000;
    DOSCALL					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; The DISKCOPY INT 2F INTERFACE
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
						;
		EVEN				;AN000;
NEW_STACK	DW   200 DUP('S')               ;AN001;GHG
NEW_STACK_START DW	0			;AN001;GHG
						;GHG
FIRST_CALL	DB	0			;AN001;GHG
						;GHG
	PUBLIC	INT_2F_VECTOR			;AN001;GHG
INT_2F_VECTOR:					;AN001;GHG
	cmp AX,0ADC1H				;AN001;GHG
	jne else_l_9
						;GHG
	   PUSHH   <BX,CX,DX,SI,DI,ES,DS>	;AN001;GHG
	   MOV	   AX,DATA			;AN001;GHG
	   MOV	   DS,AX			;AN001;GHG
	   MOV	   ES,AX			;AN001;GHG
						   ;GHG
	   MOV	   AX,CS		      ;AN001;S;GHG
	   CLI				      ;AN001;S;GHG
	   MOV	   OLD_STACK_SEG,SS	      ;AN001;S;GHG
	   MOV	   OLD_STACK_OFF,SP	      ;AN001;S;GHG
	   MOV	   SS,AX		      ;AN001;S;GHG
	   LEA	   SP,NEW_STACK_START	      ;AN001;S;GHG
	   STI				      ;AN001;S;GHG
						   ;GHG

	   cmp DSKCPY_WHICH,DSKCPY_TO_B	      ;AN000;DT
	   jne elseif_l_8
						   ;
	      cmp BX, 9				   ;AN000;DT
	      jne elseif_l_3_1
	      cmp DSKCPY_PAN1,NOPANEL		   ;AN000;DT
	      je elseif_l_3_1
		    repeat_l_1:			   ;AN000;DT
			MOV	  BX,PAN_INSTALL_DOS   ;AN000;DT
			MOV	  AX,DSKCPY_PAN1       ;AN000;DT
			CALL	  HANDLE_PANEL_CALL2   ;AN000;DT
			CALL	  HANDLE_KEYSTROKE     ;AN000;DT
			MOV  DI, DSKCPY_SOURCE	       ;AN000;DT
			MOV  CX, 0		       ;AN000;DT
			CALL FIND_FILE_ROUTINE	       ;AN000;DT
		       jnc endrepeat_l_1	       ;AN000;DT
			   MOV	   BX,ERR_DOS_DISK     ;AN000;DT
			   CALL    INT2F_ERROR	       ;AN000;DT
						       ;AN000;DT
		   jmp repeat_l_1		       ;AN000;DT
		   endrepeat_l_1:
						       ;AN000;DT
		    MOV       BX,PAN_INSTALL_DOS   ;AN000;DT
		    MOV       AX,DSKCPY_PAN2	   ;AN000;DT
		    CALL      HANDLE_PANEL_CALL2   ;AN000;DT
						   ;AN000;DT
	      jmp endif_l_3
	      elseif_l_3_1:
	      cmp BX,13				   ;AN000;DT
	      jne elseif_l_3_2
		 MOV	 BX,PAN_DRIVE_ERROR	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;DT
						   ;
	      jmp endif_l_3
	      elseif_l_3_2:
	      cmp BX,14				   ;AN001;GHG  write protect
	      jne elseif_l_3_3
		 MOV	 BX,PAN_WRITE_PROT	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;DT
						   ;
	      jmp endif_l_3
	      elseif_l_3_3:
	      cmp BX,23				   ;AN004;JW
	      je @F
	      cmp BX,11				   ;AN004;JW
	      je @F
	      cmp BX,12				   ;AN004;JW
	      je @F
	      cmp BX,18				   ;AN004;JW
	      je @F
	      cmp BX,20				   ;AN004;JW
	      jne elseif_l_3_4
	      @@:
		 MOV	 BX,PAN_BAD_DISKET	   ;AN004;JW Bad diskette in b:
		 CALL	 INT2F_ERROR		   ;AN004;JW
		 MOV	 N_DSKCPY_ERR,E_DSKCPY_RETRY ;AN004;JW
						   ;
	      jmp endif_l_3
	      elseif_l_3_4:
	      cmp BX,16				   ;AN001;GHG
	      jne elseif_l_3_5
		 MOV	   FIRST_CALL,0 	   ;AN001;GHG
	      jmp endif_l_3
	      elseif_l_3_5:
	      cmp BX, 2				   ;AN001;GHG
	      je endif_l_3
	      cmp BX, 7				   ;AN001;GHG
	      je endif_l_3
	      cmp BX, 8				   ;AN001;GHG
	      je endif_l_3
	      cmp BX, 9				   ;AN000;DT
	      je endif_l_3
	      cmp BX,10				   ;AN003;JW
	      je endif_l_3
	      cmp BX,15				   ;AN001;GHG
	      je endif_l_3
	      cmp BX,17				   ;AN001;GHG
	      je endif_l_3
	      cmp BX,21				   ;AN001;GHG
	      je endif_l_3
	      cmp BX,26				   ;AN001;GHG
	      je endif_l_3
		 MOV	 BX,ERR_GENERAL 	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;DT
	      endif_l_3:			   ;AN000;
	      MOV    AX,0FFFFH			   ;AN000;DT

	   jmp endif_l_8
	   elseif_l_8:
	   cmp DSKCPY_WHICH,DSKCPY_TO_A_360	   ;AN000;DT
	   jne else_l_8
	      cmp BX, 8				   ;AN001;GHG
	      jne elseif_l_5_1
		  cmp DSKCPY_OPTION,SOURCE1	;AN000;
		  je @F
		  cmp FIRST_CALL,0		;AN001;GHG
		  je endif_l_4
		  @@:
		    repeat_l_2:			      ;AN000;
		       MOV	 BX,PAN_INSTALL_DOS   ;AN000;DT
		       MOV	 AX,DSKCPY_PAN1       ;AN000;DT
		       CALL	 HANDLE_PANEL_CALL2   ;AN000;DT
		       CALL	 HANDLE_KEYSTROKE     ;AN000;DT
						      ;AN000;DT
			MOV  DI, DSKCPY_SOURCE	      ;AN000;DT
			MOV  CX, 0		      ;AN000;DT
			CALL FIND_FILE_ROUTINE	      ;AN000;DT
		       jnc endrepeat_l_2	      ;AN000;DT
			   MOV	   BX,ERR_DOS_DISK    ;AN000;DT
			   CALL    INT2F_ERROR	      ;AN000;DT
		    jmp repeat_l_2		      ;AN000;DT
		    endrepeat_l_2:
						      ;AN000;DT
		    endif_l_4:			      ;AN000;
		    MOV       BX,PAN_INSTALL_DOS   ;AN000;DT
		    MOV       AX,DSKCPY_PAN2	   ;AN000;DT
		    CALL      HANDLE_PANEL_CALL2   ;AN000;DT
		    MOV       FIRST_CALL,1	   ;AN000;GHG
	      jmp endif_l_5
	      elseif_l_5_1:
	      cmp BX, 9				   ;AN001;GHG
	      jne elseif_l_5_2
		    MOV       BX,PAN_INSTALL_DOS   ;AN000;DT
		    MOV       AX,DSKCPY_PAN3	   ;AN000;DT
		    CALL      HANDLE_PANEL_CALL2   ;AN000;DT
		    CALL      HANDLE_KEYSTROKE	   ;AN000;DT
		    MOV       BX,PAN_INSTALL_DOS   ;AN000;DT
		    MOV       AX,DSKCPY_PAN2	   ;AN000;DT
		    CALL      HANDLE_PANEL_CALL2   ;AN000;DT
	      jmp endif_l_5
	      elseif_l_5_2:
	      cmp BX,13				   ;AN000;DT
	      jne elseif_l_5_3
		 MOV	 BX,PAN_DRIVE_ERROR	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;DT
						   ;
	      jmp endif_l_5
	      elseif_l_5_3:
	      cmp BX,14				   ;AN001;GHG  write protect
	      jne elseif_l_5_4
		 MOV	 BX,PAN_WRITE_PROT	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;
						   ;
	      jmp endif_l_5
	      elseif_l_5_4:
	      cmp BX,23				   ;AN004;JW
	      je @F
	      cmp BX,11				   ;AN004;JW
	      je @F
	      cmp BX,12				   ;AN004;JW
	      je @F
	      cmp BX,18				   ;AN004;JW
	      je @F
	      cmp BX,20				   ;AN004;JW
	      jne elseif_l_5_5
	      @@:
		 MOV	 BX,PAN_BAD_DISKET	   ;AN004;JW Bad diskette in b:
		 CALL	 INT2F_ERROR		   ;AN004;JW
		 MOV	 N_DSKCPY_ERR,E_DSKCPY_RETRY ;AN004;JW
						   ;
	      jmp endif_l_5
	      elseif_l_5_5:
	      cmp BX,16				   ;AN001;GHG
	      jne elseif_l_5_6
		 MOV	   FIRST_CALL,0 	   ;AN001;GHG
	      jmp endif_l_5
	      elseif_l_5_6:
	      cmp BX, 2				   ;AN001;GHG
	      je endif_l_5
	      cmp BX, 7				   ;AN001;GHG
	      je endif_l_5
	      cmp BX,10				   ;AN003;JW
	      je endif_l_5
	      cmp BX,15				   ;AN001;GHG
	      je endif_l_5
	      cmp BX,17				   ;AN001;GHG
	      je endif_l_5
	      cmp BX,21				   ;AN001;GHG
	      je endif_l_5
	      cmp BX,26				   ;AN001;GHG
	      je endif_l_5
		 MOV	 BX,ERR_GENERAL 	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;
	      endif_l_5:			   ;AN001;GHG
						   ;
	      MOV    AX,0FFFFH			   ;AN001;GHG
	   jmp endif_l_8
	   else_l_8:				   ;AN000;
	      cmp BX, 9				   ;AN001;GHG
	      jne elseif_l_7_1
		    MOV       AX,PAN_DSKCPY_SRC    ;AN001;GHG
		    CALL      HANDLE_PANEL_CALL    ;AN001;GHG
		    CALL      HANDLE_KEYSTROKE	   ;AN001;GHG
		    MOV       AX,PAN_DSKCPY_CPY    ;AN001;GHG
		    CALL      HANDLE_PANEL_CALL    ;AN001;GHG
	      jmp endif_l_7
	      elseif_l_7_1:
	      cmp BX, 8				   ;AN001;GHG
	      jne elseif_l_7_2
		 cmp FIRST_CALL,0		   ;AN001;GHG
		 je else_l_6
		    MOV       AX,PAN_DSKCPY_TAR    ;AN001;GHG
		    CALL      HANDLE_PANEL_CALL    ;AN001;GHG
		    CALL      HANDLE_KEYSTROKE	   ;AN001;GHG
		 jmp short endif_l_6
		 else_l_6:			   ;AN001;GHG
		    MOV       FIRST_CALL,1	   ;AN001;GHG
		 endif_l_6: 			   ;AN001;GHG
		 MOV	   AX,PAN_DSKCPY_CPY	   ;AN001;GHG
		 CALL	   HANDLE_PANEL_CALL	   ;AN001;GHG
	      jmp endif_l_7
	      elseif_l_7_2:
	      cmp BX,16				   ;AN001;GHG
	      jne elseif_l_7_3
		 MOV	   AX,0FFFFH		   ;AN001;GHG
		 MOV	   FIRST_CALL,0 	   ;AN001;GHG
		 JMP	   INT2F_1		   ;AN001;GHG
	      jmp endif_l_7
	      elseif_l_7_3:
	      cmp BX,13				   ;AN000;DT   drive not ready
	      jne elseif_l_7_4
		 MOV	 BX,PAN_DRIVE_ERROR	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;DT
	      jmp endif_l_7
	      elseif_l_7_4:
	      cmp BX,14				   ;AN001;GHG  write protect
	      jne elseif_l_7_5
		 MOV	 BX,PAN_WRITE_PROT	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;DT
	      jmp endif_l_7
	      elseif_l_7_5:
	      cmp BX,23				   ;AN004;JW
	      je @F
	      cmp BX,11				   ;AN004;JW
	      je @F
	      cmp BX,12				   ;AN004;JW
	      je @F
	      cmp BX,18				   ;AN004;JW
	      je @F
	      cmp BX,20				   ;AN004;JW
	      jne elseif_l_7_6
	      @@:
		 MOV	 BX,PAN_BAD_DISKET	   ;AN004;JW Bad diskette in b:
		 CALL	 INT2F_ERROR		   ;AN004;JW
		 MOV	 N_DSKCPY_ERR,E_DSKCPY_RETRY ;AN004;JW
						   ;
	      jmp endif_l_7
	      elseif_l_7_6:
	      cmp BX, 2				   ;AN001;GHG
	      je endif_l_7
	      cmp BX, 7				   ;AN001;GHG
	      je endif_l_7
	      cmp BX,10				   ;AN001;GHG
	      je endif_l_7
	      cmp BX,15				   ;AN001;GHG
	      je endif_l_7
	      cmp BX,17				   ;AN001;GHG
	      je endif_l_7
	      cmp BX,21				   ;AN001;GHG
	      je endif_l_7
	      cmp BX,26				   ;AN001;GHG
	      je endif_l_7
		 MOV	 BX,ERR_GENERAL 	   ;AN000;
		 CALL	 INT2F_ERROR		   ;AN000;DT
	      endif_l_7:			   ;AN001;GHG
						   ;
	      MOV    AX,0FFFFH			   ;AN001;GHG

	   endif_l_8:				   ;AN000;DT

INT2F_1:      MOV    SS,OLD_STACK_SEG		   ;AN001;S;GHG
	      MOV    SP,OLD_STACK_OFF		   ;AN001;S;GHG

						   ;
	   POPP    <DS,ES,DI,SI,DX,CX,BX>	   ;AN001;GHG
						   ;
						   ;
	   IRET 				;AN001;GHG
	jmp short endif_l_9
	else_l_9:				;AN001;GHG
	    JMP     CS:OLD_INT_2F		;AN001;GHG
	endif_l_9:				;AN001;GHG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;   The FORMAT INT2F interrupt routine
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUBLIC	INT_2F_FORMAT		       ;AN111;JW
INT_2F_FORMAT:				       ;AN111;JW
	cmp AX,0ADC1H			       ;AN111;JW
	jne else_l_12
					       ;AN111;JW
	   PUSHH   <BX,CX,DX,SI,DI,ES,DS>      ;AN111;JW
	   MOV	   AX,DATA		       ;AN111;JW
	   MOV	   DS,AX		       ;AN111;JW
	   MOV	   ES,AX		       ;AN111;JW
					       ;AN111;JW
	   MOV	   AX,CS		       ;AN111;JW
	   CLI				       ;AN111;JW
	   MOV	   OLD_STACK_SEG,SS	       ;AN111;JW
	   MOV	   OLD_STACK_OFF,SP	       ;AN111;JW
	   MOV	   SS,AX		       ;AN111;JW
	   LEA	   SP,NEW_STACK_START	       ;AN111;JW
	   STI				       ;AN111;JW
					       ;AN111;JW
	   cmp FORMAT_WHICH,STARTUP	       ;AN111;JW
	   jne else_l_10
	      MOV	AX,SUB_INS_STARTT_S360 ;AN111;JW
	   jmp short endif_l_10
	   else_l_10:			       ;AN111;JW
	      MOV	AX,SUB_INS_SHELL_S360  ;AN111;JW
	   endif_l_10:			       ;AN111;JW
	   MOV	     BX,PAN_INST_PROMPT        ;AN111;JW
	   CALL      HANDLE_PANEL_CALL2        ;AN111;JW
	   CALL      HANDLE_KEYSTROKE	       ;AN111;JW
					       ;AN111;JW
	   cmp FORMAT_WHICH,STARTUP	       ;AN111;JW
	   jne else_l_11
	      MOV	AX,FORMAT_STARTUP      ;AN111;JW
	   jmp short endif_l_11
	   else_l_11:			       ;AN111;JW
	      MOV	AX,FORMAT_SHELL        ;AN111;JW
	   endif_l_11:			       ;AN111;JW
	   CALL      HANDLE_PANEL_CALL3        ;AN111;JW
					       ;AN111;JW
	   MOV	  SS,OLD_STACK_SEG	       ;AN111;JW
	   MOV	  SP,OLD_STACK_OFF	       ;AN111;JW
	   POPP    <DS,ES,DI,SI,DX,CX,BX>      ;AN111;JW
	   IRET 			       ;AN111;JW
	jmp short endif_l_12
	else_l_12:			       ;AN111;JW
	    JMP     CS:OLD_INT_2F	       ;AN111;JW
	endif_l_12:			       ;AN111;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; The DISKCOPY INT 2F ERROR ROUTINE
;
; Input: BX = error panel
;
; Output: none
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INT2F_ERROR	PROC  NEAR		;AN000;DT
	MOV	CX,2			;AN000;DT allow ESC and ENTER
	CALL	HANDLE_ERROR_CALL	;AN000;DT display error panel
	JNC	INT2F_ERROR_EXIT	;AN000;DT if ENTER pressed, then ok
					;AN000;DT else ESC
	MOV	DSKCPY_ERR,DSKCPY_EXIT	;AN000;DT indicate user wants to exit
	MOV	AX,4C01H		;AN000;DT and error message already up	DOS
	INT	21H			;AN000;DT exit with error
					;AN000;DT
INT2F_ERROR_EXIT:			;AN000;DT
	RET				;AN000;DT
INT2F_ERROR	ENDP			;AN000;DT
					;;;;;;;;;;;;
						   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; The DISKCOPY INT 2F INTERFACE (256KB DISKCOPY)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUBLIC	INT_2F_256KB			   ;AN000;DT
INT_2F_256KB:					   ;AN000;DT
	cmp AX,0ADC1H				   ;AN000;DT
	jne else_l_15
						   ;AN000;DT
	   PUSHH   <BX,CX,DX,SI,DI,ES,DS>	   ;AN000;DT
	   MOV	   AX,DATA			   ;AN000;DT
	   MOV	   DS,AX			   ;AN000;DT
	   MOV	   ES,AX			   ;AN000;DT
						   ;AN000;DT
	   MOV	   AX,CS			   ;AN000;DT
	   CLI					   ;AN000;DT
	   MOV	   OLD_STACK_SEG,SS		   ;AN000;DT
	   MOV	   OLD_STACK_OFF,SP		   ;AN000;DT
	   MOV	   SS,AX			   ;AN000;DT
	   LEA	   SP,NEW_STACK_START		   ;AN000;DT
	   STI					   ;AN000;DT
	      cmp BX, 9				   ;AN000;DT
	      jne elseif_l_14_1
		    CLEAR_SCREEN		   ;AN000;DT
		    DISPLAY_MESSAGE  14 	   ;AN000;DT insert INSTALL
		    CALL HANDLE_KEY256KB	   ;AN000;DT
		    CLEAR_SCREEN		   ;AN000;DT
		    DISPLAY_MESSAGE  15 	   ;AN000;DT Copying diskettes
	      jmp endif_l_14
	      elseif_l_14_1:
	      cmp BX, 8				   ;AN000;DT
	      jne elseif_l_14_2
		 cmp FIRST_CALL,0		   ;AN000;DT
		 je else_l_13
		    CLEAR_SCREEN		   ;AN000;DT
		    DISPLAY_MESSAGE  13 	   ;AN000;DT insert INSTALL COPY
		    CALL HANDLE_KEY256KB	   ;AN000;DT
		 jmp short endif_l_13
		 else_l_13:			   ;AN000;DT
		    MOV       FIRST_CALL,1	   ;AN000;DT
		 endif_l_13: 			   ;AN000;DT
		 CLEAR_SCREEN			   ;AN000;DT
		 DISPLAY_MESSAGE  15		   ;AN000;DT Copying diskettes
	      jmp endif_l_14
	      elseif_l_14_2:
	      cmp BX,16				   ;AN000;DT
	      jne elseif_l_14_3
		 MOV	   AX,0FFFFH		   ;AN000;DT
		 MOV	   FIRST_CALL,0 	   ;AN000;DT
		 JMP	   INT2F_1_ALT		   ;AN000;DT
	      jmp endif_l_14
	      elseif_l_14_3:
	      cmp BX,13				   ;AN000;DT
	      jne elseif_l_14_4
		 CLEAR_SCREEN			   ;AN000;DT
		 DISPLAY_MESSAGE  16		   ;AN000;DT Drive door open
		 CALL	 INT2F_ERRALT		   ;AN000;DT
	      jmp endif_l_14
	      elseif_l_14_4:
	      cmp BX,14				   ;AN000;DT
	      jne elseif_l_14_5
		 CLEAR_SCREEN			   ;AN000;DT
		 DISPLAY_MESSAGE  17		   ;AN000;DT Write Protect error
		 CALL	 INT2F_ERRALT		   ;AN000;DT
						   ;AN000;DT
	      jmp endif_l_14
	      elseif_l_14_5:
	      cmp BX, 2				   ;AN000;DT
	      je endif_l_14
	      cmp BX, 7				   ;AN000;DT
	      je endif_l_14
	      cmp BX,10				   ;AN000;DT
	      je endif_l_14
	      cmp BX,15				   ;AN000;DT
	      je endif_l_14
	      cmp BX,17				   ;AN000;DT
	      je endif_l_14
	      cmp BX,21				   ;AN000;DT
	      je endif_l_14
	      cmp BX,26				   ;AN000;DT
	      je endif_l_14
		 CLEAR_SCREEN			   ;AN000;DT
		 DISPLAY_MESSAGE  18		   ;AN000;DT General error
		 CALL	 INT2F_ERRALT		   ;AN000;DT
	      endif_l_14:			   ;AN000;DT
						   ;AN000;DT
	      MOV    AX,0FFFFH			   ;AN000;DT
						   ;AN000;DT
INT2F_1_ALT:  MOV    SS,OLD_STACK_SEG		   ;AN000;DT
	      MOV    SP,OLD_STACK_OFF		   ;AN000;DT
						   ;AN000;DT
	   POPP    <DS,ES,DI,SI,DX,CX,BX>	   ;AN000;DT
	   IRET 				;;AN000;;DT
	jmp short endif_l_15
	else_l_15:				;AN000;DT
	    JMP     CS:OLD_INT_2F		;AN000;DT
	endif_l_15:				;AN000;DT
						;AN000;DT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; The DISKCOPY INT 2F ERROR ROUTINE (256KB)
;
; Input: BX = error panel
;
; Output: none
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INT2F_ERRALT	PROC  NEAR		;AN000;DT
INT2F_AGN:				;AN000;DT
	MOV	AH,0			;AN000;DT
	INT	16H			;AN000;DT get keystroke
	CMP	AL,13			;AN000;DT If ENTER the continue
	JE	INT2F_ERRALT_EXIT	;AN000;DT
	CMP	AL,27			;AN000;DT If not ESC the again
	JE	INT2F_ALT_ABORT 	;AN000;
	DISPLAY_MESSAGE  11		;AN000;DT BEEP
	JMP	INT2F_AGN		;AN000;DT
INT2F_ALT_ABORT:			;AN000;DT else ESC
	MOV	DSKCPY_ERR,DSKCPY_EXIT	;AN000;DT indicate user wants to exit
	MOV	AX,4C01H		;AN000;DT and error message already up	DOS
	INT	21H			;AN000;DT exit with error
					;AN000;DT
INT2F_ERRALT_EXIT:			;AN000;DT
	RET				;AN000;DT
INT2F_ERRALT	ENDP			;AN000;DT
					;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;   The INT23 interrupt routine   (CTRL-BREAK)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	PUBLIC	INT_23_VECTOR		       ;AN074;SEH
INT_23_VECTOR:				       ;AN074;SEH
					       ;
	IRET				       ;AN074;SEH ignore ctrl-break and return
					       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; The DISKCOPY GET KEY ROUTINE (256KB)
;
; Input: none
;
; Output: none
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HANDLE_KEY256KB PROC NEAR		;AN000;DT
HAKEY_AGN:				;AN000;DT
	MOV	AH,0			;AN000;DT
	INT	16H			;AN000;DT get keystroke
	CMP	AL,13			;AN000;DT If ENTER the continue
	JE	HAKEY_EXIT		;AN000;DT
	DISPLAY_MESSAGE  11		;AN000;DT BEEP
	JMP	HAKEY_AGN		;AN000;DT
					;AN000;DT
HAKEY_EXIT:				;AN000;DT
	RET				;AN000;DT
HANDLE_KEY256KB ENDP			;AN000;DT

CODE_FAR    ENDS			;AN000;
	    END 			;AN000;
