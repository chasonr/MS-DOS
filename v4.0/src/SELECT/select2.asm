

PAGE	55,132							;AN000;
NAME	SELECT							;AN000;
TITLE	SELECT - DOS - SELECT.EXE				;AN000;
SUBTTL	SELECT2.asm						;AN000;
;RLC .ALPHA								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	SELECT2.ASM : Copyright 1988 Microsoft
;
;	DATE:	 August 8/87
;
;	COMMENTS: Assemble with MASM 3.0 (using the -A option)
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
;
;  Module contains code for :
;	- Program/Memory workspace screen
;	- Predefined country/keyboard screen
;	- Country screen
;	- Keyboard screen
;	- Alternate Keyboard screen
;	- Load the specified keyboard
;	- Install drive screen
;	- DOS location screen
;
;	CHANGE HISTORY:
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'                              ;AN000;
	EXTRN  EXEC_ERR:BYTE					;
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
								;
	PUBLIC	WORKSPACE_SCREEN				;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	SEGMENT PARA PUBLIC 'SELECT'                            ;AN000;
	ASSUME	CS:SELECT,DS:DATA				;AN000;
								;
	INCLUDE casextrn.inc					;AN000;
								;
	EXTRN	EXIT_DOS:NEAR					;AN000;
	EXTRN	EXIT_SELECT:NEAR				;AN000;
	EXTRN	PROCESS_ESC_F3:NEAR				;AN000;
	EXTRN	INTRO_SCREEN:NEAR				;AN000;
	EXTRN	DOS_LOC_SCREEN:NEAR				;AN000;
	EXTRN	DEALLOCATE_MEMORY_CALL:FAR			;AN000;DT
	EXTRN	GET_OVERLAY:NEAR				;AN000;DT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³WORKSPACE_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The User Function and Memory Workspace Needs Screen is always presented.
;  The screen allows the user to define the memory requirements for
;  the install process.  Default values for DOS commands will be assigned based
;  on user input.
;  Valid keys are ENTER, ESC, F1, cursor up/down and numeric 1 to 3.
;
;  All values are re-initialized the second time round only if the new option
;  is different from the previously selected option.
;
; ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
; ³		 ³  I_WORKSPACE=1 ³  I_WORKSPACE=2 ³  I_WORKSPACE=3 ³
; ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
; ³ P_BREAK	 ³  'ON'          ³  'ON'          ³  'ON'          ³
; ³ P_BUFFERS	 ³  ' '           ³  '20'          ³  '50,4'        ³
; ³ P_CPSW	 ³  'OFF'         ³  'OFF'         ³  'OFF'         ³
; ³ F_CPSW	 ³  no		  ³  no 	   ³  no	    ³
; ³ P_FCBS	 ³  ' '           ³  ' '           ³  '20,8'        ³
; ³ P_FILES	 ³  '8'           ³  '20'          ³  '20'          ³
; ³ P_LASTDRIVE  ³  'E'           ³  'E'           ³  'E'           ³
; ³ P_STACKS	 ³  ' '           ³  ' '           ³  ' '           ³
; ³ P_VERIFY	 ³  'OFF'         ³  'OFF'         ³  'OFF'         ³
; ³ P_PROMPT	 ³  '$P$G'        ³  '$P$G'        ³  '$P$G'        ³
; ³ F_PROMPT	 ³  no		  ³  no 	   ³  no	    ³
; ³ P_PATH	 ³  ' '           ³  ' '           ³  ' '           ³
; ³ F_PATH	 ³  no		  ³  no 	   ³  no	    ³
; ³ P_APPEND	 ³  ' '           ³  ' '           ³  ' '           ³
; ³ F_APPEND	 ³  no		  ³  no 	   ³  no	    ³
; ³ P_ANSI	 ³  ' '           ³  ' '           ³  '/X'          ³
; ³ F_ANSI	 ³  no		  ³  yes	   ³  yes	    ³
; ³ P_FASTOPEN	 ³  ' '           ³  'C:=(50,25)'  ³  'C:=(100,200)'³
; ³ F_FASTOPEN	 ³  no		  ³  yes	   ³  yes	    ³
; ³ F_GRAFTABL	 ³  no		  ³  no 	   ³  no	    ³
; ³ P_GRAPHICS	 ³  ' '           ³  ' '           ³  ' '           ³
; ³ F_GRAPHICS	 ³  no		  ³  yes	   ³  yes	    ³
; ³ P_SHARE	 ³  ' '           ³  ' '           ³  ' '           ³
; ³ F_SHARE	 ³  no		  ³  no 	   ³  no	    ³
; ³ P_SHELL	 ³  '/R'          ³  '/R'          ³  '/R'          ³
; ³ F_SHELL	 ³  yes 	  ³  yes	   ³  yes	    ³
; ³ P_VDISK	 ³  ' '           ³  ' '           ³  ' '           ³
; ³ F_VDISK	 ³  no		  ³  no 	   ³  no	    ³
; ³ P_XMAEM	 ³  ' '           ³  ' '           ³  ' '           ³
; ³ DOS_LOC	 ³  'DOS'         ³  'DOS'         ³  'DOS'         ³
; ³ F_XMA	 ³  yes 	  ³  yes	   ³  yes	    ³
; ³ P_XMA2EMS	 ³  'FRAME=D000 P254=C800 P255=CC00' for all options³
; ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WORKSPACE_SCREEN:						;AN000;
	INIT_PQUEUE		PAN_WORKSPACE			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_SCROLL		SCR_DOS_SUPPORT,I_WORKSPACE	;AN000;
	DISPLAY_PANEL						;AN000; display WORKSPACE panel
								;
	GET_SCROLL		SCR_DOS_SUPPORT,I_WORKSPACE,FK_SCROLL ;AN000; get user entered option
	cmp N_USER_FUNC,E_F3					;AN027;SEH  Added to prevent going to Intro Screen
	jne elseif_l_2
	    GOTO_	     EXIT_DOS				;AN027;SEH     when F3 hit
	jmp endif_l_2
	elseif_l_2:
	cmp N_USER_FUNC,E_ENTER			 		;AN000; if user entered ENTER key
	jne else_l_2						;AN000;
	   PUSH_HEADING 	WORKSPACE_SCREEN		;AN000;    save screen address on SELECT STACK
	   COMP_WORDS		N_WORK_PREV, I_USER_INDEX	;AN000;    compare previous and new options
	   jz endif_l_1		 				;AN000;    if new option is different
	      COPY_WORD 	I_WORKSPACE, I_USER_INDEX	;AN000;       set current option = new option
	      COPY_WORD 	N_WORK_PREV, I_USER_INDEX	;AN000;       set previous option = new option
								;
	      cmp I_WORKSPACE,E_WORKSPACE_MIN			;AN000;       option =	minimize DOS functions
	      jne select_l_1_1
		 INIT_VAR_MINIMIZE				;AN000; 	  initialize variables
								;
	      jmp endselect_l_1
	      select_l_1_1:
	      cmp I_WORKSPACE,E_WORKSPACE_BAL			;AN000;       option =	balance DOS functions
	      jne otherwise_l_1
		 INIT_VAR_BALANCE				;AN000; 	 initialize variables
								;
	      jmp short endselect_l_1
	      otherwise_l_1:					;AN000;       option = maximize DOS functions
		 INIT_VAR_MAXIMIZE				;AN000; 	  initialize variables
								;
	      endselect_l_1:					;AN000;
								;
	   endif_l_1:						;AN000;
	   GOTO_ 		CTY_KYBD_SCREEN 		;AN000;    goto the next screen (CTY-KYBD)
	jmp short endif_l_2
	else_l_2:						;AN000;
	   GOTO_ 		INTRO_SCREEN			;AN001;GHG; user entered ENTER or ESC, take action
	endif_l_2:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³CTY_KYBD_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The COUNTRY and KEYBOARD support screen is always presented.
;  The screen allows the user to choose the pre-defined country and
;  keyboard displayed or to select a country specific support.
;  When the screen is presented for the first time, the pre-defined
;  country is the country code in the CONFIG.SYS file obtained by a DOS call.
;  The pre-defined keyboard is the
;  default keyboard associated with the pre-defined country.  If there is no
;  valid keyboard association, "None" is displayed.  Subsequent presentation of
;  this screen will display the user selected support.
;  Two keyboards are associated with the Swiss country code; French and
;  German.  The keyboard code to be used will be identified during translation
;  and will be saved in the form of a panel.
;  Valid keys are ENTER, ESC, F1, F3, cursor up/down, numeric 1 to 2.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CTY_KYBD_SCREEN:						;AN000;
	COPY_WORD		N_WORD_1, I_COUNTRY		;AN000; scroll list item = country index
	cmp N_CTY_LIST,E_CTY_LIST_2				;AN000; if country list = 2
	jne short @F						;AN000;
	   ADD_WORD		N_WORD_1, CTY_A_ITEMS		;AN000;    add items in list 1
	@@:							;AN000;
								;
	cmp N_KYBD_ALT,E_KYBD_ALT_NO				;AN000; if no alt kyb id
	jne else_l_3						;AN000;
	   COPY_WORD		N_WORD_2, I_KEYBOARD		;AN000;    scroll list item = keyboard index
	   cmp N_KYBD_LIST,E_KYBD_LIST_2	 		;AN000;    if kybd list = 2
	   jne short endif_l_3					;AN000;
	      ADD_WORD		N_WORD_2, KYBD_A_ITEMS		;AN000;       add items in list 1
	jmp short endif_l_3
	else_l_3:						;AN000; else
								;
	   INIT_VAR		N_WORD_2, KYBD_A_ITEMS		;AN000;    scroll list item = items in list 1
	   ADD_WORD		N_WORD_2, KYBD_B_ITEMS		;AN000; 		      + items in list 2
	   ADD_WORD		N_WORD_2, 1			;AN000; 	    + 1st item in French alt kybd
	   cmp ALT_KYB_ID,ALT_FRENCH				;AN000;    if alt kybd id > French
	   jle short @F						;AN000;
	      ADD_WORD		N_WORD_2, ALT_FR_ITEMS		;AN000;       add items in French alt kybd to list
	   @@:							;AN000;GHG
	   cmp ALT_KYB_ID,ALT_ITALIAN				;AN000;GHG if alt kybd id > Italian
	   jle short @F						;AN000;
	      ADD_WORD		N_WORD_2, ALT_IT_ITEMS		;AN000;       add items in Italian alt kybd to list
	   @@:							;AN000;
								;
	    DEC 		    N_WORD_2			;AN090;GHG  These two lines were moved inside the
	    ADD_WORD		    N_WORD_2, I_KYBD_ALT	;AN090;GHG    ELSE clause.
								;
	endif_l_3:						;AN000;
								;
								;
	INIT_PQUEUE		PAN_CTY_KYB			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_SCROLL		SCR_ACC_CTY, N_WORD_1		;AN000; display current country
	INIT_SCROLL		SCR_ACC_KYB, N_WORD_2		;AN000; display current keyboard
	INIT_SCROLL		SCR_CTY_KYB, I_CTY_KYBD 	;AN000;
	DISPLAY_PANEL						;AN000; display screen
								;
	GET_SCROLL		SCR_CTY_KYB,I_CTY_KYBD,FK_SCROLL;AN000; get new option
								;
	cmp N_USER_FUNC,E_ENTER					;AN000; if user entered ENTER key
	jne short else_l_4					;AN000;
	   COPY_WORD		I_CTY_KYBD, I_USER_INDEX	;AN000;    save new option
	   PUSH_HEADING 	CTY_KYBD_SCREEN 		;AN000;    save screen address on SELECT STACK
	   GOTO_ 		COUNTRY_SCREEN			;AN000;    goto the next screen (COUNTRY)
	jmp short endif_l_4
	else_l_4:						;AN000;
	   GOTO_ 		PROCESS_ESC_F3			;AN000; user entered ESC or F3, take action
	endif_l_4:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³COUNTRY_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The COUNTRY CODE screen is presented if the user selected to define
;  country specific support (CTY_KYBD_SCREEN).
;  When this screen is presented for the first time, the current
;  country obtained from DOS will be highlighted.  Subsequent presentations
;  of this screen will highlight the user selected country.
;  Code Page to be used will be determined by the selected country code.
;  Valid keys are ENTER, ESC, F1, F3, cursor up/down.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COUNTRY_SCREEN: 						;AN000;
	cmp I_CTY_KYBD,E_CTY_KB_PREDEF				;AN000; if accept pre-defined support
	jne @F							;AN000;
	   GOTO_ 		LOAD_KEYBOARD			;AN000;    goto load specified kybd id
	@@:							;AN000;
								;
	INIT_PQUEUE		PAN_COUNTRY			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_SCROLL		SCR_CTY_1, 0			;AN000; init 1st scroll list
	INIT_SCROLL		SCR_CTY_2, 0			;AN000; init 2nd scroll list
	DISPLAY_PANEL						;AN000; display COUNTRY panel
								;
	cmp N_CTY_LIST,E_CTY_LIST_1				;AN000; if country is in list 1
	jne short else_l_5					;AN000;
	   GET_SCROLL		SCR_CTY_1,I_COUNTRY, FK_SCROLL	;AN000;    highlight country in list 1 & get new choice
	jmp short endif_l_5
	else_l_5:						;AN000; else
	   GET_SCROLL		SCR_CTY_2, I_COUNTRY, FK_SCROLL ;AN000;     highlight country in list 2 & get new choice
	endif_l_5:						;AN000;
								;
	repeat_l_1: 						;AN000; repeat code block: CASS cannot do this automatically
	   cmp N_USER_FUNC,UPARROW				;AN000; if user entered cursor up
	   jne elseif_l_8					;AN000;
	      cmp N_CTY_LIST,E_CTY_LIST_1			;AN000;    if country list = 1
	      jne else_l_6					;AN000;
		 INIT_VAR	N_CTY_LIST, E_CTY_LIST_2	;AN000;       set country list = 2
		 GET_SCROLL	SCR_CTY_2,CTY_B_ITEMS,FK_SCROLL ;AN000;       point to last item in list 2
	      jmp repeat_l_1					;AN000;    else
	      else_l_6:
		 INIT_VAR	N_CTY_LIST, E_CTY_LIST_1	;AN000;       set country list = 1
		 GET_SCROLL	SCR_CTY_1,CTY_A_ITEMS,FK_SCROLL ;AN000;       point to last item in list 1
	      endif_l_6:					;AN000;
	   jmp repeat_l_1
	   elseif_l_8:
	   cmp N_USER_FUNC,DNARROW				;AN000; else if user entered cursor down
	   jne endrepeat_l_1					;AN000;
	      cmp N_CTY_LIST,E_CTY_LIST_1			;AN000;    if country list = 1
	      jne else_l_7					;AN000;
		 INIT_VAR	N_CTY_LIST, E_CTY_LIST_2	;AN000;       set country list = 2
		 GET_SCROLL	SCR_CTY_2, 1, FK_SCROLL 	;AN000;       point to 1st item in list 2
	      jmp repeat_l_1
	      else_l_7:						;AN000;    else
		 INIT_VAR	N_CTY_LIST, E_CTY_LIST_1	;AN000;       set country list = 1
		 GET_SCROLL	SCR_CTY_1, 1, FK_SCROLL 	;AN000;       point to 1st item in list 1
	      endif_l_7:					;AN000;
	   jmp repeat_l_1
	   else_l_8:						;AN000; else
	      jmp short endrepeat_l_1				;AN000;    break away from repeat loop
	   endif_l_8:						;AN000;
	jmp repeat_l_1						;AN000; end of repeat block
	endrepeat_l_1:
								;
	cmp N_USER_FUNC,E_ENTER					;AN000; if user entered ENTER key
	jne else_l_11						;AN000;
	   COPY_WORD		I_COUNTRY, I_USER_INDEX 	;AN000;    save new country
	   PUSH_HEADING 	COUNTRY_SCREEN			;AN000;    save screen address on SELECT STACK
	   GET_COUNTRY_DEFAULTS N_CTY_LIST, I_COUNTRY		;AN000;    get country default parameters
	   cmp N_DISPLAY,E_CPSW_DISP				;AN000;
	   jne else_l_10					;AN000;
	      cmp N_CPSW,E_CPSW_NOT_VAL				;AN000;    if cpsw not valid
	      jne elseif_l_9					;AN000;
		 INIT_VAR	F_CPSW, E_CPSW_NA		;AN000;       set cpsw = not available
	      jmp endif_l_10
	      elseif_l_9:
	      cmp N_CPSW,E_CPSW_NOT_REC				;AN000;    else if cpsw not recommended
	      jne else_l_9					;AN000;
		 INIT_VAR	F_CPSW, E_CPSW_NO		;AN000;       set cpsw = no
	      jmp short endif_l_10
	      else_l_9:						;AN000;    else
		 INIT_VAR	F_CPSW, E_CPSW_YES		;AN000;       set cpsw = yes
	      endif_l_9:					;AN000;
	   jmp short endif_l_10
	   else_l_10:						;AN000;
	      INIT_VAR		F_CPSW, E_CPSW_NA		;AN000;
	   endif_l_10:						;AN000;
								;
	   ;;; get keyboard from input field if country = Swiss ;
	   COMPARE_STRINGS	S_KEYBOARD,S_SWISS		;AN000;GHG is default KB=SF?
	   jc @F						;AN000;GHG
	      RETURN_STRING	STR_SWISS_KEYB,S_KEYBOARD,M_KEYBOARD+2;AN000;GHG
	   @@:							;AN000;GHG
								;
	   GET_KEYBOARD_INDEX	S_KEYBOARD,N_KYBD_LIST,I_KEYBOARD,N_KYBD_ALT ;AN000; get index into keyboard tables
	   GOTO_ 		KEYBOARD_SCREEN 		;AN000;    goto the next screen (KEYBOARD)
	jmp short endif_l_11
	else_l_11:						;AN000;
	   GOTO_ 		PROCESS_ESC_F3			;AN000; user entered ESC or F3, action
	endif_l_11:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³KEYBOARD_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;  The KEYBOARD CODE screen is presented if the user had selected to
;  define country specific support and the country code selected has a valid
;  keyboard code association.
;  The keyboard code associated with the selected country code will be
;  highlighted.
;  For keyboards that have more than one valid keyboard code, a second
;  level keyboard code screen will be presented to the user.
;  Valid keys are ENTER, ESC, F1, F3, cursor up/down.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KEYBOARD_SCREEN:						;AN000;
	cmp N_KYB_LOAD,E_KYB_LOAD_ERR				;AN000; if KEYB load status is error
	jne @F							;AN000;
	   INIT_VAR		N_KYB_LOAD, E_KYB_LOAD_UND	;AN000;    set KEYB loaded status = undefined
	   POP_HEADING						;AN000;    goto_ previous screen
	@@:							;AN000;
								;
	cmp N_KYBD_VAL,E_KYBD_VAL_NO				;AN000; if keyboard id not valid
	jne @F							;AN000;
	   GOTO_ 		LOAD_KEYBOARD			;AN000;    goto load specified kybd id
	@@:							;AN000;
								;
	INIT_PQUEUE		PAN_KEYBOARD			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_SCROLL		SCR_KYB_1, 0			;AN000; init 1st scroll list
	INIT_SCROLL		SCR_KYB_2, 0			;AN000; init 2nd scroll list
	DISPLAY_PANEL						;AN000; display KEYBOARD panel
								;
	cmp N_KYBD_LIST,E_KYBD_LIST_1				;AN000; if keyboard is in list 1
	jne else_l_12						;AN000;
	   GET_SCROLL		SCR_KYB_1,I_KEYBOARD, FK_SCROLL ;AN000;    highlight kybd in list 1 & get new choice
	jmp short endif_l_12
	else_l_12:						;AN000; else
	   GET_SCROLL		SCR_KYB_2,I_KEYBOARD, FK_SCROLL ;AN000;     highlight kybd in list 2 & get new choice
	endif_l_12:						;AN000;
								;
	repeat_l_2: 						;AN000; repeat code block: CASS cannot do this automatically
	   cmp N_USER_FUNC,UPARROW				;AN000; if user entered cursor up
	   jne elseif_l_15					;AN000;
	      cmp N_KYBD_LIST,E_KYBD_LIST_1		 	;AN000;    if kybd list = 1
	      jne else_l_13					;AN000;
		 INIT_VAR	N_KYBD_LIST, E_KYBD_LIST_2	;AN000;       set kybd list = 2
		 GET_SCROLL	SCR_KYB_2,KYBD_B_ITEMS,FK_SCROLL;AN000;       point to last item in list 2
	      jmp repeat_l_2
	      else_l_13:					;AN000;    else
		 INIT_VAR	N_KYBD_LIST, E_KYBD_LIST_1	;AN000;       set kybd list = 1
		 GET_SCROLL	SCR_KYB_1,KYBD_A_ITEMS,FK_SCROLL;AN000;      point to last item in list 1
	      endif_l_13:					;AN000;
	   jmp repeat_l_2
	   elseif_l_15:
	   cmp N_USER_FUNC,DNARROW				;AN000; else if user entered cursor down
	   jne endrepeat_l_2					;AN000;
	      cmp N_KYBD_LIST,E_KYBD_LIST_1		 	;AN000;    if kybd list = 1
	      jne else_l_14					;AN000;
		 INIT_VAR	N_KYBD_LIST, E_KYBD_LIST_2	;AN000;       set kybd list = 2
		 GET_SCROLL	SCR_KYB_2, 1, FK_SCROLL 	;AN000;       point to 1st item in list 2
	      jmp repeat_l_2
	      else_l_14:					;AN000;    else
		 INIT_VAR	N_KYBD_LIST, E_KYBD_LIST_1	;AN000;       set kybd list = 1
		 GET_SCROLL	SCR_KYB_1, 1, FK_SCROLL 	;AN000;       point to 1st item in list 1
	      endif_l_14:					;AN000;
	   jmp repeat_l_2
	   else_l_15:						;AN000; else
	      jmp short endrepeat_l_2				;AN000;    break away from repeat loop
	   endif_l_15:						;AN000;
	jmp repeat_l_2						;AN000; end of repeat block
	endrepeat_l_2:
								;
	cmp N_USER_FUNC,E_ENTER					;AN000; if user entered ENTER key
	jne else_l_16						;AN000;
	   COPY_WORD		I_KEYBOARD, I_USER_INDEX	;AN000;    save new kybd
	   PUSH_HEADING 	KEYBOARD_SCREEN 		;AN000;    save screen address on SELECT STACK
	   GET_KEYBOARD 	N_KYBD_LIST,I_KEYBOARD,S_KEYBOARD,N_KYBD_ALT ;AN000; get keyboard code
	   GOTO_ 		ALT_KYB_SCREEN			;AN000;    goto next screen (ALT_KYBD)
	jmp short endif_l_16
	else_l_16:						;AN000;
	   GOTO_ 		PROCESS_ESC_F3			;AN000; user entered ENTER or ESC, take action
	endif_l_16:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³ALT_KYB_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The ALTERNATE KEYBOARD CODE screen is presented if the selected keyboard
;  has different keyboard layouts.
;  The screen allows the user to enter the desired keyboard when the
;  language supports different keyboard layouts.  The following languages
;  have different keyboard layouts:
;	 French
;	 Italian
;	 UK English
;  Valid keys are ENTER, ESC, F1, F3, cursor up/down.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ALT_KYB_SCREEN: 						;AN000;
	cmp N_KYB_LOAD,E_KYB_LOAD_ERR				;AN000; if KEYB load status is error
	jne @F							;AN000;
	   POP_HEADING						;AN000;    goto_ previous screen
	@@:							;AN000;
								;
	cmp N_KYBD_ALT,E_KYBD_ALT_NO				;AN000; if no alternate keyboard
	jne @F							;AN000;
	   GOTO_ 		LOAD_KEYBOARD			;AN000;    goto load specified kybd id
	@@:							;AN000;
								;
	GET_ALT_KYBD_TABLE	S_KEYBOARD, ALT_TAB_PTR, ALT_KYB_ID   ;AN000; get alternate keyboard id
								;
	cmp ALT_KYB_ID,ALT_FRENCH				;AN000; kybd id = French
	jne select_l_2_1
	   INIT_VAR		N_WORD_1, SCR_FR_KYB		;AN000;   set scroll list id = French
								;
	jmp short endselect_l_2
	select_l_2_1:
	cmp ALT_KYB_ID,ALT_ITALIAN				;AN000; kybd id = Italian
	jne otherwise_l_2
	   INIT_VAR		N_WORD_1, SCR_IT_KYB		;AN000;   set scroll list id = Italian
								;
	jmp short endselect_l_2
	otherwise_l_2:						;AN000; kybd id = UK English
	   INIT_VAR		N_WORD_1, SCR_UK_KYB		;AN000;   set scroll list id = UK English
								;
	endselect_l_2:						;AN000;
								;
	COMP_BYTES		ALT_KYB_ID, ALT_KYB_ID_PREV	;AN000; if current alt kyb id different
	jz @F							;AN000;
	   INIT_VAR		I_KYBD_ALT, 2			;AN090;    set index into list = 1
	   COPY_BYTE		ALT_KYB_ID_PREV, ALT_KYB_ID	;AN000;    set prev id = current id
	@@:							;AN000;
								;
	INIT_PQUEUE		PAN_KYBD_ALT			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_SCROLL		N_WORD_1, 0			;AN000; init scroll list
	DISPLAY_PANEL						;AN000; display ALTERNATE keyboard panel
								;
	GET_SCROLL		N_WORD_1, I_KYBD_ALT, FK_SCROLL ;AN000; get new alt kyb id
								;
	cmp N_USER_FUNC,E_ENTER					;AN000; if user entered ENTER key
	jne else_l_17						;AN000;
	   COPY_WORD		I_KYBD_ALT, I_USER_INDEX	;AN000;    save new alternate keyboard
	   PUSH_HEADING 	ALT_KYB_SCREEN			;AN000;    push screen address on SELECT STACK
	   GET_ALT_KEYBOARD	ALT_TAB_PTR,ALT_KYB_ID,I_KYBD_ALT,S_KYBD_ALT ;AN000;get alternate keyboard code
	   GOTO_ 		LOAD_KEYBOARD			;AN000;    goto load specified kybd id
	jmp short endif_l_17
	else_l_17:						;AN000;
	   GOTO_ 		PROCESS_ESC_F3			;AN000; user entered ESC or F3, take action
	endif_l_17:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³ LOAD_KEYBOARD			 ³
;
;  ³	This will execute the keyboard	 ³
;	program to load the requested
;  ³	keyboard routine.		 ³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_KEYBOARD:							;AN000;
	cmp N_KYBD_LIST,E_KYBD_LIST_2				;AN000; if kybd is none
	jne @F
	cmp I_KEYBOARD,KYBD_B_ITEMS				;AN000;
	jne @F							;AN000;
	   INIT_VAR		N_KYBD_VAL, E_KYBD_VAL_DEF	;AN000;    set kybd id = default id
	@@:							;AN000;
								;
	cmp N_KYBD_VAL,E_KYBD_VAL_YES				;AN000; if kybd id is valid
	jne else_l_19						;AN000;
	   cmp N_KYBD_ALT,E_KYBD_ALT_NO				;AN000;    if alt kybd not valid
	   jne else_l_18					;AN000;
	      COPY_STRING	S_STR120_1,M_STR120_1,S_KEYBOARD;AN000;       set par = kybd id
	   jmp short endif_l_18
	   else_l_18:						;AN000;    else
	      COPY_STRING	S_STR120_1,M_STR120_1,S_KYBD_ALT;AN000;       set par = alt kybd id
	   endif_l_18:						;AN000;
	   INIT_VAR		N_WORD_1, E_KYB_LOAD_SUC	;AN000;
	jmp short endif_l_19
	else_l_19:						;AN000;
	   COPY_STRING		S_STR120_1,M_STR120_1,S_US	;AN000;
	   INIT_VAR		N_WORD_1, E_KYB_LOAD_US 	;AN000;
	endif_l_19:						;AN000;
								;
	cmp N_KYB_LOAD,E_KYB_LOAD_US		 		;AN000;
	jne else_l_20
	cmp N_WORD_1,E_KYB_LOAD_US				;AN000;
	jne else_l_20						;AN000;
	jmp endif_l_20
	else_l_20:						;AN000;
								;
	   cmp MEM_SIZE,256					;AN000;DT this includes support for PC Convertible  (SEH)
	   jne @F
	      DEALLOCATE_MEMORY 				;AN000;DT
	   @@:							;AN000;DT
								;
	   CALL HOOK_INT_24					;AN000;
	   EXEC_PROGRAM 	S_KEYB,S_STR120_1,PARM_BLOCK,EXEC_DIR ;AN000;  load specified kybd id
	   cmp MEM_SIZE,256					;AN063;SEH
	   jne @F
	       CALL GET_OVERLAY 				;AN063;SEH
	   @@:							;AN063;SEH
	   cmp EXEC_ERR,TRUE					;AC063;SEH ;AN000;
	   jne @F						;AN000;
	      HANDLE_ERROR	ERR_KEYB,E_RETURN		;AN000;
	      INIT_VAR		N_KYB_LOAD, E_KYB_LOAD_ERR	;AN000;
	      POP_HEADING					;AN000;
	   @@:							;AN000;
	   CALL RESTORE_INT_24					;AN000;
	   COPY_WORD		N_KYB_LOAD, N_WORD_1		;AN000;
								;
	   cmp MEM_SIZE,256					;AC063;SEH ;AN000;DT
	   jne @F
	   cmp N_DISKETTE_A,E_DISKETTE_720			;AN063;SEH
	   je @F
	      INSERT_DISK	SUB_REM_DOS_A, S_DOS_COM_360	;AN000;JW Insert the INSTALL diskette
	   @@:							;AN000;DT
								;
	endif_l_20:						;AN000;
								;
	cmp N_KYBD_LIST,E_KYBD_LIST_2				;AN000; if kybd is US ENGLISH	       JW
	jne @F
	cmp I_KEYBOARD,8	 				;AN000; 			       JW
	jne @F							;AN000; 			       JW
	   INIT_VAR		N_KYBD_VAL, E_KYBD_VAL_YES	;AN000;    set kybd id = US KEYBOARD   JW
	@@:							;AN000; 			       JW
								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³DEST_DRIVE_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The DESTINATION DRIVE screen is presented when there is an option for
;  the destination drive. Possible options are:
;		B or C
;		A or C
;  Valid keys are ENTER, ESC, F1, F3, cursor up/down, numeric 1 to 2.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEST_DRIVE_SCREEN:						;AN000;
	cmp N_DEST_DRIVE,E_DEST_SELECT				;AN000; if default destination drive
	jne @F							;AN000;
	   GOTO_ 		DOS_LOC_SCREEN			;AN000;    goto next screen (DOS_LOC)
	@@:							;AN000;
								;
	cmp N_DRIVE_OPTION,E_OPTION_B_C				;AN111;JW
	jne else_l_21
	   INIT_VAR		N_WORD_1, SCR_DEST_B_C		;AN111;JW
	jmp short endif_l_21
	else_l_21:						;AN111;JW
	   INIT_VAR		N_WORD_1, SCR_DEST_A_C		;AN111;JW
	endif_l_21:						;AN111;JW
								;
	INIT_PQUEUE		PAN_DEST_DRIVE			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_SCROLL		N_WORD_1, I_DEST_DRIVE		;AN000; init scroll list
	DISPLAY_PANEL						;AN000; display DEST_DRIVE panel
								;
	GET_SCROLL		N_WORD_1,I_DEST_DRIVE,FK_SCROLL ;AN000; get new install destination
								;
	cmp N_USER_FUNC,E_ENTER					;AN000; if user entered ENTER key
	jne else_l_23						;AN000;
	   cmp N_DRIVE_OPTION,E_OPTION_A_C			;AN111;JW
	   jne else_l_22
	   cmp I_USER_INDEX,2					;AN111;JW
	   jne else_l_22
	      INIT_VAR		   I_DEST_DRIVE, E_DEST_DRIVE_A ;AN111;JW
	   jmp short endif_l_22
	   else_l_22:						;AN111;JW
	      COPY_WORD 	   I_DEST_DRIVE, I_USER_INDEX	;AN000;    save new install destination drive
	   endif_l_22:						;AN111;JW
	   PUSH_HEADING 	DEST_DRIVE_SCREEN		;AN000;    save screen address on the SELECT STACK
	   GOTO_ 		DOS_LOC_SCREEN			;AN000;    goto the next screen (DOS_LOC)
	jmp short endif_l_23
	else_l_23:						;AN000;
	   GOTO_ 		PROCESS_ESC_F3			;AN000; user entered ESC OR F3, take action
	endif_l_23:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	ENDS							;AN000;
	END							;AN000;
