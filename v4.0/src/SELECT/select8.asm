

PAGE 55,132							;AN000;
NAME	SELECT							;AN000;
TITLE	SELECT - DOS - SELECT.EXE				;AN000;
SUBTTL	SELECT8.asm						;AN000;
;RLC .ALPHA								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	SELECT8.ASM : Copyright 1988 Microsoft
;
;	DATE:	 August 8/87
;
;	COMMENTS: Assemble with MASM 3.0 (using the /A option)
;
;
;	CHANGE HISTORY:
;
;	;AN000; DT  added support for creation of the DOSSHELL.BAT as a
;		    separately installed file.	(D233)
;	;AN002; GHG for P1146
;	;AN003; GHG for D234
;	;AN004; GHG for P65
;	;AN005; DT for single drive support
;	;AN006; JW correct critical error problems during format/copy
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'                              ;AN000;
	EXTRN	   EXEC_ERR:BYTE				;AN063;SEH
	EXTRN	   BCHAR:BYTE					;AN000;DT
	EXTRN	DSKCPY_ERR:BYTE 				;AN000;DT
	EXTRN	DSKCPY_WHICH:BYTE				;AN000;DT
	EXTRN	DSKCPY_OPTION:BYTE				;AN000;DT
	EXTRN	DSKCPY_PAN1:WORD				;AN000;DT
	EXTRN	DSKCPY_PAN2:WORD				;AN000;DT
	EXTRN	DSKCPY_PAN3:WORD				;AN000;DT
	EXTRN	DSKCPY_SOURCE:WORD				;AN000;DT
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
	INCLUDE    ext.inc					;AN000;
	INCLUDE    varstruc.inc 				;AN000;
	INCLUDE    rout_ext.inc 				;AN000;
.LIST								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	EXTRN	ALLOCATE_MEMORY_CALL:FAR			;AN063;SEH
	EXTRN	DEALLOCATE_MEMORY_CALL:FAR			;AN063;SEH
	EXTRN	ALLOCATE_BLOCK:FAR				;AN000;DT
	EXTRN	PM_BASECHAR:BYTE				;AN000;
	EXTRN	PM_BASEATTR:BYTE				;AN000;
	EXTRN	CRD_CCBVECOFF:WORD				;AN000;
	EXTRN	CRD_CCBVECSEG:WORD				;AN000;
SELECT	SEGMENT PARA PUBLIC 'SELECT'                            ;AN000;
	ASSUME	CS:SELECT,DS:DATA				;AN000;
								;
	INCLUDE casextrn.inc					;AN000;
								;
	EXTRN	EXIT_SELECT:near				;AN000;
	EXTRN	CREATE_CONFIG_SYS:NEAR				;AN000;
	EXTRN	CREATE_AUTOEXEC_BAT:NEAR			;AN000;
	EXTRN	CREATE_SHELL_BAT:NEAR				;AN000;DT
	EXTRN	DEALLOCATE_HELP:FAR				;AN007;JW
								;
	EXTRN	INSTALL_TO_360_DRIVE:NEAR			;AN000;DT
	EXTRN	INSTALL_ERROR:NEAR				;AN000;
	EXTRN	EXIT_DOS:NEAR					;AN000;
	EXTRN	PROCESS_ESC_F3:NEAR				;AN000;
	EXTRN	EXIT_DOS_CONT:NEAR				;AN000;
	EXTRN	GET_ENTER_KEY:NEAR				;AN063;SEH
	EXTRN	GET_OVERLAY:NEAR				;AN063;SEH
	extrn	Free_Parser:near
	PUBLIC	DISKETTE_INSTALL				;AN111;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Install is to drive B: or drive A:
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISKETTE_INSTALL:						;AC111;JW
								;
	INIT_VAR	     F_PATH, E_PATH_NO			;AN000;
	INIT_VAR	     F_APPEND, E_APPEND_NO		;AN000;
	INIT_VAR	     F_PROMPT, E_PROMPT_NO		;AN000;
	INIT_VAR	     F_XMA, E_XMA_NO			;AN000;
	INIT_VAR	     F_FASTOPEN, E_FASTOPEN_NO		;AN000;
	INIT_VAR	     F_SHARE, E_SHARE_NO		;AN000;
	INIT_VAR	     S_INSTALL_PATH,0			;AN000;set install path field = 0
								;
	cmp N_DISKETTE_A,E_DISKETTE_360				;AN111;JW
	jne @F
	   GOTO_ 		INSTALL_TO_360_DRIVE		;AN111;JW
	@@:							;AN111;JW
								;
	cmp N_DISKETTE_A,E_DISKETTE_720				;AN111;JW
	jne @F
	    GOTO_		 INSTALL_TO_720_DRIVE		;AN111;JW
	@@:							;AN111;JW
								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	install is to 1.44M drives
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;Introduction to 1440KB install			;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		PAN_START1440			;AN000;
	PREPARE_PANEL		PAN_HBAR			;AN000;
	PREPARE_CHILDREN					;AN000; prepare child panels
	DISPLAY_PANEL						;AN000;
								;
	GET_FUNCTION		FK_ENT				;AN000;
								;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_B				;AN111;JW
	jne else_l_1
	   ;;;insert startup diskette in drive B:		;
	   INIT_PQUEUE		   PAN_INST_PROMPT		;AN000; initialize queue
	   PREPARE_PANEL	   SUB_INS_START_B		;AN000; insert startup diskette in drive B:
	   PREPARE_PANEL	   PAN_HBAR			;AN000; prepare horizontal bar
	   PREPARE_CHILDREN					;AN000; prepare child panels
	   DISPLAY_PANEL					;AN000; display panel
								;
	   GET_FUNCTION 	   FK_ENT			;AN000;
								;
	   ;;;formatting disk screen				;
	   INIT_PQUEUE		   FORMAT_DISKET		;AN000; initialize queue
	   DISPLAY_PANEL					;AN000;
								;
	   ;;;format startup diskette in drive B:		;
	   repeat_l_1:						;AN006;JW
	      EXEC_PROGRAM	      S_FORMAT,S_FORMAT_B,PARM_BLOCK,EXEC_NO_DIR;AN000; format startup disket & copy system files
	      jnc endrepeat_l_1					;AN006;JW
	      HANDLE_FORMAT_ERROR				;AN000;JW
	   jmp repeat_l_1					;AN006;JW
	   endrepeat_l_1:
								;
	   ;;;create config and autoexec files on startup diskette ;
	   CREATE_CONFIG	   S_CONFIG_NEW_B, N_RETCODE	;AN000; create CONFIG.SYS file
	   jnc @F						;AN000;
	      GOTO_	  INSTALL_ERROR 			;AN000;
	   @@:							;AN000;
	   CREATE_AUTOEXEC	   S_AUTO_NEW_B,E_DEST_SHELL,N_RETCODE;AN000; create AUTOEXEC.BAT file with SHELL pars
	   jnc endif_l_1					;AN000;
	      GOTO_	  INSTALL_ERROR 			;AN000;
	jmp endif_l_1						;
	else_l_1:						;AN111; install is to 1.44 meg A: drive     JW
								;
	   ;;;format startup diskette in drive A:		;
	   ;;;use format int2f call to display panels		;
	   INIT_VAR	   FORMAT_WHICH,STARTUP 		;AN111;JW
	   repeat_l_2:						;AN006;JW
	      HOOK_2F_FORMAT					;AN111;JW
	      EXEC_PROGRAM    S_FORMAT,S_FORMAT_A,PARM_BLOCK,EXEC_NO_DIR    ;AN000; format startup disket & copy system files
	      jnc endrepeat_l_2					;AN006;JW
	      UNHOOK_2F 					;AN111;JW
	      HANDLE_FORMAT_ERROR				;AN000;JW
	      INSERT_DISK     SUB_REM_DOS_A, S_DOS_SEL_360	;AN000;
	   jmp repeat_l_2					;AN006;JW
	   endrepeat_l_2:
	   UNHOOK_2F						;AN111;JW
								;
	   ;;;create config and autoexec files on startup diskette ;
	   CREATE_CONFIG	   S_CONSYS_C, N_RETCODE	;AN000; create CONFIG.SYS file
	   jnc @F						;AN000;
	      GOTO_	  INSTALL_ERROR 			;AN000;
	   @@:							;AN000;
	   CREATE_AUTOEXEC  S_AUTOEX_C,E_DEST_SHELL,N_RETCODE	;AN000; create AUTOEXEC.BAT file with SHELL pars
	   jnc @F						;AN000;
	      GOTO_	  INSTALL_ERROR 			;AN000;
	   @@:							;AN000;
								;
	   ;;; insert the INSTALL diskette in drive A:		;
	   INSERT_DISK		   SUB_REM_DOS_A, S_DOS_SEL_360 ;AN000;
								;
	endif_l_1:						;AN000;
								;
	;;;copying files screen 				;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN111; prepare copying files message JW
	DISPLAY_PANEL						;AN000;
								;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_A				;AN111;JW
	jne @F
	   INIT_VAR	  SOURCE_PANEL, SUB_REM_DOS_A		;AN000;
	   INIT_VAR	  DEST_PANEL, SUB_INS_STARTT_S360	;AN000;
	@@:							;AN000;
								;
	;;;copy all files from INSTALL diskette to STARTUP diskette
	COPY_FILES     I_DEST_DRIVE,COPY_INST_1200_1440,E_INST_1200_1440;AN000;
	jnc @F							;AN000;
	   GOTO_        INSTALL_ERROR				;AN000;
	@@:							;AN000;
								;
	;;; insert OPERATING diskette in A:			;
	INSERT_DISK	SUB_REM_SEL_A, S_DOS_UTIL1_DISK		;AN000;
								;
	;;;copying files screen 				;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying files message
	DISPLAY_PANEL						;AN000;
								;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_A				;AN111;JW
	jne @F
	   INIT_VAR	  SOURCE_PANEL, SUB_REM_SEL_A		;AN111;JW
	   INIT_VAR	  DEST_PANEL, SUB_INS_STARTT_S360	;AN111;JW
	@@:							;AN000;
								;
	;;;copy all files from OPERATING diskette to STARTUP diskette;
	COPY_FILES	  I_DEST_DRIVE,COPY_OPER_1200_1440,E_OPER_1200_1440;AN000;
	jnc @F							;AN000;
	   GOTO_ 	  INSTALL_ERROR 			;AN000;
	@@:							;AN000;

	cmp f_shell,e_shell_yes					; install the shell?
	jne endif_l_2

	   ;;; insert MS-SHELL diskette in A:			;
	   INSERT_DISK	SUB_INS_MSSHELL_A, S_DOS_SHEL_DISK		;AN000;
								;
	   ;;;copying files screen 				;
	   INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	   PREPARE_PANEL		SUB_COPYING			;AN000; prepare copying files message
	   DISPLAY_PANEL						;AN000;
								;
	   cmp I_DEST_DRIVE,E_DEST_DRIVE_A			;AN111;JW
	   jne @F
	      INIT_VAR	  SOURCE_PANEL, SUB_INS_MSSHELL_A		;AN111;JW
	      INIT_VAR	  DEST_PANEL, SUB_INS_STARTT_S360	;AN111;JW
	   @@:							;AN000;
								;
	   ;;;copy all files from OPERATING diskette to STARTUP diskette;
	   COPY_FILES	  I_DEST_DRIVE,COPY_SHELL_1200_1440,E_SHELL_1200_1440;AN000;
	   jnc @F						;AN000;
	      GOTO_ 	  INSTALL_ERROR 			;AN000;
	   @@:							;AN000;

	endif_l_2:	; installing the shell
								;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_B				;AN111;JW
	jne else_l_3
	   CREATE_SHELL   S_SHELL_NEW_B, N_RETCODE		;AN000;DT
	   jnc endif_l_3					;AN000;DT
	      GOTO_	  INSTALL_ERROR 			;AN000;DT
	jmp short endif_l_3					;AN000;DT
	else_l_3:						;AN000;
	   CREATE_SHELL   S_SHELL_NEW, N_RETCODE		;AN000;DT
	   jnc @F						;AN000;DT
	      GOTO_	  INSTALL_ERROR 			;AN000;DT
	   @@:							;AN000;DT
	endif_l_3:						;AN000;
								;
	;;;installation complete screen 			;
	INIT_PQUEUE		PAN_COMPLETE2			;AN000; initialize queue
	PREPARE_PANEL		SUB_COMP_KYS_1C 		;AN000;
	DISPLAY_PANEL						;AN000;
	SAVE_PANEL_LIST 					;AN000;
								;
	GET_FUNCTION		FK_REBOOT			;AN000;
;;;;;;;;control will not return here. user has to reboot;;;;;;;;; end of install to 1.44M drive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;    Install to 720K drive
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSTALL_TO_720_DRIVE:
	cmp MEM_SIZE,256
	jne endif_l_4
	   DEALLOCATE_MEMORY
	   call  Free_Parser
	   jnc @F
		GOTO_	INSTALL_ERROR
	   @@:
	   CALL  GET_OVERLAY
	   INSERT_DISK   SUB_REM_DOS_A, S_DOS_COM_360
	endif_l_4:

	;;;Introduction to 720KB install
	INIT_PQUEUE		PAN_INSTALL_DOS
	PREPARE_PANEL		PAN_START720
	PREPARE_PANEL		PAN_HBAR
	PREPARE_CHILDREN
	DISPLAY_PANEL

	GET_FUNCTION		FK_ENT

	CALL DEALLOCATE_HELP

	cmp I_DEST_DRIVE,E_DEST_DRIVE_A
	jne else_l_7

	    ;;;diskcopy INSTALL diskette to STARTUP diskette
	    DISKCOPY_TO 	    DSKCPY_TO_A_360,NO_SOURCE1,S_DOS_SEL_360
	    DISKCOPY_PANELS	    SUB_REM_DOS_A,SUB_COPYING,SUB_INS_STARTT_S360
	    repeat_l_3:
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_3
	    ; delete unneeded files
	    ERASE_FILE		    S_AUTOEX_C
	    ERASE_FILE		    S_CONSYS_C
	    ERASE_FILE		    S_SELEXE_C
	    ERASE_FILE		    S_SELHLP_C
	    ERASE_FILE		    S_SELPRT_C
	    ERASE_FILE		    S_SELDAT_C
	    ; make config.sys and autoexec.bat
	    create_config	s_consys_c, n_retcode
	    jnc @F
	    	goto_ install_error
	    @@:
	    create_autoexec	s_autoex_c, e_dest_dos, n_retcode
	    jnc @F
	    	goto_ install_error
	    @@:

	    ;;; diskcopy OPERATE diskette to WORKING diskette
	    repeat_l_4:
		DISKCOPY_TO 	    DSKCPY_TO_A_360,SOURCE1,S_DOS_UTIL1_DISK
		DISKCOPY_PANELS	    SUB_REM_SEL_A,SUB_COPYING,SUB_INS_WORKING_A
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	       cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	       jne endrepeat_l_4
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_SEL_360
	    jmp repeat_l_4
	    endrepeat_l_4:

	    ;;;perhaps diskcopy MS-SHELL to SHELL
	    cmp f_shell,e_shell_yes
	    jne endif_l_7
		repeat_l_5:
		    INSERT_DISK		SUB_REM_DOS_A, S_DOS_SEL_360
		    DISKCOPY_TO		DSKCPY_TO_A_360,SOURCE1,S_DOS_SHEL_DISK
		    DISKCOPY_PANELS	SUB_INS_MSSHELL_A,SUB_COPYING,SUB_INS_SHELL_S360
		    INIT_VAR		N_DSKCPY_ERR,E_DSKCPY_OK
		    CALL		HOOK_INT_2F
		    EXEC_PROGRAM	S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
		    CALL		RESTORE_INT_2F
		    jnc @F
			GOTO_		INSTALL_ERROR
		    @@:
		cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
		je repeat_l_5
		; make config.sys and autoexec.bat
		create_config	s_consys_c, n_retcode
		jnc @F
		    goto_ install_error
		@@:
		create_autoexec	s_autoex_c, e_dest_shell, n_retcode
		jnc @F
		    goto_ install_error
		@@:
		create_shell		s_shell_new, n_retcode
		jnc endif_l_7
		    goto_ install_error
	    endif_l_6:

	jmp endif_l_7
	else_l_7: 		; This is a two floppy system.  Install from A to B.

	    ;;;diskcopy INSTALL diskette to STARTUP diskette
	    DISKCOPY_TO 	    DSKCPY_TO_B,SOURCE1,S_DOS_SEL_360
	    DISKCOPY_PANELS	    SUB_INS_START_B,SUB_COPYING,NOPANEL
	    repeat_l_6:
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DSKCPY_TO_B,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_6
	    ; delete unneeded files
	    ERASE_FILE		    S_AUTO_NEW_B
	    ERASE_FILE		    S_CONFIG_NEW_B
	    ERASE_FILE		    S_SELEXE_NEW_B
	    ERASE_FILE		    S_SELHLP_NEW_B
	    ERASE_FILE		    S_SELPRT_NEW_B
	    ERASE_FILE		    S_SELDAT_NEW_B
	    ; make config.sys and autoexec.bat
	    create_config	s_config_new_b, n_retcode
	    jnc @F
	    	goto_ install_error
	    @@:
	    create_autoexec	s_auto_new_b, e_dest_dos, n_retcode
	    jnc @F
	    	goto_ install_error
	    @@:

	    ;;; diskcopy OPERATE diskette to WORKING diskette
	    repeat_l_7:
		DISKCOPY_TO 	    DSKCPY_TO_B,SOURCE1,S_DOS_UTIL1_DISK
		DISKCOPY_PANELS	    SUB_INS_OP_WORK,SUB_COPYING,NOPANEL
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DSKCPY_TO_B,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	       cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	       jne endrepeat_l_7
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_SEL_360
	    jmp repeat_l_7
	    endrepeat_l_7:

	    ;;;perhaps diskcopy MS-SHELL to SHELL
	    cmp f_shell,e_shell_yes
	    jne endif_l_8
		repeat_l_8:
		    INSERT_DISK		SUB_REM_DOS_A, S_DOS_SEL_360
		    DISKCOPY_TO		DSKCPY_TO_B,SOURCE1,S_DOS_SHEL_DISK
		    DISKCOPY_PANELS	SUB_INS_SHELL_DISKS,SUB_COPYING,NOPANEL
		    INIT_VAR		N_DSKCPY_ERR,E_DSKCPY_OK
		    CALL		HOOK_INT_2F
		    EXEC_PROGRAM	S_DISKCOPY,S_DSKCPY_TO_B,PARM_BLOCK,EXEC_NO_DIR
		    CALL		RESTORE_INT_2F
		    jnc @F
			GOTO_		INSTALL_ERROR
		    @@:
		cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
		je repeat_l_8
		; make config.sys and autoexec.bat
		create_config	s_config_new_b, n_retcode
		jnc @F
		    goto_ install_error
		@@:
		create_autoexec	s_auto_new_b, e_dest_shell, n_retcode
		jnc @F
		    goto_ install_error
		@@:
		create_shell		s_shell_new_b, n_retcode
		jnc @F
		    goto_ install_error
		@@:
	    endif_l_8:
	endif_l_7:	; end if two drive 720 installation


	;;;installation complete and change diskettes screen
	INIT_PQUEUE		PAN_COMPLETE2
	PREPARE_PANEL		SUB_COMP_KYS_2
	DISPLAY_PANEL
	SAVE_PANEL_LIST
	GET_FUNCTION		FK_REBOOT
;;;;;;;;control will not return here. user has to reboot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	ENDS
	END

