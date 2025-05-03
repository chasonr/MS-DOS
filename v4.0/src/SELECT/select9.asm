

PAGE 55,132
NAME	SELECT
TITLE	SELECT - DOS - SELECT.EXE
SUBTTL	SELECT9.asm
;RLC .ALPHA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	SELECT9.ASM : Copyright 1988 Microsoft
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
;
;  Module contains code for :
;	- Format the drives
;	- Copy files
;
;	CHANGE HISTORY:
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'
	EXTRN	DSKCPY_ERR:BYTE
	EXTRN	DSKCPY_WHICH:BYTE
	EXTRN	DSKCPY_OPTION:BYTE
	EXTRN	DSKCPY_PAN1:WORD
	EXTRN	DSKCPY_PAN2:WORD
	EXTRN	DSKCPY_PAN3:WORD
	EXTRN	DSKCPY_SOURCE:WORD
DATA	ENDS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Define dummy segment to calculate end of program
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PARSER	 SEGMENT PARA PUBLIC 'PARSER'
PARSER	 ENDS

SET_BLOCK	equ	4AH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.XLIST
	INCLUDE    panel.mac
	INCLUDE    select.inc
	INCLUDE    pan-list.inc
	INCLUDE    castruc.inc
	INCLUDE    macros.inc
	INCLUDE    macros7.inc
	INCLUDE    macros8.inc
	INCLUDE    ext.inc
	INCLUDE    varstruc.inc
	INCLUDE    rout_ext.inc
.LIST
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	SEGMENT PARA PUBLIC 'SELECT'
	ASSUME	CS:SELECT,DS:DATA

	INCLUDE casextrn.inc

	EXTRN	EXIT_SELECT:near
	EXTRN	CREATE_CONFIG_SYS:NEAR
	EXTRN	CREATE_AUTOEXEC_BAT:NEAR
	EXTRN	CREATE_SHELL_BAT:NEAR
	EXTRN	DEALLOCATE_HELP:FAR
	EXTRN	DEALLOCATE_MEMORY_CALL:FAR
	EXTRN	ALLOCATE_BLOCK:FAR
	EXTRN	ALLOCATE_LVB:FAR
	EXTRN	GET_OVERLAY:NEAR
	EXTRN	ALLOCATE_MEMORY_CALL:FAR

	PUBLIC	INSTALL_TO_360_DRIVE
	PUBLIC	INSTALL_ERROR
	PUBLIC	EXIT_DOS,PROCESS_ESC_F3
	PUBLIC	EXIT_DOS_CONT
	public	Free_Parser

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSTALL_TO_360_DRIVE:
	 cmp MEM_SIZE,256
	 jne endif_l_1
	    DEALLOCATE_MEMORY
	    call  Free_Parser
	    jnc @F
		GOTO_	INSTALL_ERROR
	    @@:
	    CALL  GET_OVERLAY
	    INSERT_DISK   SUB_REM_DOS_A, S_DOS_COM_360
	 endif_l_1:

	 ;;;Introduction to 360KB install
	 INIT_PQUEUE		 PAN_INSTALL_DOS
	 PREPARE_PANEL		 PAN_START360
	 PREPARE_PANEL		 PAN_HBAR
	 PREPARE_CHILDREN
	 DISPLAY_PANEL

	 GET_FUNCTION		 FK_ENT

	 CALL DEALLOCATE_HELP

	cmp I_DEST_DRIVE,E_DEST_DRIVE_A
	jne else_l_20

	    ;;;diskcopy INSTALL diskette to WORKING1
	    DISKCOPY_TO 	    DSKCPY_TO_A_360,NO_SOURCE1,S_DOS_COM_360
	    DISKCOPY_PANELS	    SUB_REM_DOS_A,SUB_COPYING,SUB_INS_WORK1_S360
	    repeat_l_1:
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_1
	    ERASE_FILE		    S_AUTOEX_C
	    ERASE_FILE		    S_CONSYS_C
	    ERASE_FILE		    S_SELCOM_C
	    ERASE_FILE		    S_SELHLP_C
	    ERASE_FILE		    S_SELPRT_C

	    ;;;diskcopy OPERATING1 diskette to WORKING2
	    DISKCOPY_TO 	    DSKCPY_TO_A_360,SOURCE1,S_DOS_UTIL1_DISK
	    DISKCOPY_PANELS	    SUB_REM_SELECT_360,SUB_COPYING,SUB_INS_WORK2_S360
	    repeat_l_2:
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	       cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	       jne endrepeat_l_2
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_COM_360
	    jmp repeat_l_2
	    endrepeat_l_2:

	    ;;;diskcopy OPERATING 2 diskette to WORKING3
	    repeat_l_3:
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_COM_360
	       DISKCOPY_TO	DSKCPY_TO_A_360,NO_SOURCE1,S_DOS_UTIL2_DISK
	       DISKCOPY_PANELS	SUB_INS_OPER2,SUB_COPYING,SUB_INS_WORK3_A
	       INIT_VAR 	N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		HOOK_INT_2F
	       EXEC_PROGRAM	S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
	       CALL		RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_3
	    endrepeat_l_3:

	    ;;;diskcopy OPERATING 3 diskette to STARTUP
	    repeat_l_4:
		INSERT_DISK	    SUB_REM_DOS_A, S_DOS_COM_360
		DISKCOPY_TO 	    DSKCPY_TO_A_360,SOURCE1,S_DOS_UTIL3_DISK
		DISKCOPY_PANELS	    SUB_REM_UTIL1_360,SUB_COPYING,SUB_INS_STARTT_S360
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_4
	    ERASE_FILE		 S_RECOVER_C
	    ERASE_FILE		 S_FASTOPEN_C
	    ;;;create config and autoexec files on startup diskette
	    CREATE_CONFIG	    S_CONSYS_C, N_RETCODE
	    jnc @F
	       GOTO_	   INSTALL_ERROR
	    @@:
	    CREATE_AUTOEXEC	    S_AUTOEX_C,E_DEST_DOS,N_RETCODE
	    jnc @F
	       GOTO_	   INSTALL_ERROR
	    @@:

	   cmp ACTIVE,EGA
	   je @F
	   cmp ALTERNATE,EGA
	   je @F
	   cmp ACTIVE,LCD
	   je @F
	   cmp ALTERNATE,LCD
	   je @F
	   jmp endif_l_9
	   @@:
		cmp F_VDISK,E_VDISK_NO
		jne endif_l_2
		   ERASE_FILE	 S_VDISK_C
		   jnc @F
		      GOTO_	  INSTALL_ERROR
		   @@:
		endif_l_2:
		cmp F_ANSI,E_ANSI_NO
		jne endif_l_3
		   ERASE_FILE	 S_ANSI_C
		   jnc @F
		      GOTO_	  INSTALL_ERROR
		   @@:
		endif_l_3:
		cmp F_APPEND,E_APPEND_NO
		jne endif_l_4
		   ERASE_FILE	 S_APPEND_C
		   jnc @F
		      GOTO_	  INSTALL_ERROR
		   @@:
		endif_l_4:
		cmp F_GRAFTABL,E_GRAFTABL_NO
		je @F
		cmp F_GRAFTABL,E_GRAFTABL_NA
		jne endif_l_5
		@@:
		   ERASE_FILE	 S_GRAFTABL_C
		   jnc @F
		      GOTO_	  INSTALL_ERROR
		   @@:
		endif_l_5:
		cmp F_GRAPHICS,E_GRAPHICS_NO
		jne endif_l_6
		   ERASE_FILE	 S_GRAPHICS_C
		   ERASE_FILE	 S_GRAPHPRO_C
		   jnc @F
		      GOTO_	  INSTALL_ERROR
		   @@:
		endif_l_6:
		;;;Insert SELECT diskette in drive A:
		INSERT_DISK	SUB_REM_SHELL_360, S_DOS_SEL_360

		;;;copying files from INSTALL diskette screen
		INIT_PQUEUE		PAN_INSTALL_DOS
		PREPARE_PANEL		SUB_COPYING
		DISPLAY_PANEL

		INIT_VAR       SOURCE_PANEL, SUB_REM_SHELL_360
		INIT_VAR       DEST_PANEL, SUB_INS_STARTT_S360

		cmp ACTIVE,EGA
		je @F
		cmp ALTERNATE,EGA
		jne else_l_8
		@@:
		   cmp MEM_SIZE,256
		   jne @F
		      DEALLOCATE_MEMORY
		   @@:
		   COPY_FILES2	     I_DEST_DRIVE,COPY_SEL_EGA,E_SEL_EGA,S_INSTALL_PATH
		   jnc endif_l_7
		      cmp MEM_SIZE,256
		      jne @F
			 ALLOCATE_MEMORY
			 CALL	 INITIALIZE
		      @@:
		      HANDLE_ERROR   ERR_COPY_DISK, E_RETURN
		   endif_l_7:
		   cmp MEM_SIZE,256
		   jne endif_l_8
		      ALLOCATE_MEMORY
		      CALL    INITIALIZE
		jmp endif_l_8
		else_l_8:
		   COPY_FILES2	     I_DEST_DRIVE,COPY_SEL_LCD,E_SEL_LCD,S_INSTALL_PATH ;AC111; copy files to f-disk  JW
		   jnc @F
		      HANDLE_ERROR   ERR_COPY_DISK, E_RETURN
		   @@:
		endif_l_8:
	   endif_l_9:

	   ;;;diskcopy MS-SHELL diskette to SHELL
	   cmp f_shell,e_shell_yes
	   jne endif_l_20
	    repeat_l_5:
		INSERT_DISK	    SUB_REM_DOS_A, S_DOS_COM_360
		DISKCOPY_TO 	    DSKCPY_TO_A_360,SOURCE1,S_DOS_SHEL_DISK
		DISKCOPY_PANELS	    SUB_INS_MSSHELL_A,SUB_COPYING,SUB_INS_SHELL_S360
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DISKCOPY_PARM,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_5
	    CREATE_SHELL   S_SHELL_NEW, N_RETCODE
	    jnc endif_l_20
	       GOTO_	   INSTALL_ERROR
	   endif_l_10:

	jmp endif_l_20
	else_l_20:

	    ;;;diskcopy INSTALL diskette to WORKING 1
	    DISKCOPY_TO 	    DSKCPY_TO_B,SOURCE1,S_DOS_COM_360
	    DISKCOPY_PANELS	    SUB_INS_WORK1_360,SUB_COPYING,NOPANEL
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
	    ERASE_FILE		    S_AUTO_NEW_B
	    ERASE_FILE		    S_CONFIG_NEW_B
	    ERASE_FILE		    S_SELCOM_NEW_B
	    ERASE_FILE		    S_SELHLP_NEW_B
	    ERASE_FILE		    S_SELPRT_NEW_B

	    ;;;diskcopy OPERATING 1 diskette to WORKING 2
	    DISKCOPY_TO 	    DSKCPY_TO_B,SOURCE1,S_DOS_UTIL1_DISK
	    DISKCOPY_PANELS	    SUB_INS_WORK2_360,SUB_COPYING,NOPANEL
	    repeat_l_7:
	       INIT_VAR 	    N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		    HOOK_INT_2F
	       EXEC_PROGRAM	    S_DISKCOPY,S_DSKCPY_TO_B,PARM_BLOCK,EXEC_NO_DIR
	       CALL		    RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	       cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	       jne endrepeat_l_7
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_COM_360
	    jmp repeat_l_7
	    endrepeat_l_7:

	    ;;;diskcopy OPERATING 2 diskette to WORKING3
	    repeat_l_8:
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_COM_360
	       DISKCOPY_TO	DSKCPY_TO_B,SOURCE1,S_DOS_UTIL2_DISK
	       DISKCOPY_PANELS	SUB_INS_WORK3_360,SUB_COPYING,NOPANEL
	       INIT_VAR 	N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		HOOK_INT_2F
	       EXEC_PROGRAM	S_DISKCOPY,S_DSKCPY_TO_B,PARM_BLOCK,EXEC_NO_DIR
	       CALL		RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_8

	    ;;;diskcopy OPERATING 3 diskette to STARTUP
	    repeat_l_9:
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_COM_360
	       DISKCOPY_TO	DSKCPY_TO_B,SOURCE1,S_DOS_UTIL3_DISK
	       DISKCOPY_PANELS	SUB_INS_START_360,SUB_COPYING,NOPANEL
	       INIT_VAR 	N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		HOOK_INT_2F
	       EXEC_PROGRAM	S_DISKCOPY,S_DSKCPY_TO_B,PARM_BLOCK,EXEC_NO_DIR
	       CALL		RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_9
	    ERASE_FILE		 S_RECOVER_B
	    ERASE_FILE		 S_FASTOPEN_B
	    ;;;create config and autoexec files on startup diskette
	    CREATE_CONFIG	    S_CONFIG_NEW_B, N_RETCODE
	    jnc @F
	       GOTO_	   INSTALL_ERROR
	    @@:
	    CREATE_AUTOEXEC	    S_AUTO_NEW_B,E_DEST_DOS,N_RETCODE
	    jnc @F
	       GOTO_	   INSTALL_ERROR
	    @@:
	    cmp ACTIVE,EGA
	    je @F
	    cmp ALTERNATE,EGA
	    je @F
	    cmp ACTIVE,LCD
	    je @F
	    cmp ALTERNATE,LCD
	    je @F
	    jmp endif_l_18
	    @@:
	       cmp F_VDISK,E_VDISK_NO
	       jne endif_l_11
		  ERASE_FILE	S_VDISK_B
		  jnc @F
		     GOTO_	 INSTALL_ERROR
		  @@:
	       endif_l_11:
	       cmp F_ANSI,E_ANSI_NO
	       jne endif_l_12
		  ERASE_FILE	S_ANSI_B
		  jnc @F
		     GOTO_	 INSTALL_ERROR
		  @@:
	       endif_l_12:
	       cmp F_APPEND,E_APPEND_NO
	       jne endif_l_13
		  ERASE_FILE	S_APPEND_B
		  jnc @F
		     GOTO_	 INSTALL_ERROR
		  @@:
	       endif_l_13:
	       cmp F_GRAFTABL,E_GRAFTABL_NO
	       je @F
	       cmp F_GRAFTABL,E_GRAFTABL_NA
	       jne endif_l_14
	       @@:
		  ERASE_FILE	S_GRAFTABL_B
		  jnc @F
		     GOTO_	 INSTALL_ERROR
		  @@:
	       endif_l_14:
	       cmp F_GRAPHICS,E_GRAPHICS_NO
	       jne endif_l_15
		  ERASE_FILE	S_GRAPHICS_B
		  ERASE_FILE	S_GRAPHPRO_B
		  jnc @F
		     GOTO_	 INSTALL_ERROR
		  @@:
	       endif_l_15:
	       ;;;Insert SELECT diskette in drive A:
	       INSERT_DISK	SUB_INS_INSTALL_360, S_DOS_SEL_360
	       ;;;copying files from INSTALL diskette screen
	       INIT_PQUEUE	       PAN_INSTALL_DOS
	       PREPARE_PANEL	       SUB_COPYING
	       DISPLAY_PANEL
	       cmp ACTIVE,EGA
	       je @F
	       cmp ALTERNATE,EGA
	       jne elseif_l_17
	       @@:
		  cmp MEM_SIZE,256
		  jne @F
		      DEALLOCATE_MEMORY
		  @@:
		  COPY_FILES2	    I_DEST_DRIVE,COPY_SEL_EGA,E_SEL_EGA,S_INSTALL_PATH ;AC111; copy files to f-disk  JW
		  jnc endif_l_16
		      cmp MEM_SIZE,256
		      jne @F
			 ALLOCATE_MEMORY
			 CALL	 INITIALIZE
		      @@:
		     HANDLE_ERROR	 ERR_COPY_DISK, E_RETURN
		  endif_l_16:
		  cmp MEM_SIZE,256
		  jne endif_l_17
		      ALLOCATE_MEMORY
		      CALL    INITIALIZE
	       jmp endif_l_17
	       elseif_l_17:
	       cmp ACTIVE,LCD
	       je @F
	       cmp ALTERNATE,LCD
	       jne endif_l_17
	       @@:
	          COPY_FILES2    I_DEST_DRIVE,COPY_SEL_LCD,E_SEL_LCD,S_INSTALL_PATH ;AC111; copy files to f-disk JW
	          jnc @F
	       		HANDLE_ERROR	    ERR_COPY_DISK, E_RETURN
	          @@:
	       endif_l_17:
	    endif_l_18:

	   cmp f_shell,e_shell_yes
	   jne endif_l_19
	    ;;;diskcopy MS-SHELL to SHELL
	    repeat_l_10:
	       INSERT_DISK	SUB_REM_DOS_A, S_DOS_COM_360
	       DISKCOPY_TO	DSKCPY_TO_B,SOURCE1,S_DOS_SHEL_DISK
	       DISKCOPY_PANELS	SUB_INS_SHELL_DISKS,SUB_COPYING,NOPANEL
	       INIT_VAR 	N_DSKCPY_ERR,E_DSKCPY_OK
	       CALL		HOOK_INT_2F
	       EXEC_PROGRAM	S_DISKCOPY,S_DSKCPY_TO_B,PARM_BLOCK,EXEC_NO_DIR
	       CALL		RESTORE_INT_2F
	       jnc @F
		  GOTO_	      INSTALL_ERROR
	       @@:
	    cmp N_DSKCPY_ERR,E_DSKCPY_RETRY
	    je repeat_l_10
	    CREATE_SHELL   S_SHELL_NEW_B, N_RETCODE
	    jnc @F
	       GOTO_	   INSTALL_ERROR
	    @@:
	   endif_l_19:			; copy to shell

	endif_l_20:

	;;;installation complete and change diskettes screen
	INIT_PQUEUE		PAN_COMPLETE3
	PREPARE_PANEL		SUB_COMP_KYS_3
	DISPLAY_PANEL
	SAVE_PANEL_LIST
	GET_FUNCTION		FK_REBOOT

;;;;;;;;control will not return here. user has to reboot;;;;;;;;; end of install to 1.2M or 1.44M drive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Process the ESC/F3 keys.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PROCESS_ESC_F3:
	cmp N_USER_FUNC,E_ESCAPE
	jne @F
	   POP_HEADING
	@@:
EXIT_DOS:
	CLEAR_SCREEN2
EXIT_DOS_CONT:
	cmp I_DEST_DRIVE,E_DEST_DRIVE_C
	jne @F
	cmp N_HOUSE_CLEAN,E_CLEAN_YES
	jne @F
	   ERASE_FILE	   S_AUTO_NEW
	   ERASE_FILE	   S_CONFIG_NEW
	   ERASE_FILE	   S_SHELL_NEW
	   ERASE_FILE	   S_SELECT_TMP
	   CHANGE_AUTOEXEC S_AUTO_REBOOT, S_AUTO_MENU
	@@:

	GOTO_	EXIT_SELECT

INSTALL_ERROR:

	cmp DSKCPY_ERR,DSKCPY_EXIT
	je @F
	    HANDLE_ERROR    ERR_EXIT, E_QUIT
	@@:

	GOTO_	EXIT_DOS

Free_Parser:
	    MOV   AH,62H
	    INT   21H
	    MOV   AX,BX
	    MOV   BX,PARSER
	    MOV   ES,AX
	    SUB   BX,AX
	    MOV   AH,SET_BLOCK
	    DOSCALL
	    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	ENDS
	END

