

PAGE 55,132							;AN000;
NAME	SELECT							;AN000;
TITLE	SELECT - DOS - SELECT.EXE				;AN000;
SUBTTL	SELECT5A.asm						;AN000;
;RLC .ALPHA								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	SELECT5A.ASM : Copyright 1988 Microsoft
;
;	DATE:	 August 8/87
;
;	COMMENTS: Assemble with MASM 3.0 (using the /A option)
;
;		  Panel flow is defined in the following files:
;
;		      þ SELECT1.ASM
;		      þ SELECT2.ASM
;		      þ SELECT3.ASM
;		      þ SELECT4.ASM
;		      þ SELECT5.ASM
;		      þ SELECT6.ASM
;
;  Module contains code for :
;	- Date/Time screen
;
;	CHANGE HISTORY:
;
;		;AN002;  for DCR225
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'                              ;AN000;
	EXTRN	SEL_FLG:BYTE					;AN000;
DATA	       ENDS						;AN000;
								;
.XLIST								;AN000;
	INCLUDE    panel.mac					;AN000;
	INCLUDE    select.inc					;AN000;
	INCLUDE    castruc.inc					;AN000;
	INCLUDE    macros.inc					;AN000;
	INCLUDE    ext.inc					;AN000;
	INCLUDE    varstruc.inc 				;AN000;
	INCLUDE    rout_ext.inc 				;AN000;
	INCLUDE    pan-list.inc 				;AN000;
.LIST								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	SEGMENT PARA PUBLIC 'SELECT'                            ;AN000;segment for far routine
	ASSUME	CS:SELECT,DS:DATA				;AN000;
								;
	INCLUDE casextrn.inc					;AN000;
								;
	EXTRN	CREATE_AUTOEXEC_BAT:NEAR			;AN000;
	EXTRN	CREATE_CONFIG_SYS:NEAR				;AN000;
	EXTRN	CREATE_SHELL_BAT:NEAR				;AN000;DT
	EXTRN	SCAN_INFO_CALL:NEAR				;AN000;DT
								;
	PUBLIC	DATE_TIME_SCREEN				;AN000;
	EXTRN	PROCESS_ESC_F3:near				;AN000;
	EXTRN	FORMAT_DISK_SCREEN:near 			;AN000;
	EXTRN	EXIT_DOS:near					;AN000;
	EXTRN	INSTALL_ERROR:near				;AN000;
	EXTRN	EXIT_SELECT:NEAR				;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³DATE_TIME_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The INSTALL DATE and TIME SCREEN is presented if the active date is 1/1/80.
;  If the user is installing to drive C: , this is the first screen presented
;  after the system is reboot due to the execution of FDISK.
;  The user cannot go back to the previous screen or terminate the
;  install process from this screen.
;  If the user did not change the date or time presented on the screen,
;  no action is taken.
;  Valid keys are ENTER, F1, and numeric characters.
;  If installing from 360KB diskettes, must prompt for INSTALL diskette
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATE_TIME_SCREEN:						;AN000;
								;
	cmp N_SELECT_MODE,E_SELECT_FDISK			;AN000;DT
	jne @F
	cmp N_DISKETTE_A,E_DISKETTE_360				;AN000;DT
	jne @F
	   CALL 		CURSOROFF			;AN082;SEH
	   INSERT_DISK		SUB_INSTALL_COPY, S_SELECT_TMP	;AN000;JW
	   CALL 		SCAN_INFO_CALL			;AN000;DT
	@@:							;AN000;DT
								;
	INIT_VAR		STACK_INDEX, 0			;AN000; clear SELECT STACK
								;
	CHECK_WRITE_PROTECT	DRIVE_A, N_RETCODE		;AC000;JW
	jnc else_l_1						;AN000;
	   GOTO_ 		INSTALL_ERROR			;AN000;
	jmp short endif_l_1
	else_l_1:						;AN000;
	   OR  SEL_FLG,INSTALLRW				;AN000; indicate INSTALL diskette is R/W
	endif_l_1:						;AN000;
								;
	GET_DATE		N_YEAR, N_MONTH, N_DAY		;AN000; get system date
	jnc @F							;AN000; if system date is 1/1/1980
	   GOTO_ 		FORMAT_DISK_SCREEN		;AN000;    goto next screen (FORMAT_DISK)
	@@:							;AN000;
								;
	GET_TIME		N_HOUR, N_MINUTE, N_SECOND	;AN000; get system time
								;
	COPY_WORD		N_WORD_1, N_YEAR		;AN000; copy year to temp var
	COPY_WORD		N_WORD_2, N_MONTH		;AN000; copy month to temp var
	COPY_WORD		N_WORD_3, N_DAY 		;AN000; copy day to temp var
	COPY_WORD		N_WORD_4, N_HOUR		;AN000; copy hour to temp var
	COPY_WORD		N_WORD_5, N_MINUTE		;AN000; copy minute to temp var
	COPY_WORD		N_WORD_6, N_SECOND		;AN000; copy second to temp var
								;
	INIT_PQUEUE		PAN_DATE_TIME			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_NUMERIC		NUM_YEAR,N_WORD_1,MAX_YEAR,S_STR120_1 ;AN000; display current year
	INIT_NUMERIC		NUM_MONTH,N_WORD_2,MAX_MONTH,S_STR120_2     ;AN000; display current month
	INIT_NUMERIC		NUM_DAY,N_WORD_3,MAX_DAY,S_STR120_3   ;AN000; display current day
	INIT_NUMERIC		NUM_HOUR,N_WORD_4,MAX_HOUR,SC_LINE    ;AN000; display current hour
	INIT_NUMERIC		NUM_MINUTE,N_WORD_5,MAX_MINUTE,S_MODE_PARM  ;AN000; display current minute
	INIT_NUMERIC		NUM_SECOND,N_WORD_6,MAX_SECOND,S_CP_DRIVER  ;AN000; display current second
	CALL			CURSORON			;AN082;SEH
	DISPLAY_PANEL						;AN000;
								;
	INIT_VAR		N_COUNTER, 1			;AN000; set counter = 1
								;
DATE_TIME_LOOP: 						;AN000;
								;
	repeat_l_1: 						;AN000; repeat code block
								;
	   cmp N_COUNTER,1					;AN000;    counter = 1
	   jne select_l_1_1
	      GET_NUMERIC	NUM_YEAR,N_WORD_1,MIN_YEAR,MAX_YEAR,FK_DATE,S_STR120_1	      ;AN000; get new year value
	      COPY_WORD 	N_WORD_1, N_USER_NUMERIC	;AN000;    save new year value
								;
	   jmp endselect_l_1
	   select_l_1_1:
	   cmp N_COUNTER,2					;AN000;    counter = 2
	   jne select_l_1_2
	      GET_NUMERIC	NUM_MONTH,N_WORD_2,MIN_MONTH,MAX_MONTH,FK_DATE,S_STR120_2     ;AN000; get new month value
	      COPY_WORD 	N_WORD_2, N_USER_NUMERIC	;AN000;    save new month value
								;
	   jmp endselect_l_1
	   select_l_1_2:
	   cmp N_COUNTER,3					;AN000;    counter = 3
	   jne select_l_1_3
	      GET_NUMERIC	NUM_DAY,N_WORD_3,MIN_DAY,MAX_DAY,FK_DATE,S_STR120_3	      ;AN000; get new day value
	      COPY_WORD 	N_WORD_3, N_USER_NUMERIC	;AN000;    save new day value
								;
	   jmp endselect_l_1
	   select_l_1_3:
	   cmp N_COUNTER,4					;AN000;    counter = 4
	   jne select_l_1_4
	      GET_NUMERIC	NUM_HOUR,N_WORD_4,MIN_HOUR,MAX_HOUR,FK_DATE,SC_LINE	      ;AN000; get new hour value
	      COPY_WORD 	N_WORD_4, N_USER_NUMERIC	;AN000;    save new hour value
								;
	   jmp endselect_l_1
	   select_l_1_4:
	   cmp N_COUNTER,5					;AN000;    counter = 5
	   jne otherwise_l_1
	      GET_NUMERIC	NUM_MINUTE,N_WORD_5,MIN_MINUTE,MAX_MINUTE,FK_DATE,S_MODE_PARM ;AN000; get new minute value
	      COPY_WORD 	N_WORD_5, N_USER_NUMERIC	;AN000;    save new minute value
								;
	   jmp short endselect_l_1
	   otherwise_l_1:					;AN000;    counter = 6
	      GET_NUMERIC	NUM_SECOND,N_WORD_6,MIN_SECOND,MAX_SECOND,FK_DATE,S_CP_DRIVER ;AN000; get new second value
	      COPY_WORD 	N_WORD_6, N_USER_NUMERIC	;AN000;    save new second value
								;
	   endselect_l_1:					;AN000;
								;
	   INC_VAR		N_COUNTER			;AN000;    inc counter
								;
	   cmp N_COUNTER,6					;AN000;    if counter > 6
	   jbe @F
	      INIT_VAR		N_COUNTER, 1			;AN000;       set counter = 1
	   @@:							;AN000;
								;
	cmp N_USER_FUNC,E_ENTER					;AN000; break loop if user entered ENTER
	jne repeat_l_1
								;
	CHECK_DATE_CHANGE	N_WORD_1,N_WORD_2,N_WORD_3,N_YEAR,N_MONTH,N_DAY     ;AN000; check if new date is different
	jnc endif_l_2						;AN000; if new date different
	   SET_DATE		N_WORD_1, N_WORD_2, N_WORD_3	;AN000;    set new system date
	   jnc @F						;AN000;    if new date invalid
	      INIT_VAR		N_COUNTER, 3			;AN000;       set counter = 3
	      GOTO_		DATE_TIME_LOOP			;AN000;       goto get day again
	   @@:							;AN000;
	endif_l_2:						;AN000;
								;
	CHECK_TIME_CHANGE	N_WORD_4,N_WORD_5,N_WORD_6,N_HOUR,N_MINUTE,N_SECOND ;AN000; check if new time is different
	jnc @F							;AN000; if new time is different
	   SET_TIME		N_WORD_4, N_WORD_5, N_WORD_6	;AN000;    set new system time
	@@:							;AN000;
								;
	GOTO_			FORMAT_DISK_SCREEN		;AN000; goto next screen (FORMAT_DISK)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	ENDS							;AN000;
	END							;AN000;
