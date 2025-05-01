PAGE	,132
TITLE	PRINTER.SYS INT2FH Code

;****************** START OF SPECIFICATIONS **************************
;
;  MODULE NAME: PRTINT2F.ASM
;
;  DESCRIPTIVE NAME: PERFORM THE INT2FH FUNCTION OF PRINTER.SYS
;
;  FUNCTION: THE INT2FH FUNCTION OF PRINTER.SYS WILL LOCK THE PRINTER
;	     DEVICE AND LOAD THE CODE PAGE SPECIFIED.  WHEN AN UNLOCK
;	     IS ENCOUNTERED, THE SAVED CODE PAGE WILL BE ACTIVATED.
;	     ATTACHED.
;
;  ENTRY POINT: INT2F_COM
;
;  INPUT: AX = AD40H (CALL IDENTIFIER)
;	  BX = REQUESTED CODE PAGE (-1 FOR UNLOCK)
;	  DX = 0 - LPT1
;	       1 - LPT2
;	       2 - LPT3
;
;  AT EXIT:
;     NORMAL: CARRY CLEAR
;
;     ERROR: CARRY SET - CODE PAGE NOT AVAILABLE OR DEVICE IS NOT CPSW.
;
;  INTERNAL REFERENCES:
;
;     ROUTINES: CHECK_FOR_CP - CHECKS TO SEE IF CODE PAGE REQUESTED IS
;			       AVAILABLE ON DEVICE REQUESTED.
;		FIND_ACTIVE_CP - FINDS THE ACTIVE CODE PAGE ON SPECIFIED
;				 DEVICE; IF AVAILABLE.
;		LOCK_CP - VERIFIES, LOADS, AND LOCKS DEVICE CODE PAGE.
;		UNLOCK_CP - UNLOCKS DEVICE.
;
;     DATA AREAS: INVOKE_BLOCK - PARAMETER BLOCK PASSED TO INVOKE_ PROC.
;
;
;  EXTERNAL REFERENCES:
;
;     ROUTINES: INVOKE_ - ACTIVATES FONT REQUESTED.
;
;     DATA AREAS: BUF1 - BUFFER FOR LPT1
;		  BUF2 - BUFFER FOR LPT2
;		  BUF3 - BUFFER FOR LPT3
;
;  NOTES:
;
;  REVISION HISTORY:
;	 A000 - DOS Version 4.00
;
;      Label: "DOS PRINTER.SYS Device Driver"
;	      "Version 4.00 (C) Copyright 1988 Microsoft
;	      "Licensed Material - Program Property of Microsoft"
;
;****************** END OF SPECIFICATIONS ****************************


INCLUDE   cpspequ.inc								    ;AN000;
PRIV_LK_CP   EQU    0AD40H	       ; multiplex number and function		    ;AN000;
LPT1	     EQU    0		       ;					    ;AN000;
LPT2	     EQU    1		       ;					    ;AN000;
LPT3	     EQU    2		       ;					    ;AN000;
UNLOCK	     EQU    -1		       ; unlock the device			    ;AN000;
UNDEFINED    EQU    -1		       ; undefined code page			    ;AN000;
NOT_CY	     EQU    0FFFEH	       ; clear the carry in flag register	    ;AN000;
CY	     EQU    1		       ; set the carry in flag register 	    ;AN000;
FOUND	     EQU    1		       ; search flag				    ;AN000;
NOT_FOUND    EQU    0		       ;					    ;AN000;


PUBLIC	INT2F_COM								    ;AN000;
PUBLIC	ROM_INT2F								    ;AN000;
PUBLIC	ABORT									    ;AN000;


CSEG	SEGMENT PARA PUBLIC 'CODE'                                                  ;AN000;
	ASSUME CS:CSEG								    ;AN000;


EXTRN	INVOKE_:NEAR								    ;AN000;
EXTRN	BUF0:BYTE								    ;AN000;
EXTRN	BUF1:BYTE								    ;AN000;
EXTRN	BUF2:BYTE								    ;AN000;
EXTRN	BUF3:BYTE								    ;AN000;

ROM_INT2F    DW     ?		       ; chaining point for INT2FH		    ;AN000;
	     DW     ?								    ;AN000;

COPY_BUF0    DW     0								    ;AN000;
PREV_LOCK    DB     OFF 							    ;AN000;

INVOKE_BLOCK LABEL  BYTE	       ; parameter block passed to INVOKE_	    ;AN000;
	     DB     3 DUP(0)	       ;					    ;AN000;
RET_STAT     DW     0		       ; returned status from INVOKE_		    ;AN000;
	     DQ     0		       ;					    ;AN000;
	     DB     6 DUP(0)	       ;					    ;AN000;
	     DW     OFFSET PARA_BLOCK  ;					    ;AN000;
CODE_SEGB    DW     SEG CSEG	       ;					    ;AN000;
				       ;
PARA_BLOCK   LABEL  WORD	       ;					    ;AN000;
	     DW     TWO 	       ;					    ;AN000;
REQ_CP	     DW     ?		       ; requested code page to load		    ;AN000;
				       ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; PROCEDURE_NAME: INT2F_COM
;
; FUNCTION:
; THIS IS THE INTERRUPT 2FH HANDLER TO CAPTURE THE FOLLOWING FUNCTIONS:
;
;   AX=AD40H PRIVELEGED LOCK CP SWITCHING
;
; AT ENTRY: AX = AD40H
;	    BX = CODEPAGE REQUESTED DURING LOCK.
;		 -1 = UNLOCK
;	    DX = 0 - LPT1
;		 1 - LPT2
;		 2 - LPT3
;
;
; AT EXIT:
;    NORMAL: CARRY CLEAR - DEVICE LOADED AND LOCKED
;
;    ERROR: CARRY SET - CODE PAGE NOT AVAILABLE OR DEVICE NOT CPSW.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


INT2F_COM  PROC   NEAR								    ;AN000;
	   STI									    ;AN000;
	   cmp AX,PRIV_LK_CP			; is this for PRINTER?		    ;AN000;
	   je @F
	     JMP    DWORD PTR CS:ROM_INT2F	; no....jump to old INT2F	    ;AN000;
	   @@:					;				    ;AN000;
	   PUSH   AX				;				    ;AN000;
	   PUSH   BP				;				    ;AN000;
	   PUSH   BX				; s    r			    ;AN000;
	   PUSH   CX				;  a	e			    ;AN000;
	   PUSH   DX				;   v	 g			    ;AN000;
	   PUSH   DI				;    e	  s			    ;AN000;
	   PUSH   SI				;				    ;AN000;
	   PUSH   DS				;				    ;AN000;
	   PUSH   ES				;				    ;AN000;
	   MOV	  CS:COPY_BUF0,ZERO		;				    ;AN000;
	   MOV	  CS:CODE_SEGB,CS		;				    ;AN000;
	   MOV	  BP,BX 			; move req. cp to bp		    ;AN000;
	   cmp DX,LPT1				; depending on the lptx..	    ;AN000;
	   jne select_l_1_1			; point to the appropriate	    ;AN000;
	     LEA   BX,BUF1			; buffer..			    ;AN000;
	     LEA   SI,BUF0			;				    ;AN000;
	     MOV   CS:COPY_BUF0,SI		;				    ;AN000;
	   jmp endselect_l_1
	   select_l_1_1:
	   cmp DX,LPT2				;				    ;AN000;
	   jne select_l_1_2
	     LEA   BX,BUF2			;				    ;AN000;
	   jmp endselect_l_1
	   select_l_1_2:
	   cmp DX,LPT3				;				    ;AN000;
	   jne otherwise_l_1
	     LEA   BX,BUF3			;				    ;AN000;
	   jmp endselect_l_1
	   otherwise_l_1:			;				    ;AN000;
	     STC				; not a valid lptx..set flag	    ;AN000;
	   endselect_l_1:			;				    ;AN000;
	   jc endif_l_2				; process			    ;AN000;
	     cmp BP,UNLOCK	 		; if unlock requested		    ;AN000;
	     jne else_l_1
	       CALL   UNLOCK_CP 		; unlock code page.		    ;AN000;
	     jmp endif_l_1
	     else_l_1:				; must be a lock request..	    ;AN000;
	       CALL   LOCK_CP			;				    ;AN000;
	     endif_l_1:				;				    ;AN000;
	   endif_l_2:				;				    ;AN000;
	   MOV	  SI,CS:COPY_BUF0		;				    ;AN000;
	   PUSHF				;				    ;AN000;
	   cmp SI,ZERO				; if this is lpt1...		    ;AN000;
	   je @F
	     MOV    AX,CS:[BX].STATE		; copy data into prn		    ;AN000;
	     MOV    CS:[SI].STATE,AX		; buffer as well.		    ;AN000;
	     MOV    AX,CS:[BX].SAVED_CP 	;				    ;AN000;
	     MOV    CS:[SI].SAVED_CP,AX 	;				    ;AN000;
	   @@:					;				    ;AN000;
	   POPF 				;				    ;AN000;
	   POP	  ES				;				    ;AN000;
	   POP	  DS				; restore			    ;AN000;
	   POP	  SI				;				    ;AN000;
	   POP	  DI				;    registers			    ;AN000;
	   POP	  DX				;				    ;AN000;
	   POP	  CX				;				    ;AN000;
	   POP	  BX				;				    ;AN000;
	   MOV	  BP,SP 			;				    ;AN000;
	   MOV	  AX,[BP+8]			; load flag onto..		    ;AN000;
	   jc else_l_3				;				    ;AN000;
	     AND    AX,NOT_CY			;				    ;AN000;
	   jmp endif_l_3
	   else_l_3:				;    stack flags		    ;AN000;
	     OR     AX,CY			;				    ;AN000;
	   endif_l_3:				;				    ;AN000;
	   MOV	  [BP+8],AX			;				    ;AN000;
	   POP	  BP				;				    ;AN000;
	   POP	  AX				;				    ;AN000;
	   XCHG   AH,AL 			; exchange ah and al to show that.. ;AN000;
ABORT:	   IRET 				; printer.sys is present.	    ;AN000;
INT2F_COM  ENDP 								    ;AN000;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; PROCEDURE_NAME: UNLOCK_CP
;
; FUNCTION:
; THIS FUNCTION UNLOCKS THE DEVICE THAT IS LOCKED.
;
; AT ENTRY:
;	    BX - POINTS TO LPTx BUFFER
;
;
; AT EXIT:
;    NORMAL: CARRY CLEAR - DEVICE UNLOCKED.
;
;    ERROR: CARRY SET - ERROR DURING UNLOCK, ACTIVE CODE PAGE SET TO INACTIVE
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UNLOCK_CP      PROC  NEAR							    ;AN000;
	       cmp CS:[BX].STATE,LOCKED		  ; is device locked?		    ;AN000;
	       jne endif_l_7
		 MOV   CS:[BX].STATE,CPSW	  ; change status to unlocked..     ;AN000;
		 MOV   BP,CS:[BX].SAVED_CP	  ; get saved code page 	    ;AN000;
		 cmp BP,UNDEFINED		  ; valid?..... 		    ;AN000;
		 je else_l_6
		   XOR	  AX,AX 		  ;				    ;AN000;
		   CALL   FIND_ACTIVE_CP	  ; find the active code page.	    ;AN000;
		   cmp BP,DX			  ; are they the same..?	    ;AN000;
		   je else_l_5
		     MOV    CS:REQ_CP,BP	  ; no...invoke the saved code page ;AN000;
		     PUSH   CS			  ;				    ;AN000;
		     POP    ES			  ;				    ;AN000;
		     LEA    DI,INVOKE_BLOCK	  ;				    ;AN000;
		     MOV    CS:[BX].RH_PTRO,DI	  ;				    ;AN000;
		     MOV    CS:[BX].RH_PTRS,ES	  ;				    ;AN000;
		     CALL   INVOKE_		  ;				    ;AN000;
		     cmp AL,ZERO		  ; error on invoke?		    ;AN000;
		     je else_l_4
		       MOV    AX,ONE		  ; yes...change the active..	    ;AN000;
		       CALL   FIND_ACTIVE_CP	  ; to inactive.		    ;AN000;
		       cmp CS:COPY_BUF0,ZERO	  ; do likewise to PRN if this	    ;AN000;
		       je @F
			 PUSH	 BX		  ; is lpt1.			    ;AN000;
			 MOV	 BX,CS:COPY_BUF0  ;				    ;AN000;
			 CALL	 FIND_ACTIVE_CP   ;				    ;AN000;
			 POP	 BX		  ;				    ;AN000;
		       @@:			  ;				    ;AN000;
		       STC			  ; set error flag.		    ;AN000;
		     jmp endif_l_6
		     else_l_4:			  ;				    ;AN000;
		       CLC			  ; invoke ok...clear error flag    ;AN000;
		     endif_l_4:			  ;				    ;AN000;
		   jmp endif_l_6
		   else_l_5:			  ;				    ;AN000;
		     CLC			  ; active = saved ..no invoke...   ;AN000;
		   endif_l_5:			  ; clear error 		    ;AN000;
		 jmp endif_l_6
		 else_l_6:			  ;				    ;AN000;
		   MOV	  AX,ONE		  ; saved cp was inactive...change..;AN000;
		   CALL   FIND_ACTIVE_CP	  ; active to inactive. 	    ;AN000;
		   cmp CS:COPY_BUF0,ZERO	  ; do likewise to PRN if this	    ;AN000;
		   je @F
		     PUSH    BX 		  ; is lpt1.			    ;AN000;
		     MOV     BX,CS:COPY_BUF0	  ;				    ;AN000;
		     CALL    FIND_ACTIVE_CP	  ;				    ;AN000;
		     POP     BX 		  ;				    ;AN000;
		   @@:				  ;				    ;AN000;
		   CLC				  ;				    ;AN000;
		 endif_l_6: 			  ;				    ;AN000;
		 MOV	CS:[BX].SAVED_CP,UNDEFINED; reset the saved cp		    ;AN000;
	       endif_l_7:			  ;				    ;AN000;
	       RET								    ;AN000;
UNLOCK_CP      ENDP								    ;AN000;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; PROCEDURE_NAME: LOCK_CP
;
; FUNCTION:
; THIS FUNCTION LOCKS THE DEVICE WITH THE CODE PAGE REQUESTED.
;
; AT ENTRY: BP - REQUESTED CODE PAGE
;	    BX - POINTS TO LPTx BUFFER
;
;
; AT EXIT:
;    NORMAL: CARRY CLEAR - DEVICE LOCKED.
;
;    ERROR: CARRY SET - ERROR, CODE PAGE NOT LOCKED.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOCK_CP        PROC   NEAR							    ;AN000;
	       cmp CS:[BX].STATE,LOCKED		; if this was previously locked..   ;AN000;
	       jne elseif_l_8
		 MOV	CS:PREV_LOCK,ON 	; then...set flag and...	    ;AN000;
		 MOV	CS:[BX].STATE,CPSW	; change to unlock for this proc    ;AN000;
	       jmp endif_l_8
	       elseif_l_8:
	       cmp CS:[BX].STATE,CPSW		; if this is unlocked...	    ;AN000;
	       jne else_l_8
		 MOV	CS:PREV_LOCK,OFF	; then set flag off.		    ;AN000;
	       jmp endif_l_8
	       else_l_8:			;				    ;AN000;
		 STC				; neither...set error		    ;AN000;
	       endif_l_8:			;				    ;AN000;
	       jc endif_l_12			;				    ;AN000;
		 CALL	CHECK_FOR_CP		; yes..see if req cp is available.  ;AN000;
		 jc endif_l_11 			; yes...			    ;AN000;
		   XOR	   AX,AX		;				    ;AN000;
		   CALL    FIND_ACTIVE_CP	; find the active code page	    ;AN000;
		   cmp BP,DX			; is it the same as requested?..    ;AN000;
		   je else_l_10
		     MOV    CS:REQ_CP,BP	; no..invoke the requested cp	    ;AN000;
		     PUSH   CS			;				    ;AN000;
		     POP    ES			;				    ;AN000;
		     LEA    DI,INVOKE_BLOCK	;				    ;AN000;
		     MOV    CS:[BX].RH_PTRO,DI	;				    ;AN000;
		     MOV    CS:[BX].RH_PTRS,ES	;				    ;AN000;
		     PUSH   DX			;				    ;AN000;
		     CALL   INVOKE_		;				    ;AN000;
		     POP    DX			;				    ;AN000;
		     cmp AL,ZERO		; error on invoke?		    ;AN000;
		     je else_l_9
		       STC			; yes...set error flag. 	    ;AN000;
		     jmp endif_l_10
		     else_l_9:			;				    ;AN000;
		       MOV    CS:[BX].STATE,LOCKED ; no, 'lock' the printer device  ;AN000;
		       cmp CS:PREV_LOCK,OFF	; if we were not locked..	    ;AN000;
		       jne @F
			 MOV	CS:[BX].SAVED_CP,DX ; and..save the old code page.  ;AN000;
		       @@:			;				    ;AN000;
		       CLC			; clear error flag.		    ;AN000;
		     endif_l_9:			;				    ;AN000;
		   jmp endif_l_10
		   else_l_10:			;				    ;AN000;
		     MOV    CS:[BX].STATE,LOCKED ; 'lock' the printer device        ;AN000;
		     cmp CS:PREV_LOCK,OFF	; if we were not locked..	    ;AN000;
		     jne @F
		       MOV    CS:[BX].SAVED_CP,DX ; and..save the old code page.    ;AN000;
		     @@:			;				    ;AN000;
		     CLC			; clear the error flag		    ;AN000;
		   endif_l_10:			;				    ;AN000;
		 endif_l_11: 			;				    ;AN000;
	       endif_l_12:			;				    ;AN000;
	       RET								    ;AN000;
LOCK_CP        ENDP								    ;AN000;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; PROCEDURE_NAME: CHECK_FOR_CP
;
; FUNCTION:
; THIS FUNCTION SEARCHES FOR THE CODE PAGE REQUESTED TO SEE IF IT HAS
; BEEN PREPARED OR IS A HARDWARE CODE PAGE
;
;
; AT ENTRY: BP = CODE PAGE REQUESTED
;	    BX - POINTS TO LPTx BUFFER
;
;
; AT EXIT:
;    NORMAL: CARRY CLEAR - CODE PAGE IS VALID.
;
;    ERROR: CARRY SET - CODE PAGE NOT AVAILABLE.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


CHECK_FOR_CP  PROC   NEAR							    ;AN000;
	      PUSH   DX 							    ;AN000;
	      MOV    DX,NOT_FOUND		; initialize flag		    ;AN000;
	      MOV    CX,CS:[BX].RSLMX		; load number of RAM slots	    ;AN000;
	      MOV    DI,CS:[BX].RAMSO		; load DI with table offset	    ;AN000;
	      while_l_1:
	      cmp DX,NOT_FOUND			; whil not found and....	    ;AN000;
	      jne endwhile_l_1
	      cmp CX,ZERO			; while  still slots to check..     ;AN000;
	      je endwhile_l_1
		cmp CS:[DI].SLT_CP,BP		; is it this one??		    ;AN000;
		jne else_l_13
		  MOV	 DX,FOUND		; yes....set flag		    ;AN000;
		jmp while_l_1
		else_l_13:			;				    ;AN000;
		  ADD	 DI,TYPE SLTS		; no..point to next entry	    ;AN000;
		  DEC	 CX			; decrement the count		    ;AN000;
		endif_l_13:			;				    ;AN000;
	      jmp while_l_1
	      endwhile_l_1: 			;				    ;AN000;
	      cmp DX,NOT_FOUND			; if we didn't find it then..       ;AN000;
	      jne endif_l_15
		MOV    CX,CS:[BX].HSLMX 	; check hardware		    ;AN000;
		MOV    DI,CS:[BX].HARDSO	; load regs as before.		    ;AN000;
		while_l_2:
		cmp DX,NOT_FOUND		; while not found and.. 	    ;AN000;
		jne endwhile_l_2
		cmp CX,ZERO			; still have slots to check..	    ;AN000;
		je endwhile_l_2
		  cmp CS:[DI].SLT_CP,BP		; is it this one?		    ;AN000;
		  jne else_l_14
		    MOV    DX,FOUND		; yes...set flag.		    ;AN000;
		  jmp while_l_2
		  else_l_14: 			;				    ;AN000;
		    ADD    DI,TYPE SLTS 	; no ..point to next entry	    ;AN000;
		    DEC    CX			; and decrement count.		    ;AN000;
		  endif_l_14:			;				    ;AN000;
		jmp while_l_2
		endwhile_l_2:			;				    ;AN000;
	      endif_l_15:			;				    ;AN000;
	      cmp DX,NOT_FOUND			;				    ;AN000;
	      jne else_l_16
		STC				; set flag appropriately	    ;AN000;
	      jmp endif_l_16
	      else_l_16:			;				    ;AN000;
		CLC				;				    ;AN000;
	      endif_l_16:			;				    ;AN000;
	      POP    DX 			;				    ;AN000;
	      RET				;				    ;AN000;
CHECK_FOR_CP  ENDP								    ;AN000;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; PROCEDURE_NAME: FIND_ACTIVE_CP
;
; FUNCTION:
; THIS FUNCTION SEARCHES FOR THE ACTIVE CODE PAGE. IF REQUESTED, THE
; CODE PAGE IS MADE INACTIVE.
;
;
; AT ENTRY:
;	    BX - POINTS TO LPTx BUFFER
;	    AX = 0 - LEAVE AS ACTIVE
;	    AX = 1 - DE-ACTIVATE
;
;
; AT EXIT:
;    NORMAL: DX - ACTIVE CODE PAGE.  (NO ACTIVE = -1)
;
;    ERROR: N/A
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


FIND_ACTIVE_CP PROC   NEAR							    ;AN000;
	       MOV    DX,UNDEFINED		 ; initialize register		    ;AN000;
	       MOV    CX,CS:[BX].RSLMX		 ; load number of RAM slots	    ;AN000;
	       MOV    DI,CS:[BX].RAMSO		 ; load DI with table offset	    ;AN000;
	       while_l_3:
	       cmp DX,UNDEFINED			 ; whil not found and....	    ;AN000;
	       jne endwhile_l_3
	       cmp CX,ZERO			 ; while still slots to check..     ;AN000;
	       je endwhile_l_3
		 test CS:[DI].SLT_AT,AT_ACT	 ; is it this one?? 	    ;AN000;
		 jz else_l_17
		   MOV	  DX,CS:[DI].SLT_CP	 ; yes....load value		    ;AN000;
		   cmp AX,ONE			 ; is deactivate requested?	    ;AN000;
		   jne while_l_3
		     MOV    CS:[DI].SLT_AT,AT_OCC; yes...change attrib. to occupied ;AN000;
		 jmp while_l_3			 ;				    ;AN000;
		 else_l_17:			 ;				    ;AN000;
		   ADD	  DI,TYPE SLTS		 ; no..point to next entry	    ;AN000;
		   DEC	  CX			 ; decrement the count		    ;AN000;
		 endif_l_17: 			 ;				    ;AN000;
	       jmp while_l_3
	       endwhile_l_3:			 ;				    ;AN000;
	       cmp DX,UNDEFINED			 ; if we didn't find it then..      ;AN000;
	       jne endif_l_19
		 MOV	CX,CS:[BX].HSLMX	 ; check hardware		    ;AN000;
		 MOV	DI,CS:[BX].HARDSO	 ; load regs as before. 	    ;AN000;
		 while_l_4:
		 cmp DX,UNDEFINED		 ; while not found and..	    ;AN000;
		 jne endwhile_l_4
		 cmp CX,ZERO			 ; still have slots to check..	    ;AN000;
		 je endwhile_l_4
		   test CS:[DI].SLT_AT,AT_ACT	 ; is it this one??	    ;AN000;
		   jz else_l_18
		     MOV    DX,CS:[DI].SLT_CP	 ; yes....load value		    ;AN000;
		     cmp AX,ONE			 ; is deactivate requested?	    ;AN000;
		     jne while_l_4
		       MOV    CS:[DI].SLT_AT,AT_OCC; yes...change attrib to occupied;AN000;
		   jmp while_l_4		 ;				    ;AN000;
		   else_l_18:			 ;				    ;AN000;
		     ADD    DI,TYPE SLTS	 ; no ..point to next entry	    ;AN000;
		     DEC    CX			 ; and decrement count. 	    ;AN000;
		   endif_l_18:			 ;				    ;AN000;
		 jmp while_l_4
		 endwhile_l_4:			 ;				    ;AN000;
	       endif_l_19:			 ;				    ;AN000;
	       RET				 ;				    ;AN000;
FIND_ACTIVE_CP ENDP								    ;AN000;

CSEG	   ENDS
	   END
