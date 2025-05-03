

PAGE	55,132							;AN000;
NAME	SELECT							;AN000;
TITLE	SELECT - DOS - SELECT.EXE				;AN000;
SUBTTL	SELECT2A.asm						;AN000;
;RLC .ALPHA								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	SELECT2A.ASM : Copyright 1988 Microsoft
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
;	CHANGE HISTORY:
;
;	mrw0	6/16/88 Added panel for shell selection...
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'                              ;AN000; Dummy data segment
	EXTRN	 SEG_LOC:WORD					;AN000;
	EXTRN	 NAMES_OFF:WORD 				;AN000;
	EXTRN	 N_PRN_NAMES:WORD				;AN000;
	EXTRN	 MAX_NAME:WORD					;AN000;
	EXTRN	 SIZE_NAMES:ABS 				;AN000;
DATA	       ENDS						;AN000;
								;
.XLIST								;AN000;
	INCLUDE    panel.mac					;AN000;
	INCLUDE    select.inc					;AN000;
	INCLUDE    pan-list.inc 				;AN000;
	INCLUDE    castruc.inc					;AN000;
	INCLUDE    macros.inc					;AN000;
	INCLUDE    ext.inc					;AN000;
	INCLUDE    varstruc.inc 				;AN000;
	INCLUDE    rout_ext.inc 				;AN000;
.LIST								;AN000;
	PUBLIC	DOS_LOC_SCREEN					;AN000;
	PUBLIC	PRINTER_SCREEN					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	SEGMENT PARA PUBLIC 'SELECT'                            ;AN000;
	ASSUME	CS:SELECT,DS:DATA				;AN000;
								;
	INCLUDE casextrn.inc					;AN000;
								;
	EXTRN	INSTALL_ERROR:NEAR				;AN000;
	EXTRN	EXIT_DOS:NEAR					;AN000;
	EXTRN	EXIT_SELECT:NEAR				;AN000;
								;
	EXTRN	PROCESS_ESC_F3:NEAR				;AN000;
	EXTRN	INTRO_SCREEN:NEAR				;AN000;
	EXTRN	choose_shell_screen:NEAR			;mrw0 ;AC020;SEH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³DOS_LOC_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The DOS LOCATION screen is presented only if DOS is to be installed
;  on drive C:.
;  The maximum length of the install path will be limited to 40 characters.
;  This restriction is imposed so that when generating commands
;  for the CONFIG.SYS and AUTOEXEC.BAT files, the command line length will not
;  exceed 128 characters.
;  When the screen is presented for the first time, the default install
;  path displayed will be "DOS".  On subsequent presentations, the user
;  selected path will be displayed.
;  Valid keys are ENTER, ESC, F1, F3 and ASCII characters A to Z.
;?????????????????????????????update?????????????????????????????????
;  The Functional Specification dated 5 May 1987, states that the APPEND
;  and PATH commands will be generated if the user selected to minimize workspace
;  or maximize workspace but not if the user selected balance workspace.  Since
;  this assumption does not seem logical, the check has been revised to
;  generate the commands if the install destination is drive C:.  Also, the
;  PC/DOS parameters screen does not check for the workspace definition.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DOS_LOC_SCREEN: 						;AN000;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_C				;AN111; if install destination is drive A: or B: JW
	je @F							;AN000;
	   INIT_VAR		F_PROMPT, E_PROMPT_NO		;AN000;    set prompt = no
	   INIT_VAR		F_PATH, E_PATH_NO		;AN000;    set path = no
	   INIT_VAR		F_APPEND, E_APPEND_NO		;AN000;    set append = no
	   GOTO_ 		PRINTER_SCREEN			;AN000;    goto next screen (PRINTER)
	@@:							;AN000;
								;
	INIT_PQUEUE		PAN_DOS_LOC			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_STRING		STR_DOS_LOC,S_DOS_LOC,M_DOS_LOC ;AN000;
	cmp N_DISK1_MODE,E_DISK1_INSTALL	 		;AN000; if this is not a new fixed disk   JW
	je @F							;AN000; then				  JW
	   INIT_SCROLL		   SCR_COPY_DEST,I_DESTINATION	;AN000;   initialize destination choice   JW
	   INIT_SCROLL_COLOUR	   SCR_COPY_DEST,2		;AN026;   set field to not active color
	@@:							;AN000; endif				  JW
	DISPLAY_PANEL						;AN000; display DOS_LOC panel
								;
	COPY_STRING		S_STR120_1,M_STR120_1,S_DOS_LOC ;AN000;
								;
GET_DOS_LOCATION:						;AN000;
	GET_STRING		STR_DOS_LOC,S_STR120_1,M_DOS_LOC,FK_TAB     ;AN000;get new install path
								;
	PROCESS_F3						;AN000; if user entered F3, exit to DOS
	PROCESS_ESC						;AN000; if user entered ESC, goto_ previous screen
								;
	COPY_STRING		S_STR120_1,M_STR120_1,S_USER_STRING   ;AN000;
	CHECK_PATH		S_STR120_1,0, 0 		;AN000;
	jc else_l_2						;AN000; if path is valid
	   COPY_STRING		S_DOS_LOC,M_DOS_LOC,S_USER_STRING     ;AN000;  save new DOS install path
	   COPY_STRING		S_STR120_2, M_STR120_2, S_INSTALL_PATH;AN000;save old install path
	   MERGE_STRING 	S_INSTALL_PATH,M_INSTALL_PATH,S_DEST_DRIVE,S_DOS_LOC ;AN000; add 'C:\' to install path
	   COMPARE_STRINGS	S_INSTALL_PATH, S_STR120_2	;AN000;    compare old and new paths
	   jnc elseif_l_1					;AN000;    if paths different
	      INIT_VAR		F_APPEND, E_APPEND_YES		;AN000;       set APPEND = yes
	      COPY_STRING	S_APPEND,M_APPEND,S_INSTALL_PATH;AN000;      set new APPEND path
	      INIT_VAR		F_PATH, E_PATH_YES		;AN000;       set PATH = yes
	      COPY_STRING	S_PATH, M_PATH, S_INSTALL_PATH	;AN000;       set new DOS path
	   jmp endif_l_1
	   elseif_l_1:
	   cmp S_APPEND,0					;AN000;
	   jne endif_l_1					;AN000;
	      COPY_STRING	S_APPEND,M_APPEND,S_INSTALL_PATH;AN000;
	      INIT_VAR		F_APPEND, E_APPEND_YES		;AN000;
	   endif_l_1:						;AN000;
	   cmp I_WORKSPACE,E_WORKSPACE_MIN			;AN000;    if workspace option = minimize
	   jne @F						;AN000;
	      INIT_VAR		S_APPEND, 0			;AN000;       set APPEND= null
	   @@:						;AN000;
	   INIT_VAR		F_PROMPT, E_PROMPT_YES		;AN000;    set PROMPT = yes
	jmp short endif_l_2
	else_l_2:						;AN000; else
	   HANDLE_ERROR 	ERR_BAD_PATH, E_RETURN		;AN000;    pop error message
	   GOTO_ 		GET_DOS_LOCATION		;AN000;    goto get DOS location again
	endif_l_2:						;AN000;
								;
	cmp N_DISK1_MODE,E_DISK1_INSTALL			;AN000; if this is not a new fixed disk    JW
	je endif_l_3
	cmp N_USER_FUNC,E_TAB					;AN000; if user tabbed to the scroll field JW
	jne endif_l_3						;AN000; 				   JW
	   GET_SCROLL		SCR_COPY_DEST,I_DESTINATION,FK_TAB    ;AN000;				   JW
	   PROCESS_F3						;AN000; if user entered F3, exit to DOS    JW
	   PROCESS_ESC						;AN000; 				   JW
	   COPY_WORD		I_DESTINATION, I_USER_INDEX	;AN000; save new install destination drive JW
	   cmp N_USER_FUNC,E_TAB	 			;AN000; if user entered ESC		   JW
	   jne @F						;AN000; 				   JW
	      SET_SCROLL	SCR_COPY_DEST,I_DESTINATION	;AN026; Set to not active
	      GOTO_		GET_DOS_LOCATION		;AC051;SEH ;AN000 Go get dos location	   JW
	   @@:							;AN000; 				   JW
	endif_l_3:						;AN000; 				   JW
	PUSH_HEADING		DOS_LOC_SCREEN			;AC051;SEH ;AN000;    save screen address on SELECT STACK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³PRINTER_SCREEN			³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;  The PRINTER SCREEN is always presented.
;  The screen allows the user to indicate the number of printers attached.
;  Valid keys are ENTER, ESC, F1, F3 and numeric 0 to 7.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRINTER_SCREEN: 						;AN000;
	cmp N_PARALLEL,0					;AN000; if zero parallel and
	jne @F
	cmp N_SERIAL,0						;AN000; and zero serial printers
	jne @F							;AN000;
	   INIT_VAR		F_GRAPHICS, E_GRAPHICS_NO	;AN000;    set GRAPHICS = no  JW
	   GOTO_ 		choose_shell_screen		;mrw0 ;AC020;SEH goto next screen
	@@:							;AN000;
								;
	;;;display panel to get number of printers		;
	INIT_PQUEUE		PAN_PRINTER			;AN000; initialize queue
	PREPARE_PANEL		PAN_HBAR			;AN000; prepare horizontal bar
	PREPARE_CHILDREN					;AN000; prepare child panels
	INIT_NUMERIC		NUM_PRINTER,N_NUMPRINT,MAX_NUMPRINT,S_STR120_1;AN000;
	DISPLAY_PANEL						;AN000;
								;
	;;;get number of printers				;
	GET_NUMERIC		NUM_PRINTER,N_NUMPRINT,MIN_NUMPRINT,MAX_NUMPRINT,FK_TEXT,S_STR120_1;AN000;
								;
	;;;save number of printers and goto_ next screen 	;
	cmp N_USER_FUNC,E_ENTER					;AN000; if user entered ENTER key
	jne else_l_4						;AN000;
	   COPY_WORD		N_NUMPRINT, N_USER_NUMERIC	;AN000;    save number of printers
	   PUSH_HEADING 	PRINTER_SCREEN			;AN000;    save screen address on SELECT STACK
	jmp short endif_l_4
	else_l_4:						;AN000;
	   GOTO_ 		PROCESS_ESC_F3			;AN000; user entered ESC or F3, take action
	endif_l_4:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;  ³PRINTER_TYPE_SCREEN 		³
;  ³					³
;  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
;	Get type of printer
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRINTER_TYPE_SCREEN:						;AN000;
	cmp N_NUMPRINT,MIN_NUMPRINT				;AN000; if zero printers specified
	jne @F							;AN000;
	   INIT_VAR		F_GRAPHICS, E_GRAPHICS_NO	;AN000; set GRAPHICS = no  JW
	   GOTO_ 		choose_shell_screen	 	;mrw0 ;AC020; SEH goto next screen
	@@:							;AN000;
								;
	GET_PRINTER_TITLES	S_PRINT_FILE			;AN000; read printer titles from SELECT.PRT
	jnc @F							;AN000; if error reading file
	   INIT_VAR		N_NUMPRINT, MIN_NUMPRINT	;AN000;    set no of printers = 0
	   HANDLE_ERROR 	ERR_BAD_PFILE, E_RETURN 	;AN000;    popup error message
	   GOTO_ 		choose_shell_screen		;mrw0 ;AC020; SEH goto next screen
	@@:							;AN000;
								;
	INIT_VAR		N_COUNTER, 1			;AN000; set printer no = 1
	cmp I_WORKSPACE,E_WORKSPACE_MIN				;AN014; SEH if not minimum DOS workspace
	je @F							;AN014;
	   INIT_VAR		F_GRAPHICS, E_GRAPHICS_YES	;AN000; set GRAPHICS = yes SEH
	@@:							;AN014; SEH
								;
GET_PRINTER_TYPE:						;AN000; repeat loop to get printer info
								;
	cmp N_COUNTER,0						;AN000;    if printer no = zero
	jne endif_l_5							;AN000;
	   RELEASE_PRINTER_INFO 				;AN000;       release memory
	   jnc @F						;AN000;
	      GOTO_		INSTALL_ERROR			;AN000;
	   @@:							;AN000;
	   POP_HEADING						;AN000;       goto_ previous screen
	endif_l_5:						;AN000;
								;
		 						;AN000;    get printer no sub panel
								;
	cmp N_COUNTER,1						;AN000;
	jne select_l_1_1
	   INIT_VAR		N_BYTE_1, '1'                   ;AC025;
								;
	jmp endselect_l_1
	select_l_1_1:
	cmp N_COUNTER,2						;AN000;
	jne select_l_1_2
	   INIT_VAR		N_BYTE_1, '2'                   ;AC025;
								;
	jmp endselect_l_1
	select_l_1_2:
	cmp N_COUNTER,3						;AN000;
	jne select_l_1_3
	   INIT_VAR		N_BYTE_1, '3'                   ;AC025;
								;
	jmp endselect_l_1
	select_l_1_3:
	cmp N_COUNTER,4						;AN000;
	jne select_l_1_4
	   INIT_VAR		N_BYTE_1, '4'                   ;AC025;
								;
	jmp endselect_l_1
	select_l_1_4:
	cmp N_COUNTER,5						;AN000;
	jne select_l_1_5
	   INIT_VAR		N_BYTE_1, '5'                   ;AC025;
								;
	jmp endselect_l_1
	select_l_1_5:
	cmp N_COUNTER,6						;AN000;
	jne otherwise_l_1
	   INIT_VAR		N_BYTE_1, '6'                   ;AC025;
								;
	jmp short endselect_l_1
	otherwise_l_1:						;AN000;
	   INIT_VAR		N_BYTE_1, '7'                   ;AC025;
								;
	endselect_l_1:						;AN000;
								;
	GET_PRINTER_PARAMS	N_COUNTER, 0, N_RETCODE 	;AN000;    based on printer #
								;
	;;;N_BYTE_1 = printer number				;
	INIT_CHAR		N_BYTE_1, E_DISK_ROW, E_DISK_COL, SUB_PRINTER_1 ;AN025; display the printer number
	INIT_PQUEUE		PAN_PRT_TYPE			;AN000;    initialize queue
	PREPARE_PANEL		SUB_PRINTER_1			;AC025;    printer no
	PREPARE_PANEL		PAN_HBAR			;AN000;    prepare horizontal bar
	PREPARE_CHILDREN					;AN000;    prepare child panels
	INIT_SCROLL_W_LIST	SCR_PRT_TYPE,SEG_LOC,NAMES_OFF,N_PRN_NAMES,SIZE_NAMES,MAX_NAME,I_PRINTER;AN000;
	DISPLAY_PANEL						;AN000;
								;
	GET_SCROLL		SCR_PRT_TYPE,I_PRINTER,FK_SCROLL;AN000;    get printer type
								;
	PROCESS_F3						;AN000;    take action if F3 entered
								;
	cmp N_USER_FUNC,E_ESCAPE	 			;AN000;    if user entered ESC
	jne @F							;AN000;
	   DEC			N_COUNTER			;AN000;       dec printer number
	   GOTO_ 		GET_PRINTER_TYPE		;AN000;       goto previous printer
	@@:							;AN000;
								;
	COPY_WORD		I_PRINTER, I_USER_INDEX 	;AN000;    save printer type
								;
	GET_PRINTER_INFO	I_PRINTER			;AN000;    get printer info from SELECT.PRT
	jnc @F							;AN000;    if error
	   HANDLE_ERROR 	ERR_BAD_PPRO, E_RETURN		;AN000;       popup error message
	   GOTO_ 		GET_PRINTER_TYPE		;AN000;       goto get printer type
	@@:							;AN000;
								;
	cmp N_PRINTER_TYPE,E_PARALLEL				;AN000;
	jne @F
	cmp N_PARALLEL,0	 				;AN000;
	jne @F							;AN000;
	   HANDLE_ERROR 	ERR_PRT_NO_HDWR, E_RETURN	;AN000;
	   GOTO_ 		GET_PRINTER_TYPE		;AN000;
	@@:							;AN000;
								;
	cmp N_PRINTER_TYPE,E_SERIAL				;AN000;
	jne @F
	cmp N_SERIAL,0						;AN000;
	jne @F							;AN000;
	   HANDLE_ERROR 	ERR_PRT_NO_HDWR, E_RETURN	;AN000;
	   GOTO_ 		GET_PRINTER_TYPE		;AN000;
	@@:							;AN000;
								;
	cmp N_PRINTER_TYPE,E_PARALLEL				;AN000;    if parallel printer
	jne otherwise_l_2
	   INIT_CHAR		N_BYTE_1, E_DISK_ROW, E_DISK_COL, SUB_PRINTER_1 ;AN025; display the printer number
	   INIT_PQUEUE		PAN_PARALLEL			;AN000;       initialize queue
	   PREPARE_PANEL	SUB_PRINTER_1			;AC025;
	   PREPARE_PANEL	PAN_HBAR			;AN000;       prepare horizontal bar
	   PREPARE_CHILDREN					;AN000;       prepare child panels
	   INIT_SCROLL_W_LIST	SCR_ACC_PRT,SEG_LOC,NAMES_OFF,N_PRN_NAMES,SIZE_NAMES,MAX_NAME,I_PRINTER;AN000;
	   INIT_SCROLL_W_NUM	SCR_PARALLEL,N_PARALLEL,I_PORT	;AN000;
	   DISPLAY_PANEL					;AN000;       display panel
								;
	   GET_SCROLL		SCR_PARALLEL, I_PORT, FK_SCROLL ;AN000;
	   COPY_WORD		I_PORT, I_USER_INDEX		;AN000;
								;
	jmp endselect_l_2
	otherwise_l_2:					;AN000;    if serial printer
								;
	   INIT_CHAR		N_BYTE_1, E_DISK_ROW, E_DISK_COL, SUB_PRINTER_1 ;AN025; display the printer number
	   INIT_PQUEUE		PAN_SERIAL			;AN000;       initialize queue
	   PREPARE_PANEL	SUB_PRINTER_1			;AN025;
	   PREPARE_PANEL	PAN_HBAR			;AN000;       prepare horizontal bar
	   PREPARE_CHILDREN					;AN000;       prepare child panels
	   INIT_SCROLL_W_LIST	SCR_ACC_PRT,SEG_LOC,NAMES_OFF,N_PRN_NAMES,SIZE_NAMES,MAX_NAME,I_PRINTER;AN000;
	   INIT_SCROLL_W_NUM	SCR_SERIAL,N_SERIAL,I_PORT	;AN000;
	   INIT_SCROLL		SCR_PRT_REDIR, I_REDIRECT	;AN000;
	   INIT_SCROLL_COLOUR	SCR_PRT_REDIR, 2		;AN000;
	   DISPLAY_PANEL					;AN000;
								;
	   repeat_l_1:						;AN000;
	      SET_SCROLL	SCR_PRT_REDIR, I_REDIRECT	;AN000;
	      GET_SCROLL	SCR_SERIAL, I_PORT, FK_TAB	;AN000;
	      COPY_WORD 	I_PORT, I_USER_INDEX		;AN000;
	      cmp N_USER_FUNC,E_TAB		 		;AN000;
	      jne @F						;AN000;
		 SET_SCROLL	SCR_SERIAL, I_PORT		;AN000;
		 GET_SCROLL	SCR_PRT_REDIR,I_REDIRECT,FK_TAB ;AN000;
		 COPY_WORD	I_REDIRECT, I_USER_INDEX	;AN000;
	      @@:						;AN000;
								;
	   cmp N_USER_FUNC,E_ENTER				;AN000;
	   je @F
	   cmp N_USER_FUNC,E_ESCAPE				;AN000;
	   je @F
	   cmp N_USER_FUNC,E_F3					;AN000;
	   jne repeat_l_1
	   @@:
								;
	endselect_l_2:						;AN000;
								;
	PROCESS_F3						;AN000;
								;
	cmp N_USER_FUNC,E_ESCAPE	 			;AN000; if user entered ESC
	jne @F							;AN000;
	   GOTO_ 		GET_PRINTER_TYPE		;AN000;    goto get printer type
	@@:							;AN000;
	SAVE_PRINTER_PARAMS	N_COUNTER			;AN000; save printer parameters
	INC_VAR 		N_COUNTER			;AN000; inc printer number
	COMP_WORDS		N_COUNTER, N_NUMPRINT		;AN000; if printer no > no of printers
	jc else_l_6						;AN000;
	jz else_l_6						;AN000;
	   RELEASE_PRINTER_INFO 				;AN000;    release memory
	   jnc @F						;AN000;    if error
	      GOTO_		INSTALL_ERROR			;AN000;       :::::::
	   @@:							;AN000;
	   GOTO_ 		choose_shell_screen		;mrw0 ;AC020; SEH goto next screen
	jmp short endif_l_6
	else_l_6:						;AN000;
	   GOTO_ 		GET_PRINTER_TYPE		;AN000;
	endif_l_6:							;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	ENDS							;AN000;
	END							;AN000;
