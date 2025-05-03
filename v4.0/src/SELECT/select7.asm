

PAGE 55,132							;AN000;
NAME	SELECT							;AN000;
TITLE	SELECT - DOS - SELECT.EXE				;AN000;
SUBTTL	SELECT7.asm						;AN000;
;RLC .ALPHA								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	SELECT7.ASM : Copyright 1988 Microsoft
;
;	DATE:	 August 8/87
;
;	COMMENTS: Assemble with MASM 3.0 (using the /A option)
;
;		  Panel flow is defined in the following files:
;
;		      þ SELECT1.ASM
;		      ;AN000; SELECT2.ASM
;		      ;AN000; SELECT3.ASM
;		      ;AN000; SELECT4.ASM
;		      ;AN000; SELECT5.ASM
;		      ;AN000; SELECT6.ASM
;
;
;  Module contains code for :
;	- Format the drives
;	- Copy files
;
;	CHANGE HISTORY:
;
;	;AN009; DT  added support for creation of the DOSSHELL.BAT as a
;		    separately installed file.	(D233)
;	;AN002; GHG for P1146
;	;AN003; GHG for D234
;	;AN004; GHG for P65
;	;AN005; DT for single drive support
;	;AN006; JW for dos location choice (global or path only)
;	;AN007; JW fixed deletion of select.* when installation is to the root
;	;AN072; DT Overlay parser and pcinput if memory = 256KB
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'                              ;AN000;
DATA	ENDS							;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.XLIST								;AN000;
	INCLUDE    panel.mac					;AN000;
	INCLUDE    select.inc					;AN000;
	INCLUDE    pan-list.inc 				;AN000;
	INCLUDE    castruc.inc					;AN000;
	INCLUDE    macros.inc					;AN000;
	INCLUDE    macros7.inc					;AN009;DT
	INCLUDE    ext.inc					;AN000;
	INCLUDE    varstruc.inc 				;AN000;
	INCLUDE    rout_ext.inc 				;AN000;
.LIST								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
								;
	EXTRN	DEALLOCATE_HELP:FAR				;AN000;DT
	EXTRN	DEALLOCATE_BLOCK:FAR				;AN000;DT
	EXTRN	ALLOCATE_BLOCK:FAR				;AN000;DT
	EXTRN	DEALLOCATE_MEMORY_CALL:FAR			;AN000;DT
	EXTRN	ALLOCATE_MEMORY_CALL:FAR			;AN000;DT
								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	SEGMENT PARA PUBLIC 'SELECT'                            ;AN000;
	ASSUME	CS:SELECT,DS:DATA				;AN000;
								;
	INCLUDE casextrn.inc					;AN000;
								;
	EXTRN	EXIT_SELECT:near				;AN000;
	EXTRN	CREATE_CONFIG_SYS:NEAR				;AN000;
	EXTRN	CREATE_AUTOEXEC_BAT:NEAR			;AN000;
	EXTRN	CREATE_SHELL_BAT:NEAR				;AN009;DT
								;
	EXTRN	EXIT_DOS:near					;AN004;GHG
	EXTRN	INSTALL_ERROR:near				;AN004;GHG
	EXTRN	EXIT_SELECT:NEAR				;AN004;GHG
	EXTRN	PROCESS_ESC_F3:near				;AN004;GHG
	EXTRN	EXIT_DOS_CONT:NEAR				;AN004;GHG
								;
	PUBLIC	CONTINUE_360					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	CODE CONTINUES.....
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;INSTALL 360KB DISKETTE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Display copying files from INSTALL diskette
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONTINUE_360:							;AN000;
							      ;;;
							      ;;;
     cmp N_DISKETTE_A,E_DISKETTE_360				;AN000;
     jne endif_l_17
								;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying from diskette 2 message
	DISPLAY_PANEL						;AN000;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   DEALLOCATE_MEMORY					;AN000;DT
	@@:							;AN000;DT
								;
	;;;S_STR120_1 = "a:*.* c:\path /a  parameter for REPLACE
	MERGE_STRING	     S_STR120_1,M_STR120_1,S_A_STARS,S_INSTALL_PATH ;AN000;
	APPEND_STRING	     S_STR120_1,M_STR120_1,S_SLASH_A	;AN000;
								;
;	.IF < I_DESTINATION eq E_ENTIRE_DISK >			;AN006;JW
;	.THEN							;AN006;
;	   ;;;S_STR120_3 = "a:*.* c:\ /s /r  parameter for REPLACE
;	   COPY_STRING	     S_STR120_3,M_STR120_3,S_REPLACE_PAR1     ;AN006;JW
;	.ELSE							;AN006;
	   ;;;S_STR120_3 = "a:*.* c:\<path> parameter for REPLACE
	   MERGE_STRING      S_STR120_3,M_STR120_3,S_A_STARS,S_INSTALL_PATH ;AN006;JW
	   APPEND_STRING     S_STR120_3,M_STR120_3,S_SLASH_R	;AN000;JW
;	.ENDIF							;AN006;
								;
	;;;change attributes of some files so they are not copied
	CHANGE_ATTRIBUTE     HIDE_STARTUP, E_HIDE_STARTUP	;AN000;
								;
	;;;replace files in drive C: with new files on INSTALL diskette
	EXEC_PROGRAM	     S_REPLACE,S_STR120_3,PARM_BLOCK,EXEC_DIR	 ;AN006;JW
	jnc endif_l_1						;AN000;
	  cmp MEM_SIZE,256					;AN000;DT
	  jne @F
	     CALL  GET_OVERLAY					;AN000;DT Get panels
	  @@:							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	   RESTORE_ATTRIBUTE	HIDE_STARTUP,E_HIDE_STARTUP	;AN000;
	endif_l_1:						;AN000;
								;
	;;;S_STR120_1 = "a:*.* C:\<path> /A"                    ;
	;;;copy NEW files on INSTALL diskette to install path	 ;
	EXEC_PROGRAM	     S_REPLACE,S_STR120_1,PARM_BLOCK,EXEC_DIR ;AN000; copy new files
	jnc endif_l_2						;AN000;
	   cmp MEM_SIZE,256					;AN000;DT
	   jne @F
	      CALL  GET_OVERLAY 				;AN000;DT Get panels
	   @@:							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	   RESTORE_ATTRIBUTE	HIDE_STARTUP,E_HIDE_STARTUP	;AN000;
	endif_l_2:						;AN000;
								;
	RESTORE_ATTRIBUTE    HIDE_STARTUP,E_HIDE_STARTUP	;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Prompt the user to remove the INSTALL (source) diskette
;	and insert the OPERATING 1 (source) diskette.
;
;;;;;;;;;;SHELL 360KB DISKETTE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   CALL  GET_OVERLAY					;AN000;DT Get panels
	@@:							;AN000;
								;
	;;;insert OPERATING 1 diskette in drive A:		;
	INSERT_DISK	SUB_REM_SELECT_360, S_DOS_UTIL1_DISK	;AN000;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Display copying files
;
;	NOTE:  The REPLACE command is now issued from the hard disk
;	       (since it is not found on any other disk)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying from diskette 2 message
	DISPLAY_PANEL						;AN000;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   DEALLOCATE_MEMORY					;AN000;DT
	@@:							;AN000;DT
								;
	;;;S_STR120_1 = "a:*.* c:\path /a  parameter for REPLACE
	MERGE_STRING	     S_STR120_1,M_STR120_1,S_A_STARS,S_INSTALL_PATH ;AN000;
	APPEND_STRING	     S_STR120_1,M_STR120_1,S_SLASH_A	;AN000;
								;
	COMPARE_STRINGS      S_INSTALL_PATH, S_DEST_DRIVE	;AN000; compare to C:\
	jc else_l_3						;AN000; if the same
	    MERGE_STRING	 S_STR120_2,M_STR120_2,S_INSTALL_PATH,S_REPLACE   ;AN000;
	jmp short endif_l_3
	else_l_3:						;AN000;
	    MERGE_STRING	 S_STR120_2,M_STR120_2,S_INSTALL_PATH,S_SLASH	  ;AN000;
	    APPEND_STRING	 S_STR120_2,M_STR120_2,S_REPLACE;AN000;
	endif_l_3:						;AN000;
								;
	;;;replace files in drive C: with new files on OPERATING 1 diskette
	EXEC_PROGRAM	     S_STR120_2,S_STR120_3,PARM_BLOCK,EXEC_DIR	 ;AN006;JW
	jnc endif_l_4						;AN000;
	  cmp MEM_SIZE,256					;AN000;DT
	  jne @F
	     CALL  GET_OVERLAY					;AN000;DT Get panels
	  @@:							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	endif_l_4:						;AN000;
								;
	;;;S_STR120_1 = "a:*.* C:\<path> /A"                    ;
	;;;copy NEW files on OPERATING 1 diskette to install path
	EXEC_PROGRAM	     S_STR120_2,S_STR120_1,PARM_BLOCK,EXEC_DIR ;AN000; copy new files
	jnc endif_l_5						;AN000;
	     cmp MEM_SIZE,256					;AN000;DT
	     jne @F
		CALL  GET_OVERLAY				;AN000;DT Get panels
	     @@:						;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	endif_l_5:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	insert the OPERATING #2 diskette.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   CALL  GET_OVERLAY					;AN000;DT Get panels
	@@:							;AN000;DT
								;
	;;; insert OPERATING #2 diskette in drive A:		;
	INSERT_DISK		SUB_INS_OPER2, S_DOS_UTIL2_DISK	;AN000;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	  Display copying files from OPERATING #2
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying from diskette 1 message
	DISPLAY_PANEL						;AN000;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   DEALLOCATE_MEMORY					;AN000;DT
	@@:							;AN000;DT
								;
	;;;replace files in drive C: with new files on OPERATING 2 diskette
	EXEC_PROGRAM	     S_STR120_2,S_STR120_3,PARM_BLOCK,EXEC_DIR ;AN006;JW
	jnc endif_l_6						;AN000;
	  cmp MEM_SIZE,256					;AN000;DT
	  jne @F
	     CALL  GET_OVERLAY					;AN000;DT Get panels
	  @@:							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	endif_l_6:						;AN000;
								;
	;;;S_STR120_1 = "a:*.* C:\<path> /A "                   ;
	;;;copy NEW files on OPERATING 2 diskette to install path
	EXEC_PROGRAM	     S_STR120_2,S_STR120_1,PARM_BLOCK,EXEC_DIR ;AN000; copy new files
	jnc endif_l_7						;AN000;
	     cmp MEM_SIZE,256					;AN000;DT
	     jne @F
		CALL  GET_OVERLAY				;AN000;DT Get panels
	     @@:						;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	endif_l_7:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	insert the OPERATING #3 diskette.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   CALL  GET_OVERLAY					;AN000;DT Get panels
	@@:							;AN000;DT
								;
	;;; insert OPERATING #3 diskette in drive A:		;
	INSERT_DISK		SUB_REM_UTIL1_360, S_DOS_UTIL3_DISK	;AN000;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	  Display copying files from OPERATING #3
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying from diskette 1 message
	DISPLAY_PANEL						;AN000;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   DEALLOCATE_MEMORY					;AN000;DT
	@@:							;AN000;DT
								;
	;;;replace files in drive C: with new files on OPERATING 2 diskette
	EXEC_PROGRAM	     S_STR120_2,S_STR120_3,PARM_BLOCK,EXEC_DIR ;AN006;JW
	jnc endif_l_8						;AN000;
	  cmp MEM_SIZE,256					;AN000;DT
	  jne @F
	     CALL  GET_OVERLAY					;AN000;DT Get panels
	  @@:							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	endif_l_8:						;AN000;
								;
	;;;S_STR120_1 = "a:*.* C:\<path> /A "                   ;
	;;;copy NEW files on OPERATING 2 diskette to install path
	EXEC_PROGRAM	     S_STR120_2,S_STR120_1,PARM_BLOCK,EXEC_DIR ;AN000; copy new files
	jnc endif_l_9						;AN000;
	     cmp MEM_SIZE,256					;AN000;DT
	     jne @F
		CALL  GET_OVERLAY				;AN000;DT Get panels
	     @@:						;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	endif_l_9:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	insert the SELECT diskette.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne else_l_10
	   CALL  GET_OVERLAY					;AN000;DT Get panels
	jmp short endif_l_10
	else_l_10:						;AN000;DT
	   ;;; insert the SELECT diskette in drive A		;
	   INSERT_DISK	SUB_REM_SHELL_360, S_DOS_SEL_360	;AN000;JW
	endif_l_10:						;AN000;DT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	  Display copying files from SELECT diskette
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying from diskette 1 message
	DISPLAY_PANEL						;AN000;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   DEALLOCATE_MEMORY					;AN000;DT
	@@:							;AN000;DT
								;
	;;;replace files in drive C: with new files on SELECT diskette
	EXEC_PROGRAM	     S_STR120_2,S_STR120_3,PARM_BLOCK,EXEC_DIR	 ;AN006;JW
	jnc endif_l_11						;AN000;
	  cmp MEM_SIZE,256					;AN000;DT
	  jne @F
	     CALL  GET_OVERLAY					;AN000;DT Get panels
	  @@:							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	endif_l_11:						;AN000;
								;
	;;;S_STR120_1 = "a:*.* C:\<path> /A "                   ;
	;;;copy new files on SELECT diskette to install path	;
	EXEC_PROGRAM	     S_STR120_2,S_STR120_1,PARM_BLOCK,EXEC_DIR;AN000; copy new files
	jnc endif_l_12						;AN000;
	     cmp MEM_SIZE,256					;AN000;DT
	     jne @F
		CALL  GET_OVERLAY				;AN000;DT Get panels
	     @@:						;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	endif_l_12:						;AN000;
								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	maybe insert the SHELL diskette.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp f_shell,e_shell_yes
	jne endif_l_15
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   CALL  GET_OVERLAY					;AN000;DT Get panels
	@@:							;AN000;DT
								;
	INSERT_DISK	SUB_INS_MSSHELL_A, S_DOS_SHEL_DISK	;AN000;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	  Display copying files from SHELL diskette
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying from diskette 1 message
	DISPLAY_PANEL						;AN000;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   DEALLOCATE_MEMORY					;AN000;DT
	@@:							;AN000;DT
								;
	;;;replace files in drive C: with new files on SHELL diskette
	EXEC_PROGRAM	     S_STR120_2,S_STR120_3,PARM_BLOCK,EXEC_DIR	 ;AN006;JW
	jnc endif_l_13						;AN000;
	  cmp MEM_SIZE,256					;AN000;DT
	  jne @F
	     CALL  GET_OVERLAY					;AN000;DT Get panels
	  @@:							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	endif_l_13:						;AN000;
								;
	;;;S_STR120_1 = "a:*.* C:\<path> /A "                   ;
	;;;copy NEW files on SHELL diskette to install path
	EXEC_PROGRAM	     S_STR120_2,S_STR120_1,PARM_BLOCK,EXEC_DIR;AN000; copy new files
	jnc endif_l_14						;AN000;
	     cmp MEM_SIZE,256					;AN000;DT
	     jne @F
		CALL  GET_OVERLAY				;AN000;DT Get panels
	     @@:						;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	endif_l_14:						;AN000;

	endif_l_15:  	; optional shell support
								

	;Delete select files from C: drive			;
	COMPARE_STRINGS      S_INSTALL_PATH, S_DEST_DRIVE	;AN007; compare to C:\
	jc else_l_16						;AN007; if installed to the root
	   MERGE_STRING 	S_STR120_1,M_STR120_1,S_C_DRIVE,S_SELDAT_C  ;AN000;
	   ERASE_FILE		S_STR120_1			;AN000;DT
	   MERGE_STRING 	S_STR120_1,M_STR120_1,S_C_DRIVE,S_SELEXE_C  ;AN000;
	   ERASE_FILE		S_STR120_1			;AN000;DT
	jmp endif_l_16
	else_l_16:						;AN007; else installed to a directory
	   MERGE_STRING 	S_STR120_1,M_STR120_1,S_INSTALL_PATH,S_SELDAT_C   ;AN000;
	   ERASE_FILE		S_STR120_1			;AN000;DT
	   MERGE_STRING 	S_STR120_1,M_STR120_1,S_INSTALL_PATH,S_SELEXE_C   ;AN000;
	   ERASE_FILE		S_STR120_1			;AN000;DT
	   MERGE_STRING 	S_STR120_1,M_STR120_1,S_INSTALL_PATH,S_AUTOEX_C   ;AN000;
	   ERASE_FILE		S_STR120_1			;AN000;DT
	   MERGE_STRING 	S_STR120_1,M_STR120_1,S_INSTALL_PATH,S_CONSYS_C   ;AN000;
	   ERASE_FILE		S_STR120_1			;AN000;DT
	endif_l_16:						;AN007;
								;
     endif_l_17:						;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;360KB;;;;360KB;;;;360KB;;;;360KB;;;;360KB;;;;360KB;;;;360KB;;
;
;			End of 360KB support
;
;	Installation completed.  inform user to reboot
;
;	Search for the installed CONFIG.340 , and
;	we issue a different panel to describe the '.340' files.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
								;
	cmp MEM_SIZE,256	 				;AN000;DT
	jne @F
	   ALLOCATE_MEMORY					;AN000;DT
	   CALL    INITIALIZE					;AN000;DT and read them in
	@@:							;AN000;DT
								;
	INIT_PQUEUE		PAN_COMPLETE1			;AN000; initialize queue
	cmp I_DESTINATION,E_ENTIRE_DISK				;AN010;JW
	je else_l_19
	   PREPARE_PANEL	PAN_PARTIAL			;AN010;JW
	jmp short endif_l_19
	else_l_19:						;AN010;JW
	   FIND_FILE		   S_CONFIG_REN, E_FILE_ATTR	;AN003;GHG Look for '.340' files
	   jnc else_l_18					;AN003;GHG
	      PREPARE_PANEL	   SUB_COMP_VER 		;AN003;GHG prepare DOS install message
	   jmp short endif_l_18
	   else_l_18:						;AN003;GHG
	      PREPARE_PANEL	   SUB_COMP_REP 		;AN003;GHG prepare DOS Replace message
	   endif_l_18:						;AN003;GHG
	endif_l_19:						;AN010;
								;
	PREPARE_PANEL		SUB_COMP_KYS_1			;AN000;
	DISPLAY_PANEL						;AN000;
	SAVE_PANEL_LIST 					;AN000;
								;
	GET_FUNCTION		FK_REBOOT			;AN000; User has to reboot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PUBLIC GET_OVERLAY						;AN000;
GET_OVERLAY	PROC NEAR					;AN000;
	   cmp N_DISKETTE_A,E_DISKETTE_720			;AN063;SEH
	   je endif_l_20
	       CLEAR_SCREEN					;AN000;
	       DISPLAY_MESSAGE 12				;AN000;DT Insert SELECT diskette
	       repeat_l_1:					;AN000;
		   GET_FUNCTION 	   FK_ENT		;AN000; get user entered function
		   FIND_FILE		S_DOS_SEL_360, E_FILE_ATTR    ;AN000;
		   jnc endrepeat_l_1				;AN000;
			DISPLAY_MESSAGE 11			;AN000;DT Beep
	       jmp repeat_l_1					;AN000;
	       endrepeat_l_1:
	   endif_l_20:						;AN063;SEH
	   ALLOCATE_MEMORY					;AN000;DT
	   CALL    INITIALIZE					;AN000;DT and read them in
	   RET							;AN000;
GET_OVERLAY	ENDP						;AN000;
								;
SELECT	ENDS							;AN000;
	END							;AN000;

