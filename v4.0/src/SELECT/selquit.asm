

PAGE 55,132				;AN000;
NAME	SELQUIT 			;AN000;
TITLE	SELQUIT - Exit Panel support for SELECT.EXE;AN000;
SUBTTL	selquit.asm			;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
; SELQUIT.ASM
;
; DATE:    July 6/87
;
; COMMENTS:
;
;	   This files must be compiled with MASM 3.0 (using /A option)
;
;	   Copyright 1988 Microsoft
;
;	   ;AN001; Added flag to indicate error processing was in effect.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.LFCOND 				;AN000;
.XLIST					;AN000;
	INCLUDE    panel.mac		;AN000;
	INCLUDE    pcequate.inc 	;AN000;
	INCLUDE    pan-list.inc 	;AN000;
	INCLUDE    castruc.inc		;AN000;
	INCLUDE    ext.inc		;AN000;
	INCLUDE    macros.inc		;AN000;
.LIST					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Setup Environment
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	EXTRN	QM_ACTIVEPAN:WORD	;AN000;
					;
	EXTRN	GET_KEY:NEAR		;AN000;
	EXTRN	CURSOROFF:NEAR		;AN000;
	EXTRN	PCINPUT_CALL:NEAR	;AN000;
	EXTRN	PCDISPQ_CALL:NEAR	;AN000;
					;
	EXTRN	WR_DRETLEN:WORD 	;AN000;
	EXTRN	WR_DRETOFF:WORD 	;AN000;
	EXTRN	WR_DRETSEG:WORD 	;AN000;
	EXTRN	GET_PCB:NEAR		;AN000;
	EXTRN	QM_OPT1:WORD		;AN000;
	EXTRN	QM_ID:WORD		;AN000;
	EXTRN	INC_KS:WORD		;AN000;
					;
	EXTRN	HANDLE_CHILDREN:NEAR	;AN000;
	EXTRN	ADJUST_UP:NEAR		;AN000;
	EXTRN	ADJUST_DOWN:NEAR	;AN000;
	EXTRN	INIT_PQUEUE_CALL:NEAR	;AN000;
	EXTRN	PREPARE_PANEL_CALL:NEAR ;AN000;
	EXTRN	DISPLAY_PANEL_CALL:NEAR ;AN000;
	EXTRN	GET_FUNCTION_CALL:NEAR	;AN000;
	EXTRN	QM_OPT2:WORD		;AN000;
	EXTRN	WR_REFIELDCNT:WORD	;AN000;
	EXTRN	ERROR_KEYS:BYTE 	;AN000;
	EXTRN	ERROR_KEYS_LEN:ABS	;AN000;
	EXTRN	PCMBEEP_CALL:NEAR	;AN000;
	EXTRN	BIN_TO_CHAR_ROUTINE:FAR ;AN000;
					;
TRUE	EQU	1			;AN000;
FALSE	EQU	0			;AN000;
					;
SELECT	SEGMENT PARA PUBLIC 'SELECT'    ;AN000;segment for far routine
	ASSUME	CS:SELECT		;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; HANDLE_F3
;
;
;	CLC = return to SELECT
;	STC = quit SELECT.....
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
F3_ACTIVE    DB      FALSE		;AN001;DT
					;
	PUBLIC	HANDLE_F3		;AN000;
HANDLE_F3	PROC			;AN000;
	PUSHH  <AX,BX,DI,ES,WR_DRETLEN> ;AN000;
	PUSHH  <WR_DRETOFF,WR_DRETSEG>	;AN000;
	PUSHH  <WR_REFIELDCNT>		;AN000;
					;
	cmp F3_ACTIVE,FALSE		;AN000;
	jne else_l_2
	   CALL    CURSOROFF		;;AN000;;;
					   ;
	   MOV	   AX,QM_PUSHPQU	   ;AN000;save parent queue
	   OR	   AX,QM_PUSHCQU	   ;AN000;save child queue
	   MOV	   QM_OPT1,AX		   ;AN000;
	   CALL    PCDISPQ_CALL 	   ;AN000;update display queue
					   ;
	   MOV	   QM_OPT1,QM_CLSPAN	   ;AN000;clear parent panel queue
	   OR	   QM_OPT1,QM_CLSCHD	   ;AN000;clear parent panel queue
	   CALL    PCDISPQ_CALL 	   ;AN000;update display queue
	   MOV	   QM_ACTIVEPAN,PAN_CONFIRM;AN000;current active parent panel
	   MOV	   AX,PAN_CONFIRM	   ;AN000;
	   MOV	   QM_OPT1,QM_PUSHPAN	   ;AN000;push parent panels
	   CALL    PREPARE_PANEL_CALL	   ;AN000;add panel to display queue

	   MOV	   WR_REFIELDCNT,0	   ;AN000;set for break = off
	   PREPARE_PANEL   PAN_HBAR	   ;AN000;
	   PREPARE_CHILDREN		   ;AN000;
	   DISPLAY_PANEL		   ;AN000;push parent panels
					   ;
	   MOV	   CX,FK_ENT_F3_LEN	   ;AN000;
	   LEA	   DX,FK_ENT_F3 	   ;AN000;
	   MOV	   WR_DRETLEN,CX	   ;AN000;get return string length
	   MOV	   AX,DX		   ;AN000;get return string offset
	   MOV	   WR_DRETOFF,AX	   ;AN000;
	   MOV	   AX,DS		   ;AN000;get return string segment
	   MOV	   WR_DRETSEG,AX	   ;AN000;
	   CALL    GET_KEY		   ;AN000;
	   MOV	   AX,INC_KS		   ;AN003;GHG
	   MOV	   N_USER_FUNC,AX	   ;AN003;GHG
					   ;
	   MOV	   AX,QM_POPPQU 	   ;AN000;
	   OR	   AX,QM_POPCQU 	   ;AN000;
	   MOV	   QM_OPT1,AX		   ;AN000;
	   CALL    PCDISPQ_CALL 	   ;AN000;
	   MOV	   AX,I_USER_INDEX	   ;AN000;get last current element
					   ;
	   cmp N_USER_FUNC,F3*256	   ;AN000;
	   jne else_l_1			   ;AN000;
		STC			   ;AN000;
		MOV   F3_ACTIVE,TRUE	   ;AN000;DT Indicate exit selected
	   jmp short endif_l_2
	   else_l_1:			   ;AN000;
		POP   WR_REFIELDCNT	   ;AN000;
		PUSH  WR_REFIELDCNT	   ;AN000;
		DISPLAY_PANEL		   ;AN000;
		CLC			   ;AN000;
	   endif_l_1:			   ;AN000;;;
					   ;
	jmp short endif_l_2
	else_l_2:			   ;AN027;SEH Set carry flag to avoid
	   STC				   ;AN027;SEH	  endless loop in Get_Function_call
	endif_l_2:			   ;AN000;
					   ;
	POPP   <WR_REFIELDCNT,WR_DRETSEG>  ;AN000;
	POPP   <WR_DRETOFF,WR_DRETLEN,ES>  ;AN000;
	POPP   <DI,BX,AX>		   ;AN000;
	RET				   ;AN000;
HANDLE_F3	ENDP			   ;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	 AX,input
;	 BX,action
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERROR_PANEL	DW	?		;AN000;
ERROR_TYPE	DW	?		;AN000;
ERROR_CODE	DW	?		;AN000;
ERROR_STRING	DB	5 DUP(0)	;AN000;
					;
	PUBLIC ERROR_ACTIVE		;AN001;JW
ERROR_ACTIVE	DB	0		;AN001;JW
					;
	PUBLIC	HANDLE_ERROR_CALL	;AN000;
HANDLE_ERROR_CALL PROC	FAR		;AN000;
	PUSHH  <AX,BX,DI,ES,WR_DRETLEN> ;AN000;
	PUSHH  <WR_DRETOFF,WR_DRETSEG>	;AN000;
	PUSHH  <WR_REFIELDCNT>		;AN000;
					;
	MOV	ERROR_CODE,AX		;AN000;
	MOV	ERROR_PANEL,BX		;AN000;
	MOV	ERROR_TYPE,CX		;AN000;
	MOV	ERROR_ACTIVE,1		;AN001;JW
					;
	MOV	BX,ERR_BORDER		;AN000;DT current active parent panel
	CALL	GET_PCB 		;AN000;DT get the PCB for this
	MOV	ES:[DI].PCB_CHILDNUM,CX ;AN000;DT set the number of children
					;
	CALL	CURSOROFF		;AN000;
					;
	MOV	QM_OPT1,QM_PUSHPQU	;AN000;save parent queue
	OR	QM_OPT1,QM_PUSHCQU	;AN000;save child queue
	CALL	PCDISPQ_CALL		;AN000;update display queue
					;
	cmp F3_ACTIVE,TRUE		;AN000;
	jne @F
	   MOV	   QM_OPT1,QM_CLSPAN	   ;AN000;clear parent panel queue
	   OR	   QM_OPT1,QM_CLSCHD	   ;AN000;clear parent panel queue
	   CALL    PCDISPQ_CALL 	   ;AN000;update display queue
	@@:				   ;AN000;

	MOV	QM_OPT1,QM_PUSHPAN	;AN000;push parent panels
	OR	QM_OPT2,QM_BREAKON	;AN000;break on

	MOV	BX,ERR_BORDER		;AN000;current active parent panel
	MOV	QM_ID,BX		;AN000;current active parent panel
	MOV	QM_ACTIVEPAN,BX 	;AN000;current active parent panel
	MOV	AX,BX			;AN000;
	CALL	PREPARE_PANEL_CALL	;AN000;add panel to display queue
					;
	MOV	QM_OPT2,0		;AN000;
					;
;;;;;;;;MOV	WR_REFIELDCNT,0 	;set for break = off
	PREPARE_PANEL	ERROR_PANEL	;AN000;
	PREPARE_CHILDREN		;AN000;
	DISPLAY_PANEL			;AN000;push parent panels
					;
	CALL	PCMBEEP_CALL		;AN000;
					;
	MOV	CX,ERROR_TYPE		;AN000;
	INC	CX			;AN000;JW
	LEA	DX,ERROR_KEYS		;AN000;
	CALL	GET_FUNCTION_CALL	;AN000;
	MOV	ERROR_ACTIVE,0		;AN001;JW
					;
	MOV	QM_OPT1,QM_POPPQU	;AN000;
	OR	QM_OPT1,QM_POPCQU	;AN000;
	CALL	PCDISPQ_CALL		;AN000;
	MOV	AX,I_USER_INDEX 	;AN000;get last current element
					;
        cmp N_USER_FUNC,F3*256		;AC000;DT F3 to exit SELECT
	je @F
	cmp F3_ACTIVE,TRUE		;AN000;DT or already selected
	jne else_l_3			;AN000;
	@@:
	     STC			;AN000;
	jmp short endif_l_3
	else_l_3:			;AN000;
	     POP   WR_REFIELDCNT	;AN000;
	     PUSH  WR_REFIELDCNT	;AN000;
	     DISPLAY_PANEL		;AN000;
	     CLC			;AN000;
	endif_l_3:			;AN000;
					;
	POPP   <WR_REFIELDCNT,WR_DRETSEG>;AN000;
	POPP   <WR_DRETOFF,WR_DRETLEN,ES>;AN000;
	POPP   <DI,BX,AX>		;AN000;
	RET				;AN000;
HANDLE_ERROR_CALL ENDP			;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	 AX,input
;	 BX,action
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUBLIC	HANDLE_PANEL_CALL	;AN000;
HANDLE_PANEL_CALL PROC	FAR		;AN000;
	PUSH	AX			;AN000;
	PUSH	AX			;AN000;
	PUSH	AX			;AN000;
	MOV	AX,PAN_INSTALL_DOS	;AN000;
	CALL	INIT_PQUEUE_CALL	;AN000;
	POP	AX			;AN000;
	CALL	PREPARE_PANEL_CALL	;AN000;
	POP	AX			;AN000;
	cmp AX,PAN_DSKCPY_CPY		;AN000;
	je @F
	   MOV	   AX,PAN_HBAR		;AN000;
	   CALL    PREPARE_PANEL_CALL	;AN000;
	   CALL    HANDLE_CHILDREN	;AN000;
	@@:				;AN000;
	CALL	DISPLAY_PANEL_CALL	;AN000;
	POP	AX			;AN000;
	RET				;AN000;
HANDLE_PANEL_CALL ENDP			;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	 AX,input
;	 BX,action
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUBLIC	HANDLE_PANEL_CALL2	;AN000;
HANDLE_PANEL_CALL2 PROC  FAR		;AN000;
	PUSH	AX			;AN000;
	PUSH	AX			;AN000;
	MOV	AX,BX			;AN000;DT
	CALL	INIT_PQUEUE_CALL	;AN000;DT
	POP	AX			;AN000;
	CALL	PREPARE_PANEL_CALL	;AN000;
	POP	AX			;AN000;
	PUSH	AX			;AN000;DT
	cmp AX,SUB_COPYING		;AN000;
	je @F
	   MOV	   AX,PAN_HBAR		;AN000;
	   CALL    PREPARE_PANEL_CALL	;AN000;
	   CALL    HANDLE_CHILDREN	;AN000;
	@@:				;AN000;
	CALL	DISPLAY_PANEL_CALL	;AN000;
	POP	AX			;AN000;
	RET				;AN000;
HANDLE_PANEL_CALL2 ENDP 		 ;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	 AX,input
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUBLIC	HANDLE_PANEL_CALL3	;AN111;JW
HANDLE_PANEL_CALL3 PROC  FAR		;AN111;JW
	CALL	INIT_PQUEUE_CALL	;AN111;JW
	CALL	DISPLAY_PANEL_CALL	;AN111;JW
	RET				;AN111;JW
HANDLE_PANEL_CALL3 ENDP 		;AN111;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	 AX,input
;	 BX,action
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PUBLIC	HANDLE_KEYSTROKE	;AN000;
HANDLE_KEYSTROKE  PROC	FAR		;AN000;
	MOV	CX,FK_ENT_LEN		;AN000;
	LEA	DX,FK_ENT		;AN000;
	CALL	GET_FUNCTION_CALL	;AN000;
	RET				;AN000;
HANDLE_KEYSTROKE  ENDP			;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	End of program code
;
;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	ENDS		;AN000;
	END		;AN000;
