

PAGE 55,132							;AN000;
NAME	SELECT							;AN000;
TITLE	SELECT - DOS - SELECT.EXE				;AN000;
SUBTTL	SELECT6.asm						;AN000;
;RLC .ALPHA								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	SELECT6.ASM : Copyright 1988 Microsoft
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
;	;AN007; JW for D239 - display drive letter to format
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'                              ;AN000;
	EXTRN	SEL_FLG:BYTE					;AN000;
	EXTRN	EXEC_FDISK:BYTE 				;AN000;DT
	EXTRN	EXEC_ERR:BYTE					;AN000;DT
DATA	ENDS							;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Define dummy segment to calculate end of program
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PARSER	 SEGMENT PARA PUBLIC 'PARSER'   ;AN072;
PARSER	 ENDS				;AN072;

SET_BLOCK	equ	4AH		;AN072;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.XLIST								;AN000;
	INCLUDE    panel.mac					;AN000;
	INCLUDE    select.inc					;AN000;
	INCLUDE    castruc.inc					;AN000;
	INCLUDE    macros.inc					;AN000;
	INCLUDE    macros7.inc					;AN009;DT
	INCLUDE    ext.inc					;AN000;
	INCLUDE    varstruc.inc 				;AN000;
	INCLUDE    rout_ext.inc 				;AN000;
	INCLUDE    pan-list.inc 				;AN000;
.LIST								;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
								;
	EXTRN	DEALLOCATE_HELP:FAR				;AN000;DT
	EXTRN	DEALLOCATE_BLOCK:FAR				;AN000;DT
	EXTRN	ALLOCATE_BLOCK:FAR				;AN000;DT
	EXTRN	DEALLOCATE_MEMORY_CALL:FAR			;AN000;DT
	EXTRN	ALLOCATE_MEMORY_CALL:FAR			;AN000;DT
	EXTRN	GET_OVERLAY:NEAR				;AN048;SEH
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
      ; EXTRN	DO_PREP_FOR_ONE:NEAR				;AN009;DT
      ; EXTRN	DO_HOOK15:NEAR					;AN009;DT
      ; EXTRN	DO_UNHOOK15:NEAR				;AN009;DT
								;
	EXTRN	EXIT_DOS:near					;AN004;GHG
	EXTRN	INSTALL_ERROR:near				;AN004;GHG
	EXTRN	EXIT_SELECT:NEAR				;AN004;GHG
	EXTRN	PROCESS_ESC_F3:near				;AN004;GHG
	EXTRN	DISKETTE_INSTALL:NEAR				;AN111;JW
	EXTRN	EXIT_DOS_CONT:NEAR				;AN004;GHG
	EXTRN	CONTINUE_360:NEAR				;AN004;GHG
								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	CODE CONTINUES.....
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 PUBLIC FORMAT_DISK_SCREEN				;AN000;
FORMAT_DISK_SCREEN:						;AN000;
								;
	 CALL  DEALLOCATE_HELP					;AN072;Help no longer needed
	 POS_CURSOR						;AN085;SEH position cursor at top left corner so that future "% formatted" msg appears in correct spot
	 CALL  CURSOROFF					;AN082;SEH
								;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_C				;AN111;JW
	je @F
	   GOTO_ 		DISKETTE_INSTALL		;AN111;JW
	@@:							;AN000;
								;
;	N_WORD_1 : disk number					;
;	N_WORD_2 : index into disk table			;
;	N_WORD_3 : sub panel number for specified disk		;
								;
	INIT_VAR		N_WORD_1, 1			;AN000; set disk no = 1
	repeat_l_2: 						;AN000; repeat code block
	   INIT_VAR		N_WORD_2, 1			;AN000;    set index into table = 1
	   cmp N_WORD_1,E_DISK_1	 			;AN000;    if disk = 1
	   jne else_l_1
	      INIT_VAR		N_DISK_NUM, '1'                 ;AN007;       sub panel = fixed disk 1   JW
	   jmp short endif_l_1
	   else_l_1:						;AN000;    else
	      INIT_VAR		N_DISK_NUM, '2'                 ;AN007;       sub panel = fixed disk 2   JW
	   endif_l_1:						;AN000;
								;
	   repeat_l_1:						;AN000;    repeat code block
	      SCAN_DISK_TABLE	N_WORD_1,N_WORD_2,N_RETCODE	;AN000;       scan disk table
	      cmp N_RETCODE,0					;AN000;       break loop if no more entries
	      jne endrepeat_l_1
								;
	      cmp N_NAME_PART,E_PART_PRI_DOS			;AN000;       if pri part & unformatted
	      jne elseif_l_3
	      cmp N_STATUS_PART,E_PART_UNFORMAT			;AN000;
	      jne elseif_l_3
		 INIT_VAR	       N_TYPE_PART, E_PART_FAT	;AN000; 	 set to format as FAT
	      jmp endif_l_3
	      elseif_l_3:
	      cmp N_NAME_PART,E_PART_LOG_DRI			;AN000;       if log drive & unformatted
	      jne endif_l_3
	      cmp N_STATUS_PART,E_PART_UNFORMAT			;AN000;
	      jne endif_l_3
		 cmp N_FORMAT_MODE,E_FORMAT_SELECT		;AN000; 	 if select to format partition
		 jne else_l_2
		    INIT_VAR		N_TYPE_PART, E_PART_FAT ;AN000; 	    set to format as FAT
		 jmp endif_l_2
		 else_l_2:					;AN000; 	 else
		    INIT_CHAR		N_DISK_NUM, E_DISK_ROW, E_DISK_COL,SUB_FIXED_1 ;AN007;	display the disk number        JW
		    INIT_CHAR		P_DRIVE_PART, E_DRIVE_ROW, E_DRIVE_COL,SUB_LOG_DRIVE ;AN000; display the drive letter  JW
		    INIT_PQUEUE 	PAN_FORMAT		;AN000; 	    init format panel
		    PREPARE_PANEL	PAN_HBAR		;AN000; 	    prepare hor. bar panel
		    PREPARE_PANEL	SUB_FIXED_1		;AC007; 	    prepare disk no panel	JW
		    PREPARE_PANEL	SUB_LOG_DRIVE		;AN000;JW
		    PREPARE_CHILDREN				;AN000; 	    prepare children
		    INIT_VAR		F_FORMAT, E_FORMAT_FAT	;AN000; 	    set option=format as FAT
		    INIT_SCROLL 	SCR_FORMAT, F_FORMAT	;AN000; 	    init scroll list
		    DISPLAY_PANEL				;AN000; 	    display panel
		    GET_SCROLL		SCR_FORMAT,F_FORMAT,FK_FORMAT ;AN000;	    get option
		    COPY_WORD		F_FORMAT, I_USER_INDEX	;AN000; 	    save option
		    cmp F_FORMAT,E_FORMAT_FAT			;AN000; 	    if option=format
		    jne @F
		       INIT_VAR 	N_TYPE_PART, E_PART_FAT ;AN000; 	       set to format as FAT
		    @@:						;AN000;
		 endif_l_2: 					;AN000;
	      endif_l_3:						;AN000;
	      UPDATE_DISK_TABLE 	N_WORD_1,N_WORD_2,N_RETCODE   ;AN000;  update disk table
	      INC_VAR			N_WORD_2		;AN000;       inc index into table
	   jmp repeat_l_1					;AN000;    end of repeat block
	   endrepeat_l_1:
	   INC_VAR			N_WORD_1		;AN000;    inc disk no
	cmp N_WORD_1,2						;AN000; end of repeat block
	jle repeat_l_2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Format the logical drives and primary partition
;	    N_WORD_1 : disk number
;	    N_WORD_2 : index into disk table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INIT_VAR		N_WORD_1, 1			;AN000; set disk no = 1
	repeat_l_5: 						;AN000; repeat code block
	   INIT_VAR		N_WORD_2, 1			;AN000;    set index into disk table = 1
	   repeat_l_3:						;AN000;    repeat code block
	      SCAN_DISK_TABLE	N_WORD_1,N_WORD_2,N_RETCODE	;AN000;       scan disk table
	      cmp N_RETCODE,0					;AN000;       break loop in index not valid
	      jne endrepeat_l_3
	      cmp N_STATUS_PART,E_PART_UNFORMAT			;AN000;       if partition not unformatted and
	      jne endif_l_5
	      cmp N_TYPE_PART,E_PART_FAT			;AN000; 	 format set to FAT
	      jne endif_l_5
		 COPY_BYTE	P_STR120_1, P_DRIVE_PART	;AN000; 	 save drive letter in buffer
		 INIT_VAR	S_STR120_1, 1			;AN000; 	 set length of string
		 APPEND_STRING	S_STR120_1, M_STR120_1, S_COLON ;AN000; 	 append colon to drive
		 cmp N_NAME_PART,E_PART_PRI_DOS			;AN111; 	 if primary partition and	JW
		 jne @F
		 cmp N_WORD_1,1					;AN111; 	 first drive			JW
		 jne @F
		    APPEND_STRING	S_STR120_1,M_STR120_1,S_SLASH_S      ;AN000; append ' /s' to drive
		    INIT_VAR		I_DESTINATION, E_ENTIRE_DISK  ;AN033; SEH install to entire disk if formatting
		 @@:	 					;AN000;
		 APPEND_STRING		S_STR120_1,M_STR120_1,S_VOL_SEL     ;AN000;  append "/V:DOS340 /SELECT"
		 CLEAR_SCREEN					;AN000; 	 pos cursor at top of screen
		 INIT_PQUEUE		FORMAT_DISK		;AN000; 	 initialize queue
		 DISPLAY_PANEL					;AN000;
								;
		cmp MEM_SIZE,256	 			;AN000;DT
		jne @F
		   DEALLOCATE_MEMORY				;AN000;DT
		@@:						;AN000;DT
								;
		 EXEC_PROGRAM	S_FORMAT,S_STR120_1,PARM_BLOCK,EXEC_NO_DIR  ;AN000;   format partition as FAT
		 jnc @F						;AN000;
		     MOV   EXEC_ERR,TRUE			;AN000;
		 @@:	 					;AN000;
								;
		cmp MEM_SIZE,256				;AN000;DT
		jne endif_l_4
		   CLEAR_SCREEN 				;AN000;
		   DISPLAY_MESSAGE 12				;AN000;DT Insert SELECT diskette
		   repeat_l_4:					;AN000;
		       GET_FUNCTION	       FK_ENT		;AN000; get user entered function
		       FIND_FILE	    S_DOS_SEL_360, E_FILE_ATTR;AN000;
		       jnc endrepeat_l_4			;AN000;
			  DISPLAY_MESSAGE 11			;AN000;DT Beep
		   jmp repeat_l_4				;AN000;
		   endrepeat_l_4:
		   ALLOCATE_MEMORY				;AN000;DT
		   CALL    INITIALIZE				;AN000;DT and read them in
		   CALL  DEALLOCATE_HELP				  ;AN072;Help no longer needed
								;
		  INSERT_DISK	SUB_INSTALL_COPY, S_AUTO_NEW	;AN000;JW Insert INSTALL COPY diskette
								;
		endif_l_4:					;AN000;
								;
		cmp EXEC_ERR,TRUE				;AN000;
		jne @F
		    HANDLE_ERROR	ERR_COPY_DISK, E_RETURN ;AN000;
		@@:						;AN000;
	      endif_l_5:					;AN000;
	      INC_VAR		N_WORD_2			;AN000;
	   jmp repeat_l_3					;AN000;
	   endrepeat_l_3:
	   INC_VAR		N_WORD_1			;AN000;
	cmp N_WORD_1,2						;AN000;
	jle repeat_l_5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GET_TIME		N_HOUR, N_MINUTE, N_SECOND	;AN000; get system time
	GET_DATE		N_YEAR, N_MONTH, N_DAY		;AN000; get system date
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	    Update date/time of CONFIG.340
;				AUTOEXEC.340
;				DOSSHELL.BAT	in drive A: ;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	OPEN_FILE		S_CONFIG_NEW, 2, N_HANDLE	;AN000;
	SET_FILE_DATE_TIME	N_HANDLE,N_HOUR,N_MINUTE,N_SECOND,N_YEAR,N_MONTH,N_DAY ;AN000;
	CLOSE_FILE		N_HANDLE			;AN000;
	jnc @F							;AN000;
	   GOTO_        INSTALL_ERROR				;AN000;
	@@:							;AN000;
								;
	OPEN_FILE		S_AUTO_NEW, 2, N_HANDLE 	;AN000;
	SET_FILE_DATE_TIME	N_HANDLE,N_HOUR,N_MINUTE,N_SECOND,N_YEAR,N_MONTH,N_DAY ;AN000;
	CLOSE_FILE		N_HANDLE			;AN000;
	jnc @F							;AN000;
	   GOTO_        INSTALL_ERROR				;AN000;
	@@:							;AN000;
								;
	OPEN_FILE		S_SHELL_NEW, 2, N_HANDLE	;AN009;DT
	SET_FILE_DATE_TIME	N_HANDLE,N_HOUR,N_MINUTE,N_SECOND,N_YEAR,N_MONTH,N_DAY ;AN009;DT
	CLOSE_FILE		N_HANDLE			;AN009;DT
	jnc @F							;AN009;DT
	   GOTO_        INSTALL_ERROR				;AN009;DT
	@@:							;AN009;DT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Make sure any previous AUTOEXEC.340 or CONFIG.340
;	are not READ-ONLY !
;	Copy CONFIG.340 & AUTOEXEC.340 from A: to root of C:
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CHMOD_FILE	     S_AUTO_REN 			;AN017;
	CHMOD_FILE	     S_CONFIG_REN			;AN017;
	COPY_FILES2	     I_DEST_DRIVE,S_CONFIG_AUTO,E_FILES,S_DEST_DRIVE	    ;AC111;JW
	jnc @F							;AN000;
	   HANDLE_ERROR      ERR_COPY_DISK, E_RETURN		;AN000;
	@@:							;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	If the user selected to replace files throughout the fixed disk:
;	1) Copy COMMAND.COM to root of C:
;	2) Check if OS/2 is installed.	If it is, rename CONFIG.SYS and
;	   AUTOEXEC.BAT (OS2'S) to CONFIG.OS2 and AUTOEXEC.OS2. Then
;	   rename CONFIG.400 and AUTOEXEC.400 to CONFIG.SYS and
;	   AUTOEXEC.BAT.
;	3) Try to locate C:\CONFIG.SYS & C:\AUTOEXEC.BAT (if OS/2 not installed)
;	   If either one is already present, then leave the names
;	   of the new files as CONFIG.400 and AUTOEXEC.400!
;	   Otherwise, the CONFIG.400 and AUTOEXEC.400 become the
;	   new user's SYS and BAT files.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cmp I_DESTINATION,E_ENTIRE_DISK				;AN010;JW
	jne endif_l_9
								;
	   cmp MEM_SIZE,256					;AN048;SEH memory must be freed up
	   jne @F
	      DEALLOCATE_MEMORY 				;AN048;SEH before reading COMMAND.COM
	   @@:							;AN048;SEH
	   CHMOD_FILE		S_COMMAND_COM			;AN017;
	   COPY_FILES2		I_DEST_DRIVE,COPY_SEL_SHEL,E_SEL_SHEL,S_DEST_DRIVE     ;AC010;JW
	   jnc @F					       ;AN000;
	       MOV   EXEC_ERR,TRUE			       ;AN000;
	   @@:						       ;AN000;
	   cmp MEM_SIZE,256		 			;AN000;DT
	   jne @F
	       CALL	     GET_OVERLAY			 ;AC048;SEH replaced code with this proc call
	       INSERT_DISK   SUB_INSTALL_COPY, S_DOS_COM_360	 ;AN000;JW Insert INSTALL COPY diskette
	       CALL  DEALLOCATE_HELP				      ;AN072;Help no longer needed
	   @@:							;AN000;DT
	   cmp EXEC_ERR,TRUE					;AN000;
	   jne @F
	       HANDLE_ERROR	   ERR_COPY_DISK, E_RETURN	 ;AN000;
	   @@:							;AN000;
	   INIT_VAR		N_WORD_1,1			;AN065;SEH set disk no. = 1
	   INIT_VAR		N_WORD_2,1			;AN065;SEH set index into disk table = 1
	   SCAN_DISK_TABLE	N_WORD_1,N_WORD_2,N_RETCODE	;AN065;SEH get version number
	   cmp N_RETCODE,0					;AN065;SEH
	   jne else_l_8
	   cmp N_LEVEL2_PART,'4'				;AN065;SEH is it OS/2? 1st byte of DOS version number = blank; for OS/2 it's 1
	   je else_l_8
	       RENAME_FILE	S_CONFIG_C, S_OS2_CONFIG_C	;AN065;SEH rename OS/2's CONFIG.SYS to CONFIG.OS2
	       RENAME_FILE	S_AUTO_C, S_OS2_AUTO_C		;AN065;SEH rename OS/2's AUTOEXEC.BAT to AUTOEXEC.OS2
	       RENAME_FILE	S_CONFIG_REN, S_CONFIG_NEW_C	;AN065;SEH rename CONFIG.400 to CONFIG.SYS
	       jnc @F						;AN065;SEH
		   HANDLE_ERROR ERR_COPY_DISK, E_RETURN 	;AN065;SEH
	       @@:						;AN065;SEH
	       RENAME_FILE	S_AUTO_REN, S_AUTO_NEW_C	;AN065;SEH rename AUTOEXEC.400 to AUTOEXEC.BAT
	       jnc endif_l_8					;AN065;SEH
		   HANDLE_ERROR ERR_COPY_DISK, E_RETURN 	;AN065;SEH
	   jmp endif_l_8
	   else_l_8:						;AN065;SEH
	       FIND_FILE	    S_CONFIG_C, E_FILE_ATTR	;AN000;GHG
	       jnc endif_l_7					;AN000;GHG
		   FIND_FILE	    S_AUTO_C, E_FILE_ATTR	;AN000;GHG
		   jnc endif_l_6				;AN000;GHG
		       RENAME_FILE  S_CONFIG_REN, S_CONFIG_NEW_C;AN000;GHG new CONFIG  *******
		      jnc @F	 				;AN000;GHG
			   HANDLE_ERROR  ERR_COPY_DISK, E_RETURN;AN000;GHG
		      @@:					;AN000;GHG
		       RENAME_FILE  S_AUTO_REN, S_AUTO_NEW_C	;AN000;GHG new AUTOEXEC *******
		      jnc @F	 				;AN000;GHG
			   HANDLE_ERROR  ERR_COPY_DISK, E_RETURN;AN000;GHG
		      @@:					;AN000;GHG
		   endif_l_6:					;AN000;GHG
	       endif_l_7:					;AN000;GHG
	   endif_l_8:						;AN065;SEH
	endif_l_9:						;AN010;JW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	   Create install path directory always !
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MAKE_DIR_PATHS		S_INSTALL_PATH			;AN000;
	jnc @F							;AN000;
	   GOTO_        INSTALL_ERROR				;AN000;
	@@:							;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Make sure any previous DOSSHELL.BAT is not READ-ONLY !
;	Copy DOSSHELL.BAT from A: to subdirectory  of C:
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cmp S_DOS_LOC,0							      ;AN058;SEH
	jne else_l_10
	    MERGE_STRING     S_STR120_1,M_STR120_1,S_DEST_DRIVE,S_SHELL_NEW   ;AN058;SEH
	jmp short endif_l_10
	else_l_10:							      ;AN058;SEH
	    MERGE_STRING     S_STR120_1,M_STR120_1,S_INSTALL_PATH,S_SLASH     ;AN017;
	    APPEND_STRING    S_STR120_1,M_STR120_1,S_SHELL_NEW	;AN017;
	endif_l_10:						;AN058;SEH
	CHMOD_FILE	     S_STR120_1 			;AN017;
	COPY_FILES2	     I_DEST_DRIVE,S_SHELL2,SH_FILES,S_INSTALL_PATH    ;AC111;JW
	jnc @F							;AN009;
	   HANDLE_ERROR      ERR_COPY_DISK, E_RETURN		;AN009;
	@@:							;AN009;
								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Erase:	 AUTOEXEC.340	CONFIG.340
;		 DOSSHELL.BAT	SELECT.TMP   from drive A:
;
;	Then perform cleanup of AUTOEXEC.BAT on INSTALL (source)
;	diskette - ie. change to SELECT MENU!!!
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ERASE_FILE		S_AUTO_NEW			;AN000;
	ERASE_FILE		S_CONFIG_NEW			;AN000;
	ERASE_FILE		S_SHELL_NEW			;AN000;
	ERASE_FILE		S_SELECT_TMP			;AN000; only present if reboot after FDISK
								;
	CHANGE_AUTOEXEC 	S_AUTO_REBOOT, S_AUTO_MENU	;AN000;
	jnc @F							;AN000;
	   HANDLE_ERROR        ERR_COPY_DISK, E_RETURN		;AN000;
	@@:							;AN000;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; If 256KB machine, shrink SELECT memory below the parser
; and pcinput code.  This frees about another 11KB.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	 cmp MEM_SIZE,256				      ;AN072;
	 jne endif_l_11
							      ;
	    DEALLOCATE_MEMORY				      ;AN072;
	    MOV   AH,62H				      ;AN072;Get the PSP segment
	    INT   21H					      ;AN072;
	    MOV   AX,BX 				      ;AN072;save the PSP segment of SELECT
	    MOV   BX,PARSER				      ;AN072;get last address of code
	    MOV   ES,AX 				      ;AN072;set PSP segment in ES
	    SUB   BX,AX 				      ;AN072;calc # of paragraphs in the program
	    MOV   AH,SET_BLOCK				      ;AN072;setblock function number
	    DOSCALL					      ;AN072;free used memory

	   jnc @F					       ;AN000;
	       CALL	     GET_OVERLAY			 ;AC048;SEH replaced code with this proc call
	       INSERT_DISK   SUB_INSTALL_COPY, S_DOS_COM_360	 ;AN000;JW Insert INSTALL COPY diskette
	       GOTO_    INSTALL_ERROR			     ;AN072;If error, exit
	   @@:							;AN000;

	 endif_l_11:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	If install is to entire disk, Exec SYS to the drive C:
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp I_DESTINATION,E_ENTIRE_DISK				;AN010;
	jne endif_l_12
								;
	   ;;;copy system files from Startup diskette to drive C:

	   EXEC_PROGRAM 	S_SYS_C,S_DRIVE_C,PARM_BLOCK,EXEC_DIR	 ;AN000;
	   jnc @F					       ;AN000;
	       MOV   EXEC_ERR,TRUE			       ;AN000;
	   @@:						       ;AN000;

	endif_l_12:						;AN010;JW

	cmp MEM_SIZE,256				      ;AN000;DT
	jne @F
	    CALL	  GET_OVERLAY			      ;AC048;SEH replaced code with this proc call
	    INSERT_DISK   SUB_INSTALL_COPY, S_DOS_COM_360     ;AN000;JW Insert INSTALL COPY diskette
	    CALL	  DEALLOCATE_HELP		      ;AN072;DT
	@@:						      ;AN000;DT
	cmp EXEC_ERR,TRUE				      ;AN000;
	jne @F
	    HANDLE_ERROR	ERR_COPY_DISK, E_RETURN       ;AN000;
	@@:						      ;AN000;
								;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;
;
;	Display copying files from INSTALL diskette
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     cmp N_DISKETTE_A,E_DISKETTE_720				;AN000;GHG
     je @F
     cmp N_DISKETTE_A,E_DISKETTE_1440				;AN000;GHG
     je @F
     jmp endif_l_15
     @@:
								;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		PAN_DSKCPY_CPY			;AN000; prepare copying
	DISPLAY_PANEL						;AN000; from diskette 2 msg
								;
	;;;S_STR120_1 = "a:*.* c:\path /a parameter for REPLACE
	MERGE_STRING	     S_STR120_1,M_STR120_1,S_A_STARS,S_INSTALL_PATH ;AN000;
	APPEND_STRING	     S_STR120_1,M_STR120_1,S_SLASH_A	;AN000;
								;
;	.IF < I_DESTINATION eq E_ENTIRE_DISK >			;AN006;JW
;	.THEN							;AN006;
;	   ;;;S_STR120_3 = "a:*.* c:\ /s parameter for REPLACE
;	   COPY_STRING	     S_STR120_3,M_STR120_3,S_REPLACE_PAR1     ;AN006;JW
;	.ELSE							;AN006;
	   ;;;S_STR120_3 = "a:*.* c:\<path> /r parameter for REPLACE
	   MERGE_STRING      S_STR120_3,M_STR120_3,S_A_STARS,S_INSTALL_PATH ;AN006;JW
	   APPEND_STRING     S_STR120_3,M_STR120_3,S_SLASH_R	;AN000;JW
;	.ENDIF							;AN006;
								;
	   ;;;change attributes of some files so they are not copied
	   CHANGE_ATTRIBUTE	HIDE_SEL, E_HIDE_SEL		;AN000;
								;
	   ;;;replace files in drive C: with new files on INSTALL diskette
	   EXEC_PROGRAM 	S_REPLACE,S_STR120_3,PARM_BLOCK,EXEC_DIR    ;AN006;JW
	   jnc @F						;AN000;
	      RESTORE_ATTRIBUTE    HIDE_SEL,E_HIDE_SEL		;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	   @@:							;AN000;
								;
	   ;;;S_STR120_1 = "a:*.* C:\<path> /A"                 ;
	   ;;;copy new files on SELECT diskette to install path ;
	   EXEC_PROGRAM 	S_REPLACE,S_STR120_1,PARM_BLOCK,EXEC_DIR    ;AN000; copy new files
	   jnc @F						;AN000;
	      RESTORE_ATTRIBUTE    HIDE_SEL,E_HIDE_SEL		;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	   @@:							;AN000;
								;
	   ;;;restore attributes of files			;
	   RESTORE_ATTRIBUTE	HIDE_SEL,E_HIDE_SEL		;AN000;
								;

;-------------------------------------------------------------
; copy files from 720k Operate diskette
;-------------------------------------------------------------
;	NOTE:  The REPLACE command is now issued from the hard disk
;	       (since it is not found on any other disk)

	COMPARE_STRINGS      S_INSTALL_PATH, S_DEST_DRIVE	;AN000; compare to C:\
	jc else_l_13						;AN000; if the same
	    MERGE_STRING	 S_STR120_2,M_STR120_2,S_INSTALL_PATH,S_REPLACE   ;AN000;
	jmp short endif_l_13
	else_l_13:						;AN000;
	    MERGE_STRING	 S_STR120_2,M_STR120_2,S_INSTALL_PATH,S_SLASH	  ;AN000;
	    APPEND_STRING	 S_STR120_2,M_STR120_2,S_REPLACE;AN000;
	endif_l_13:						;AN000;

	INSERT_DISK		SUB_REM_SEL_A, S_DOS_UTIL1_DISK	;AN000;JW Insert Operating diskette
								;
	;;;display copying files from diskette 1 screen 	;
	INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	PREPARE_PANEL		PAN_DSKCPY_CPY			;AN000; prepare copying from diskette 1 message
	DISPLAY_PANEL						;AN000;
								;
	   ;;;replace files in drive C: with new files on DOS diskette
	   EXEC_PROGRAM 	S_STR120_2,S_STR120_3,PARM_BLOCK,EXEC_DIR    ;AN006;JW
	   jnc @F						;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	   @@:							;AN000;
								;
	   ;;;S_STR120_1 = "a:*.* C:\<path> /A "                ;
	   ;;;copy new files on DOS diskette to install path	;
	   EXEC_PROGRAM 	S_STR120_2,S_STR120_1,PARM_BLOCK,EXEC_DIR    ;AN000; copy new files
	   jnc @F						;AN000;
	      HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	   @@:							;AN000;
;-------------------------------------------------------------
; copy files from 720k Shell diskette
;-------------------------------------------------------------

	cmp f_shell,e_shell_yes
	jne endif_l_14
								;
	    INSERT_DISK		SUB_INS_MSSHELL_A, S_DOS_SHEL_DISK	;AN000;JW Insert Operating diskette
								;
	    ;;;display copying files from diskette 1 screen 	;
	    INIT_PQUEUE		PAN_INSTALL_DOS 		;AN000; initialize queue
	    PREPARE_PANEL		PAN_DSKCPY_CPY			;AN000; prepare copying from diskette 1 message
	    DISPLAY_PANEL						;AN000;
								;
	    ;;;replace files in drive C: with new files on DOS diskette
	    EXEC_PROGRAM 	S_STR120_2,S_STR120_3,PARM_BLOCK,EXEC_DIR    ;AN006;JW
	    jnc @F						;AN000;
	       HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	    @@:							;AN000;
								;
	    ;;;S_STR120_1 = "a:*.* C:\<path> /A "                ;
	    ;;;copy new files on DOS diskette to install path	;
	    EXEC_PROGRAM 	S_STR120_2,S_STR120_1,PARM_BLOCK,EXEC_DIR    ;AN000; copy new files
	    jnc @F						;AN000;
	       HANDLE_ERROR	  ERR_COPY_DISK, E_RETURN	;AN000;
	    @@:							;AN000;

	endif_l_14:		; IF shell supported


     endif_l_15:						;AN000;GHG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;;;720KB;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;		     End of 720KB support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GOTO_		CONTINUE_360				;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	ENDS							;AN000;
	END							;AN000;
