PAGE	55,132						;AN000;
NAME	SELECT						;AN000;
TITLE	SELECT - SELECT.EXE				;AN000;
SUBTTL	GEN_COMS					;AN000;
;RLC .ALPHA							;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	GEN_COMS.ASM : Copyright 1988 Microsoft
;
;	DATE:	 August 8/87
;
;	COMMENTS: Assemble with MASM 3.0 (using the -A option)
;
;	Module contains code for :
;		- creation of AUTOEXEC file
;		- creation of CONFIG file
;		- creation of DOSSHELL.BAT
;
;	CHANGE HISTORY:
;
;	;AN000;  for	      DT
;	;AN001;  for PTM1181  GHG
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	 DATA SEGMENT
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DATA	SEGMENT BYTE PUBLIC 'DATA'                              ;AN000;
								;
SC_CD		DW	MC_CD					;AN000;
PC_CD		DB	'@CD '                                  ;AN000;
MC_CD		EQU	$ - PC_CD				;AN000;
								;
SC_BREAK	DW	MC_BREAK				;AN000;
PC_BREAK	DB	'BREAK='                                ;AN000;
MC_BREAK	EQU	$ - PC_BREAK				;AN000;
								;
SC_CPSW 	DW	MC_CPSW 				;AN000;
PC_CPSW 	DB	'CPSW='                                 ;AN000;
MC_CPSW 	EQU	$ - PC_CPSW				;AN000;
								;
SC_VERIFY	DW	MC_VERIFY				;AN000;
PC_VERIFY	DB	'VERIFY '                               ;AN000;
MC_VERIFY	EQU	$ - PC_VERIFY				;AN000;
								;
SC_COUNTRY	DW	MC_COUNTRY				;AN000;
PC_COUNTRY	DB	'COUNTRY='                              ;AN000;
MC_COUNTRY	EQU	$ - PC_COUNTRY				;AN000;
								;
SC_COUNTRY_SYS	DW	MC_COUNTRY_SYS				;AN000;
PC_COUNTRY_SYS	DB	'COUNTRY.SYS'                           ;AN000;
MC_COUNTRY_SYS	EQU	$ - PC_COUNTRY_SYS			;AN000;
								;
SC_BUFFERS	DW	MC_BUFFERS				;AN000;
PC_BUFFERS	DB	'BUFFERS='                              ;AN000;
MC_BUFFERS	EQU	$ - PC_BUFFERS				;AN000;
								;
SC_SLASH_X	DW	MC_SLASH_X				;AC046;SEH changed from /E
PC_SLASH_X	DB	' /X'                                   ;AC046;SEH
MC_SLASH_X	EQU $ - PC_SLASH_X				;AC046;SEH
								;
SC_FCBS 	DW	MC_FCBS 				;AN000;
PC_FCBS 	DB	'FCBS='                                 ;AN000;
MC_FCBS 	EQU	$ - PC_FCBS				;AN000;
								;
SC_FILES	DW	MC_FILES				;AN000;
PC_FILES	DB	'FILES='                                ;AN000;
MC_FILES	EQU	$ - PC_FILES				;AN000;
								;
SC_LASTDRIVE	DW	MC_LASTDRIVE				;AN000;
PC_LASTDRIVE	DB	'LASTDRIVE='                            ;AN000;
MC_LASTDRIVE	EQU	$ - PC_LASTDRIVE			;AN000;
								;
SC_STACKS	DW	MC_STACKS				;AN000;
PC_STACKS	DB	'STACKS='                               ;AN000;
MC_STACKS	EQU	$ - PC_STACKS				;AN000;
								;
SC_SHELL	DW	MC_SHELL				;AN000;
PC_SHELL	DB	'SHELL='                                ;AN000;
MC_SHELL	EQU	$ - PC_SHELL				;AN000;
								;
SC_SHELL_1	DW	MC_SHELL_1				;AN000;
PC_SHELL_1	DB	'COMMAND.COM'                           ;AC037; SEH  Split the original SC_SHELL_1 into
MC_SHELL_1	EQU	$ - PC_SHELL_1				;AC037; SEH    3 parts
								;
SC_SHELL_2	DW	MC_SHELL_2				;AN037; SEH  Used for diskettes only
PC_SHELL_2	DB	' /MSG'                                 ;AN037; SEH
MC_SHELL_2	EQU	$ - PC_SHELL_2				;AN037; SEH
								;
SC_SHELL_3	DW	MC_SHELL_3				;AN037; SEH  Use for diskettes and hardfile
PC_SHELL_3	DB	' /P /E:256  '                          ;AN037; SEH  Two spaces required for CR and LF
MC_SHELL_3	EQU	$ - PC_SHELL_3 - 2			;AN037; SEH
								;
SC_DEVICE	DW	MC_DEVICE				;AN000;
PC_DEVICE	DB	'DEVICE='                               ;AN000;
MC_DEVICE	EQU	$ - PC_DEVICE				;AN000;
								;
SC_XMAEM_SYS	DW	MC_XMAEM_SYS				;AN000;
PC_XMAEM_SYS	DB	'XMAEM.SYS '                            ;AN000;
MC_XMAEM_SYS	EQU	$ - PC_XMAEM_SYS			;AN000;
								;
SC_XMA2EMS_SYS	DW	MC_XMA2EMS_SYS				;AN000;
PC_XMA2EMS_SYS	DB	'XMA2EMS.SYS '                          ;AN000;
MC_XMA2EMS_SYS	EQU	$ - PC_XMA2EMS_SYS			;AN000;
								;
SC_ANSI_SYS	DW	MC_ANSI_SYS				;AN000;
PC_ANSI_SYS	DB	'ANSI.SYS '                             ;AN000;
MC_ANSI_SYS	EQU	$ - PC_ANSI_SYS 			;AN000;
								;
SC_VDISK_SYS	DW	MC_VDISK_SYS				;AN000;
PC_VDISK_SYS	DB	'RAMDRIVE.SYS '                         ;AN000;
MC_VDISK_SYS	EQU	$ - PC_VDISK_SYS			;AN000;
								;
SC_DISPLAY_SYS	DW	MC_DISPLAY_SYS				;AN000;
PC_DISPLAY_SYS	DB	'DISPLAY.SYS CON=('                     ;AN000;
MC_DISPLAY_SYS	EQU	$ - PC_DISPLAY_SYS			;AN000;
								;
		PUBLIC	SC_DISPLAY_EGA				;AN000;
SC_DISPLAY_EGA	DW	MC_DISPLAY_EGA				;AN000;
PC_DISPLAY_EGA	DB	'EGA.CPI)'                              ;AN000;
MC_DISPLAY_EGA	EQU	$ - PC_DISPLAY_EGA			;AN000;
								;
		PUBLIC	SD_DISPLAY_EGA				;AN001;GHG
SD_DISPLAY_EGA	DW	MD_DISPLAY_EGA				;AN001;GHG
PD_DISPLAY_EGA	DB	'EGA'                                   ;AN001;GHG
MD_DISPLAY_EGA	EQU	$ - PD_DISPLAY_EGA			;AN001;GHG
								;
		PUBLIC	SC_DISPLAY_LCD				;AN000;
SC_DISPLAY_LCD	DW	MC_DISPLAY_LCD				;AN000;
PC_DISPLAY_LCD	DB	'LCD.CPI)'                              ;AN000;
MC_DISPLAY_LCD	EQU	$ - PC_DISPLAY_LCD			;AN000;
								;
		PUBLIC	SD_DISPLAY_LCD				;AN001;GHG
SD_DISPLAY_LCD	DW	MD_DISPLAY_LCD				;AN001;GHG
PD_DISPLAY_LCD	DB	'LCD'                                   ;AN001;GHG
MD_DISPLAY_LCD	EQU	$ - PD_DISPLAY_LCD			;AN001;GHG
								;
SC_PRINTER_SYS	DW	MC_PRINTER_SYS				;AN000;
PC_PRINTER_SYS	DB	'PRINTER.SYS '                          ;AN000;
MC_PRINTER_SYS	EQU	$ - PC_PRINTER_SYS			;AN000;
								;
SC_LPT		DW	MC_LPT					;AN000;
PC_LPT		DB	'LPT'                                   ;AN000;
MC_LPT		EQU	$ - PC_LPT				;AN000;
								;
SC_COM		DW	MC_COM					;AN011; SEH
PC_COM		DB	'COM'                                   ;AN011; SEH
MC_COM		EQU	$ - PC_COM				;AN011; SEH
								;
SC_EQUAL_OPEN	DW	MC_EQUAL_OPEN				;AN000;
PC_EQUAL_OPEN	DB	'=('                                    ;AN000;
MC_EQUAL_OPEN	EQU	$ - PC_EQUAL_OPEN			;AN000;
								;
SC_437		DW	MC_437					;AN000;
PC_437		DB	',437,'                                 ;AN000;
MC_437		EQU	$ - PC_437				;AN000;
								;
SC_COMMA	DW	MC_COMMA				;AN000;
PC_COMMA	DB	','                                     ;AN000;
MC_COMMA	EQU	$ - PC_COMMA				;AN000;
								;
SC_INSTALL	DW	MC_INSTALL				;AN000;
PC_INSTALL	DB	'INSTALL='                              ;AN000;
MC_INSTALL	EQU	$ - PC_INSTALL				;AN000;
								;
SC_KEYB_C	DW	MC_KEYB_C				;AN000;
PC_KEYB_C	DB	'KEYB.COM '                             ;AN000;
MC_KEYB_C	EQU	$ - PC_KEYB_C				;AN000;
								;
SC_KEYBOARD_SYS DW	MC_KEYBOARD_SYS 			;AN000;
PC_KEYBOARD_SYS DB	'KEYBOARD.SYS'                          ;AN000;
MC_KEYBOARD_SYS EQU	$ - PC_KEYBOARD_SYS			;AN000;
								;
SC_KEYB_SWITCH	DW	MC_KEYB_SWITCH				;AN002;JW
PC_KEYB_SWITCH	DB	' /ID:'                                 ;AN002;JW
MC_KEYB_SWITCH	EQU	$ - PC_KEYB_SWITCH			;AN002;JW
								;
SC_SHARE	DW	MC_SHARE				;AN000;
PC_SHARE	DB	'SHARE.EXE '                            ;AN000;
MC_SHARE	EQU	$ - PC_SHARE				;AN000;
								;
SC_FASTOPEN	DW	MC_FASTOPEN				;AN000;
PC_FASTOPEN	DB	'FASTOPEN.EXE '                         ;AN000;
MC_FASTOPEN	EQU	$ - PC_FASTOPEN 			;AN000;
								;
SC_NLSFUNC	DW	MC_NLSFUNC				;AN000;
PC_NLSFUNC	DB	'NLSFUNC.EXE '                          ;AN000;
MC_NLSFUNC	EQU	$ - PC_NLSFUNC				;AN000;
								;
SC_ECHO 	DW	MC_ECHO 				;AN000;
PC_ECHO 	DB	'@ECHO OFF  '                           ;AN000;  TWO SPACES REQUIRED FOR CR,LF
MC_ECHO 	EQU	$ - PC_ECHO - 2 			;AN000;
								;
SC_PATH 	DW	MC_PATH 				;AN000;
PC_PATH 	DB	'PATH '                                 ;AN000;
MC_PATH 	EQU	$ - PC_PATH				;AN000;
								;
SC_APPEND	DW	MC_APPEND				;AN000;
PC_APPEND	DB	'APPEND '                               ;AN000;
MC_APPEND	EQU	$ - PC_APPEND				;AN000;
								;
SC_PROMPT	DW	MC_PROMPT				;AN000;
PC_PROMPT	DB	'PROMPT '                               ;AN000;
MC_PROMPT	EQU	$ - PC_PROMPT				;AN000;
								;
SC_SET_COMSPEC	DW	MC_SET_COMSPEC				;AN000;
PC_SET_COMSPEC	DB	'SET COMSPEC='                          ;AN000;
MC_SET_COMSPEC	EQU	$ - PC_SET_COMSPEC			;AN000;
								;
SC_COMMAND_COM	DW	MC_COMMAND_COM				;AN000;
PC_COMMAND_COM	DB	'COMMAND.COM'                           ;AN000;
MC_COMMAND_COM	EQU	$ - PC_COMMAND_COM			;AN000;
								;
SC_GRAPHICS	DW	MC_GRAPHICS				;AN000;
PC_GRAPHICS	DB	'GRAPHICS '                             ;AN000;
MC_GRAPHICS	EQU	$ - PC_GRAPHICS 			;AN000;
								;
SC_GRAFTABL	DW	MC_GRAFTABL				;AN000;
PC_GRAFTABL	DB	'GRAFTABL '                             ;AN000;
MC_GRAFTABL	EQU	$ - PC_GRAFTABL 			;AN000;
								;
;SC_DATE	 DW	 MC_DATE				;
;PC_DATE	 DB	 'DATE  '                               ;  TWO SPACES REQUIRED FOR CR,LF
;MC_DATE	 EQU	 $ - PC_DATE - 2			;
								;
;SC_TIME	 DW	 MC_TIME				;
;PC_TIME	 DB	 'TIME  '                               ;  TWO SPACES REQUIRED FOR CR,LF
;MC_TIME	 EQU	 $ - PC_TIME - 2			;
								;
SC_VER		DW	MC_VER					;AN000;
PC_VER		DB	'VER  '                                 ;AN000;  TWO SPACES REQUIRED FOR CR,LF
MC_VER		EQU	$ - PC_VER - 2				;AN000;
								;
SC_MODE_CON	DW	MC_MODE_CON				;AN000;
PC_MODE_CON	DB	'MODE CON CP PREP=(('                   ;AN000;
MC_MODE_CON	EQU	$ - PC_MODE_CON 			;AN000;
								;
SC_MODE_COM	DW	MC_MODE_COM				;AN000;
PC_MODE_COM	DB	'MODE COM'                              ;AN000;
MC_MODE_COM	EQU	$ - PC_MODE_COM 			;AN000;
								;
SC_MODE_LPT	DW	MC_MODE_LPT				;AN000;
PC_MODE_LPT	DB	'MODE LPT'                              ;AN000;
MC_MODE_LPT	EQU	$ - PC_MODE_LPT 			;AN000;
								;
SC_EQUAL_COM	DW	MC_EQUAL_COM				;AN000;
PC_EQUAL_COM	DB	'=COM'                                  ;AN000;
MC_EQUAL_COM	EQU	$ - PC_EQUAL_COM			;AN000;
								;
SC_PREPARE	DW	MC_PREPARE				;AN000;
PC_PREPARE	DB	' CP PREP=(('                           ;AN000;
MC_PREPARE	EQU	$ - PC_PREPARE				;AN000;
								;
SC_CLOSE_BRAC	DW	MC_CLOSE_BRAC				;AN000;
PC_CLOSE_BRAC	DB	') '                                    ;AN000;
MC_CLOSE_BRAC	EQU	$ - PC_CLOSE_BRAC			;AN000;
								;
SC_KEYB_A	DW	MC_KEYB_A				;AN000;
PC_KEYB_A	DB	'KEYB '                                 ;AN000;
MC_KEYB_A	EQU	$ - PC_KEYB_A				;AN000;
								;
SC_COMMAS	DW	MC_COMMAS				;AN000;
PC_COMMAS	DB	',,'                                    ;AN000;
MC_COMMAS	EQU	$ - PC_COMMAS				;AN000;
								;
SC_CHCP 	DW	MC_CHCP 				;AN000;
PC_CHCP 	DB	'CHCP '                                 ;AN000;
MC_CHCP 	EQU	$ - PC_CHCP				;AN000;
								;
SC_DRIVE_C	DW	MC_DRIVE_C				;AN013;JW
PC_DRIVE_C	DB	'@C:  '                                 ;AN013;JW
MC_DRIVE_C	EQU	$ - PC_DRIVE_C - 2			;AN013;JW
								;
SC_SHELLC_1	DW	MC_SHELLC_1				;AN000;
PC_SHELLC_1	DB	'@SHELLB DOSSHELL',E_CR,E_LF            ;AC019;SEH
		DB	'@IF ERRORLEVEL 255 GOTO END',E_CR,E_LF ;AN000;
		DB	':COMMON  '				;AN000;
MC_SHELLC_1	EQU	$ - PC_SHELLC_1 - 2			;AN000; 2 SPACES FOR ASCII-Z CONVERSION
								;
SC_SHELLC_2	DW	MC_SHELLC_2				;AN000;
PC_SHELLC_2	DB	':END  '                                ;AN000;
MC_SHELLC_2	EQU	$ - PC_SHELLC_2 - 2			;AN000;
								;
SC_SHELLC	DW	MC_SHELLC				;AN000;
PC_SHELLC	DB	'@SHELLC '                              ;AN000;
MC_SHELLC	EQU	$ - PC_SHELLC				;AN000;
								;
SC_SHELLP	DW	MC_SHELLP				;AN000;
PC_SHELLP	DB	'DOSSHELL  '                            ;AC019;SEH
MC_SHELLP	EQU	$ - PC_SHELLP - 2			;AN000;
								;
SC_PRINT_COM	DW	MC_PRINT_COM				;AN000;
PC_PRINT_COM	DB	'PRINT /D:'                             ;AC011; SEH
MC_PRINT_COM	EQU	$ - PC_PRINT_COM			;AN011; SEH
								;
SC_AT_SIGN	DW	MC_AT_SIGN				;AN000;
PC_AT_SIGN	DB	'@'                                     ;AN000;
MC_AT_SIGN	EQU	$ - PC_AT_SIGN				;AN000;
								;
S_DOS_PATH	DW	M_DOS_PATH				;AN000;
P_DOS_PATH	DB	50 DUP(?)				;AN000;
M_DOS_PATH	EQU	$ - P_DOS_PATH				;AN000;
								;
DATA		ENDS						;AN000;DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INCLUDE ext.inc 					;AN000;
	INCLUDE macros.inc					;AN000;
	INCLUDE rout_ext.inc					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SELECT	SEGMENT PARA PUBLIC 'SELECT'                            ;AN000;segment for far routine
	ASSUME	CS:SELECT,DS:DATA				;AN000;
								;
	PUBLIC	CREATE_CONFIG_SYS				;AN000;
	PUBLIC	CREATE_AUTOEXEC_BAT				;AN000;
	PUBLIC	CREATE_SHELL_BAT				;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Create AUTOEXEC.BAT file
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CREATE_AUTOEXEC_BAT	PROC					;AN000;
								;
	;;;install to B:, install path	= null			;
	;;;install to root of C:, install path = c:\		;
	;;;install to directory in C:, install path = c:\path\	;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_B				;AN000; if install to drive B:
	jne else_l_1						;AN000;
	   INIT_VAR		S_DOS_PATH,0			;AN000;    set path = null
	jmp short endif_l_1
	else_l_1:						;AN000; else
	   COPY_STRING		S_DOS_PATH,M_DOS_PATH,S_INSTALL_PATH;AN000;set path = user defined path
	   cmp S_DOS_PATH,M_DEST_DRIVE				;AN000;   if install is not to root of drive C:
	   jle @F						;AN000;
	      APPEND_STRING	S_DOS_PATH,M_DOS_PATH,S_SLASH	;AN000;      append back slash
	   @@:							;AN000;
	endif_l_1:						;AN000;
								;
	;;;write @ECHO OFF					;
	WRITE_LINE		SC_ECHO 			;AN000; write ECHO OFF command
								;
	;;;write SET COMSPEC=<path>\COMMAND.COM 		;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_C				;AC043;SEH COMSPEC formerly after PROMPT ;AN111; if install destination is drive B: or A: JW
	je else_l_2
	   MERGE_STRING 	   SC_LINE,MC_LINE,SC_SET_COMSPEC,S_DRIVE_A  ;AC043;SEH ;AN000;JW
	jmp short endif_l_2
	else_l_2:						;AC043;SEH ;AN000;JW
	   MERGE_STRING 	   SC_LINE,MC_LINE,SC_SET_COMSPEC,S_DOS_PATH	 ;AC043;SEH ;AN000;JW
	endif_l_2:						;AC043;SEH ;AN000;JW
	APPEND_STRING		SC_LINE,MC_LINE, SC_COMMAND_COM ;AC043;SEH ;AN000;
	WRITE_LINE		SC_LINE 			;AC043;SEH ;AN000; write SET COMSPEC command
								;
	;;;write VERIFY <parameter>				;
	cmp S_VERIFY,0						;AN000; if field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_VERIFY,S_VERIFY;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write VERIFY command
	@@:							;AN000;
								;
	;;;write PATH <parameter>				;
	cmp F_PATH,E_PATH_YES					;AN000; if PATH command required
	jne @F
	cmp S_PATH,0						;AN000; and field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_PATH, S_PATH ;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write PATH command
	@@:							;AN000;
								;
	;;;write APPEND <parameter>				;AN000;JW
	;;;write APPEND <path>					;
	cmp F_APPEND,E_APPEND_YES				;AN000; if APPEND command required
	jne endif_l_3
	   cmp S_APPEND_P,0					;AN000; and field length > zero    JW
	   jle @F						;AN000; 			   JW
	      MERGE_STRING	   SC_LINE,MC_LINE,SC_APPEND,S_APPEND_P 		     ;AN000;JW
	      WRITE_LINE	   SC_LINE			;AN000;    write APPEND command    JW
	   @@:							;AN000; 			   JW
	   cmp S_APPEND,0					;AN000; and field length > zero
	   jle @F						;AN000;
	      MERGE_STRING	   SC_LINE,MC_LINE,SC_APPEND,S_APPEND;AN000;
	      WRITE_LINE	   SC_LINE			;AN000;    write APPEND command
	   @@:							;AN000;
	endif_l_3:						;AN000;JW
								;
	;;;write PROMPT <parameter>				;
	cmp F_PROMPT,E_PROMPT_YES				;AN000; if PROMPT command required
	jne @F
	cmp S_PROMPT,0						;AN000; and field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_PROMPT,S_PROMPT;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write PROMPT command
	@@:							;AN000;
								;
	;;;write <path>\GRAPHICS <parameter>			;
	cmp F_GRAPHICS,E_GRAPHICS_YES				;AN000; if GRAPHICS command is to be included
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_DOS_PATH,SC_GRAPHICS;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_GRAPHICS	;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write GRAPHICS command
	@@:							;AN000;
								;
	;;;init S_STR120_1 to primary code page 		;
	;;;init S_STR120_2 to secondary code page		;
	WORD_TO_CHAR		N_CP_PRI, S_STR120_1		;AN000; primary code page in ASCII-N format
	WORD_TO_CHAR		N_CP_SEC, S_STR120_2		;AN000; secondary code page in ASCII-N format
								;
	;;;write <path>\GRAFTABL <primary code page>		;
	cmp F_GRAFTABL,E_GRAFTABL_YES				;AN000; if GRAFTABL command required
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_DOS_PATH,SC_GRAFTABL;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_STR120_1	;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write GRAFTABL command
	@@:							;AN000;
								;
	;;;write VER						;
	WRITE_LINE		SC_VER				;AN000; write VER command
								;
	;;;S_STR120_1 = primary code page			;
	;;;S_STR120_2 = secondary code apge			;
	;;;init S_STR120_3 to code page list			;
	INIT_VAR	     S_STR120_3, 0			;AN000;
	cmp N_CP_PRI,0						;AN000;   if primary code page is 0 or 437
	je endif_l_4
	cmp N_CP_PRI,437	 				;AN000;
	jne else_l_4
	jmp short endif_l_4					;AN000;      no action
	else_l_4:						;AN000;   else
	   APPEND_STRING	S_STR120_3,M_STR120_3,S_STR120_1;AN000;      append code page to cp list
	endif_l_4:						;AN000;
								;
	cmp N_CP_SEC,0						;AN000;   if secondary code page is 0 or 437
	je endif_l_5
	cmp N_CP_SEC,437	 				;AN000;
	jne else_l_5						;AN000;      no action
	jmp short endif_l_5
	else_l_5:						;AN000;   else
	   cmp S_STR120_3,0					;AN000;      if primary code page is in cp list
	   je @F						;AN000;
	      APPEND_STRING	S_STR120_3, M_STR120_3, S_SPACE ;AN000; 	append space to cp list
	   @@:							;AN000;
	   APPEND_STRING	S_STR120_3,M_STR120_3,S_STR120_2;AN000;      append code page to cp list
	endif_l_5:						;AN000;
								;
	;;;S_STR120_3 = code page list				;
	;;;write MODE CON CODEPAGE PREPARE ((<cp list>) <path>\<display>.CPI
	cmp F_CPSW,E_CPSW_YES					;AN000; if code page switching required
	jne endif_l_8						;AN000;
	   cmp S_STR120_3,0		 			;AN000;   if primary/secondary code pages are not 0 or 437
	   je endif_l_7						;AN000;
	      MERGE_STRING	SC_LINE,MC_LINE,SC_MODE_CON,S_STR120_3;AN000;
	      APPEND_STRING	SC_LINE, MC_LINE, SC_CLOSE_BRAC ;AN000;      append close bracket
	      APPEND_STRING	SC_LINE, MC_LINE,S_DOS_PATH	;AN000;      append path
	      cmp ACTIVE,EGA					;AN000;      if EGA adaptor
	      je @F
	      cmp ALTERNATE,EGA					;AN000;
	      jne elseif_l_6					;AN000;
	      @@:
		 APPEND_STRING	SC_LINE, MC_LINE, SC_DISPLAY_EGA;AN000; 	append	EGA.CPI)
	      jmp endif_l_6
	      elseif_l_6:
	      cmp ACTIVE,LCD					;AN000;      if LCD adaptor
	      je @F
	      cmp ALTERNATE,LCD					;AN000;
	      jne endif_l_6					;AN000;
	      @@:
		 APPEND_STRING	SC_LINE, MC_LINE, SC_DISPLAY_LCD;AN000; 	append LCD.CPI)
	      endif_l_6:					;AN000;
	      WRITE_LINE	SC_LINE 			;AN000;      write MODE CON CODEPAGE command
	   endif_l_7:						;AN000;
	endif_l_8:						;AN000;
								;
	;;;S_STR120_3 = cp list 				;
	;;;write MODE LPT1 CODEPAGE PREPARE=((<cp list>) <path>\<cp paramaeters.CPI>)
	;;;write MODE LPT2 CODEPAGE PREPARE=((<cp list>) <path>\<cp paramaeters.CPI>)
	;;;write MODE LPT3 CODEPAGE PREPARE=((<cp list>) <path>\<cp paramaeters.CPI>)
	;;;N_WORD_1 = parallel port number			;
	INIT_VAR		N_WORD_1, 1			;AN000; set port number = 1
	cmp F_CPSW,E_CPSW_YES					;AN000; if code page switching required
	jne endif_l_10						;AN000;
	   repeat_l_1:						;AN000;    repeat code block
	      GET_PRINTER_PARAMS 0, N_WORD_1, N_RETCODE 	;AN000;       get printer parameters
	      cmp N_RETCODE,1					;AN000;       if valid return
	      jne endif_l_9
	      cmp N_PRINTER_TYPE,E_PARALLEL			;AN000; 	 and parallel printer
	      jne endif_l_9
	      cmp S_CP_DRIVER,0		 			;AN000; 	 and driver and prepare
	      jle endif_l_9
	      cmp S_CP_PREPARE,0				;AN000; 	 parameters valid
	      jle endif_l_9
		 COPY_STRING	SC_LINE, MC_LINE, SC_MODE_LPT	;AN000; 	 append MODE LPT
		 WORD_TO_CHAR	N_WORD_1, S_STR120_2		;AN000;
		 APPEND_STRING	SC_LINE, MC_LINE, S_STR120_2	;AN000; 	 append lpt number
		 APPEND_STRING	SC_LINE, MC_LINE, SC_PREPARE	;AN000; 	 append CODEPAGE PREPARE
		 APPEND_STRING	SC_LINE, MC_LINE, S_STR120_3	;AN000; 	 append cp list
		 APPEND_STRING	SC_LINE, MC_LINE, SC_CLOSE_BRAC ;AN000; 	 append close bracket
		 APPEND_STRING	SC_LINE, MC_LINE, S_DOS_PATH	;AN000; 	 append path
		 APPEND_STRING	SC_LINE, MC_LINE, S_CP_PREPARE	;AN000; 	 append driver parameters
		 APPEND_STRING	SC_LINE, MC_LINE, SC_CLOSE_BRAC ;AN000; 	 append close bracket
		 WRITE_LINE	SC_LINE 			;AN000;    write PRINTER.SYS command
	      endif_l_9:					;AN000;
	      INC_VAR		N_WORD_1			;AN000;       inc printer number
	   cmp N_WORD_1,3					;AN000;    end of repeat block
	   jle repeat_l_1
	endif_l_10:						;AN000;
								;
	;;;write serial printer parameters and redirection command
	;;;write MODE COMx:<parameter>				;
	;;;write MODE LPTy=COMx 				;
	;;;N_WORD_1 = serial port number			;
	INIT_VAR		N_WORD_1, 4			;AN000; set port number = 4
	INIT_VAR		N_WORD_2, 1			;AN000; set serial port number = 1
	repeat_l_2: 						;AN000; repeat code block
	   GET_PRINTER_PARAMS 0, N_WORD_1, N_RETCODE		;AN000;    get printer parameters
	   cmp N_RETCODE,1					;AN000;    if valid return
	   jne endif_l_11
	   cmp N_PRINTER_TYPE,E_SERIAL				;AN000;       and serial printer
	   jne endif_l_11
	   cmp S_MODE_PARM,0					;AN000;       and mode parameters present
	   jle endif_l_11
	      COPY_STRING	SC_LINE, MC_LINE, SC_MODE_COM	;AN000;       append MODE COM
	      WORD_TO_CHAR	N_WORD_2, S_STR120_3		;AN000;       S_STR120_3 = serial port number
	      APPEND_STRING	SC_LINE, MC_LINE, S_STR120_3	;AN000;       append serial port number
	      APPEND_STRING	SC_LINE, MC_LINE, S_COLON	;AN000;       append colon
	      APPEND_STRING	SC_LINE, MC_LINE, S_MODE_PARM	;AN000;       append mode parameters
	      WRITE_LINE	SC_LINE 			;AN000;       write MODE COMx command
	      cmp I_REDIRECT,1					;AN000;       if printer redirection
	      jle @F						;AN000;
		 COPY_STRING	SC_LINE,MC_LINE,SC_MODE_LPT	;AN000; 	 append MODE LPT
		 DEC_VAR	I_REDIRECT			;AN000; 	 first item in list is 'None'
		 WORD_TO_CHAR	I_REDIRECT, S_STR120_2		;AN000; 	 convert LPT no to chars
		 APPEND_STRING	SC_LINE,MC_LINE,S_STR120_2	;AN000; 	 append parallel port
		 APPEND_STRING	SC_LINE,MC_LINE,SC_EQUAL_COM	;AN000; 	 append =COM
		 APPEND_STRING	SC_LINE,MC_LINE,S_STR120_3	;AN000; 	 append serial port number
		 WRITE_LINE	SC_LINE 			;AN000; 	 write MODE LPTx=COMy command
	      @@:						;AN000;
	   endif_l_11:						;AN000;
	   INC_VAR		N_WORD_1			;AN000;    inc printer number
	   INC_VAR		N_WORD_2			;AN000;    inc serial port number
	cmp N_WORD_1,7						;AN000; end of repeat block
	jle repeat_l_2
								;
	;;;write KEYB <keyboard>,,<path>\KEYBOARD.SYS		;
	cmp N_KYBD_VAL,E_KYBD_VAL_YES				;AN000;    if kybd id is valid
	jne endif_l_12
	   COPY_STRING	     SC_LINE, MC_LINE, SC_KEYB_A	;AN000;       copy KEYB
	   APPEND_STRING     SC_LINE, MC_LINE, S_KEYBOARD	;AN000;       append kybd id
	   APPEND_STRING     SC_LINE, MC_LINE, SC_COMMAS	;AN000;       append ,,
	   APPEND_STRING     SC_LINE,MC_LINE, S_DOS_PATH	;AN000;       append install path
	   APPEND_STRING     SC_LINE,MC_LINE,SC_KEYBOARD_SYS	;AN000;       append \KEYBOARD.SYS
	   cmp N_KYBD_ALT,E_KYBD_ALT_NO				;AN002;       if alternate keyboard valid	 JW
	   je @F
	   cmp I_KYBD_ALT,2					;AN002;       and not default setting		 JW
	   jne @F						;AN002; 					 JW
	      APPEND_STRING	SC_LINE, MC_LINE,SC_KEYB_SWITCH ;AN002;       append keyb id switch '/ID:'       JW
	      APPEND_STRING	SC_LINE, MC_LINE, S_KYBD_ALT	;AN002;       append alternate keyboard id	 JW
	      APPEND_STRING	SC_LINE, MC_LINE, S_SPACE	;AN090;JPW add space so last char not overwritten
	   @@:							;AN002; 					 JW
	   WRITE_LINE	     SC_LINE				;AN000;       write KEYB command
	endif_l_12:						;AN000;
								;
	;;;write CHCP <primary code page>			;
	cmp F_CPSW,E_CPSW_YES					;AN000; if code page switching required
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_CHCP,S_STR120_1;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write CHCP command
	@@:							;AN000;
								;
	;;;write 'PRINT /D:LPTx' or 'PRINT /D:COMx'             ;AC066;SEH moved print stmt.  NOTE: PRINT AND SHELL STMTS MUST BE LAST IN AUTOEXEC.BAT
	cmp I_WORKSPACE,E_WORKSPACE_MIN	 			;AC066;SEH ;AN011; SEH
	je endif_l_16
	cmp I_DEST_DRIVE,E_DEST_DRIVE_C			 	;AC066;SEH ;AN015; JW	 If install to fixed disk
	jne endif_l_16
	cmp N_NUMPRINT,0					;AC066;SEH ;AN011; SEH
	jle endif_l_16
	   GET_PRINTER_PARAMS	1, 0, N_RETCODE 		;AC066;SEH ;AN011; SEH	 get parameters for 1st printer selected
	   cmp N_RETCODE,0					;AC066;SEH ;AN011; SEH	 if valid return
	   je endif_l_15
	      cmp N_PRINTER_TYPE,E_PARALLEL			;AC066;SEH ;AN011; SEH	 LPT1, LPT2 or LPT3
	      jne else_l_14					;AC066;SEH ;AN011; SEH
		 MERGE_STRING	SC_LINE, MC_LINE, SC_PRINT_COM, SC_LPT;AC066;SEH ;AN011; SEH   'PRINT /D:LPT'
		 COPY_WORD	N_WORD_1, I_PORT		;AC066;SEH ;AN011; SEH	 get LPT number (1-3)
	      jmp short endif_l_14
	      else_l_14:					;AC066;SEH ;AN011; SEH	 serial printer
		 cmp I_REDIRECT,1				;AC066;SEH ;AN011; SEH	 check if redirected to LPT
		 jle else_l_13					;AC066;SEH ;AN011; SEH
		    MERGE_STRING   SC_LINE, MC_LINE, SC_PRINT_COM, SC_LPT  ;AC066;SEH ;AN011; SEH   'PRINT /D:LPT'
		    COPY_WORD	N_WORD_1, I_REDIRECT		;AC066;SEH ;AN011; SEH	 gives LPT printer redirected to ---
		    DEC 	N_WORD_1			;AC066;SEH ;AN011; SEH	 but must subtract off value 'none' to get port#
		 jmp short endif_l_13
		 else_l_13:					;AC066;SEH ;AN011; SEH	 serial port that hasn't been redirected
		    MERGE_STRING   SC_LINE, MC_LINE, SC_PRINT_COM, SC_COM  ;AC066;SEH ;AN011; SEH   'PRINT /D:COM'
		    COPY_WORD	N_WORD_1, I_PORT		;AC066;SEH ;AN011; SEH	 value of COM port
		 endif_l_13: 					;AC066;SEH ;AN011; SEH
	      endif_l_14:					;AC066;SEH ;AN011; SEH
	      WORD_TO_CHAR	N_WORD_1, S_STR120_3		;AC066;SEH ;AN011; SEH
	      APPEND_STRING	SC_LINE, MC_LINE, S_STR120_3	;AC066;SEH ;AN011; SEH	 add on the com or lpt number to the string
	      WRITE_LINE	SC_LINE 			;AC066;SEH ;AN011; SEH	 write 'PRINT /D:LPTx' or 'PRINT /D:COMx'  x=number
	   endif_l_15:						;AC066;SEH ;AN011; SEH
	endif_l_16:						;AC066;SEH ;AN011; SEH
								;
	;;;write SHELL <parameter>				;
	cmp N_DEST,E_DEST_SHELL					;AN000; if preparing for SHELL diskette
	jne @F
	cmp F_SHELL,E_SHELL_YES					;AN000; if SHELL support required
	jne @F							;AN000;
	   WRITE_LINE		SC_SHELLP			;AN000;
	@@:							;AN000;
								;
	RET							;AN000;
CREATE_AUTOEXEC_BAT	ENDP					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Create CONFIG.SYS file
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CREATE_CONFIG_SYS	PROC					;AN000;
								;
	;;;install to B:, install path	= null			;
	;;;install to root of C:, install path = c:\		;
	;;;install to directory in C:, install path = c:\path\	;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_B				;AN000; if install to drive B:
	jne else_l_17						;AN000;
	   INIT_VAR		S_DOS_PATH,0			;AN000;    set path = null
	jmp short endif_l_17
	else_l_17:							;AN000; else
	   COPY_STRING		S_DOS_PATH,M_DOS_PATH,S_INSTALL_PATH;AN000;set path = user defined path
	   cmp S_DOS_PATH,M_DEST_DRIVE				;AN000;    if install is not under root of C:
	   jle @F						;AN000;
	      APPEND_STRING	S_DOS_PATH,M_DOS_PATH,S_SLASH	;AN000;       append back slash to path
	   @@:							;AN000;
	endif_l_17:						;AN000;
								;
	;;;write BREAK=<parameter>				;
	cmp S_BREAK,0						;AN000; if field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_BREAK,S_BREAK;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write BREAK command
	@@:							;AN000;
								;
	;;;write COUNTRY=<country>,,<path>\COUNTRY.SYS		;
	cmp N_COUNTRY,1						;AN000; if country is US (001)
	jne else_l_18						;AN000;    no action
	jmp short endif_l_18
	else_l_18:						;AN000; else
	   WORD_TO_CHAR 	N_COUNTRY, S_STR120_1		;AN000;    S_STR120_1 = country in ASCII
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_COUNTRY,S_STR120_1;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, SC_COMMAS	;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE,S_DOS_PATH	;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE,SC_COUNTRY_SYS ;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write COUNTRY command
	endif_l_18:						;AN000;
								;
	;;;write BUFFERS=<parameter>				;
	;;;write BUFFERS=<parameter> /E if expanded memory support
	cmp S_BUFFERS,0						;AN000; if field lengh > zero
	jle endif_l_19						;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_BUFFERS,S_BUFFERS;AN000;
	   cmp N_XMA,E_XMA_PRESENT				;AN000;    if expanded memory present
	   jne @F
	   cmp F_XMA,E_XMA_YES					;AN000;       and is to be used
	   jne @F						;AN000;
	      APPEND_STRING	SC_LINE, MC_LINE, SC_SLASH_X	;AC046;SEH    append /X to command   (formerly /E)
	   @@:							;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write BUFFERS command
	endif_l_19:						;AN000;
								;
	;;;write FCBS=<parameter>				;
	cmp S_FCBS,0						;AN000; if field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE, SC_FCBS,S_FCBS ;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write FCBS command
	@@:							;AN000;
								;
	;;;write FILES=<parameter>				;
	cmp S_FILES,0						;AN000; if field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_FILES,S_FILES;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write FILES command
	@@:							;AN000;
								;
	;;;write LASTDRIVE=<parameter>				;
	cmp S_LASTDRIVE,0					;AN000; if field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_LASTDRIVE,S_LASTDRIVE;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write LASTDRIVE command
	@@:							;AN000;
								;
	;;;write STACKS=<parameter>				;
	cmp S_STACKS,0						;AN000; if field length > zero
	jle @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_STACKS,S_STACKS;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write STACKS command
	@@:							;AN000;
								;
	;;;write SHELL=<path>\COMMAND.COM /MSG /P /E:256	;
	cmp I_DEST_DRIVE,E_DEST_DRIVE_C				;AN111; if install destination is drive B: or A: JW
	je else_l_20
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_SHELL,S_DRIVE_A    ;AN000;JW
	   APPEND_STRING	SC_LINE,MC_LINE,SC_SHELL_1	;AN037;SEH
	   APPEND_STRING	SC_LINE,MC_LINE,SC_SHELL_2	;AN037;SEH Only diskettes get /MSG in SHELL command
	jmp short endif_l_20
	else_l_20:						;AN000;JW
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_SHELL,S_DOS_PATH   ;AN000;JW
	   APPEND_STRING	SC_LINE,MC_LINE,SC_SHELL_1	;AC037;SEH
	endif_l_20:						;AN000;JW
	APPEND_STRING		SC_LINE, MC_LINE, SC_SHELL_3	;AC037;SEH
	WRITE_LINE		SC_LINE 			;AN000; write SHELL command
								;
	;;;init S_STR120_1 to DEVICE=<path>\			;
	MERGE_STRING		S_STR120_1,M_STR120_1,SC_DEVICE,S_DOS_PATH;AN000;
								;
	;;;S_STR120_1 = DEVICE=<path>\				;
	;;;write DEVICE=<path>\XMAEM.SYS<parameter>		;
	;;;write DEVICE=<path>\XMA2EMS.SYS<parameter>		;
	cmp N_XMA,E_XMA_PRESENT			 		;AC000; if expanded memory present JW
	jne endif_l_21
	cmp F_XMA,E_XMA_YES					;AN000;    and support to be included
	jne endif_l_21						;AN000;
	   cmp N_MOD80,E_IS_MOD80				;AN000;JW
	   jne @F						;AN000;JW
	      MERGE_STRING	   SC_LINE,MC_LINE,S_STR120_1,SC_XMAEM_SYS;AN000;
	      APPEND_STRING	   SC_LINE, MC_LINE, S_XMAEM	;AN000;
	      WRITE_LINE	   SC_LINE			;AN000; write XMAEM command
	   @@:							;AN000;JW
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_XMA2EMS_SYS;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_XMA2EMS	;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write XMA2EMS command
	endif_l_21:						;AN000;
								;
	;;;S_STR120_1 = DEVICE=<path>\				;
	;;;write DEVICE=<path>\ANSI.SYS 			;
	;;;write DEVICE=<path>\ANSI.SYS /X ,additional parameter based on workspace option
	cmp F_ANSI,E_ANSI_YES					;AN000; if ANSI support required
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_ANSI_SYS;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_ANSI	;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write ANSI command
	@@:							;AN000;
								;
	;;;S_STR120_1 = DEVICE=<path>\				;
	;;;write DEVICE=<path>\RAMDRIVE.SYS <parameter>		;
	cmp F_VDISK,E_VDISK_YES					;AN000; if VDISK support required
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_VDISK_SYS;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_VDISK	;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write VDISK command
	@@:							;AN000;
								;
	;;;init S_STR120_2 to number of designates		;
	WORD_TO_CHAR		N_DESIGNATES, S_STR120_2	;AN000; set S_STR120_2 = no. of designates
								;
	;;;S_STR120_1 = DEVICE=<path>\				;
	;;;write DEVICE=<path>\DISPLAY.SYS CON=(<display>,437,<desig>)
	cmp F_CPSW,E_CPSW_YES					;AN000; if code page switching required
	jne endif_l_23						;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_DISPLAY_SYS;AN000;
	   cmp ACTIVE,EGA					;AN000;    if EGA adaptor
	   je @F
	   cmp ALTERNATE,EGA					;AN000;
	   jne elseif_l_22					;AN000;
	   @@:
	      APPEND_STRING	SC_LINE, MC_LINE, SD_DISPLAY_EGA;AN001;GHG    set display to EGA
	   jmp short endif_l_22
	   elseif_l_22:
	   cmp ACTIVE,LCD		 			;AN000;    if LCD adaptor
	   je @F
	   cmp ALTERNATE,LCD					;AN000;
	   jne endif_l_22					;AN000;
	   @@:
	      APPEND_STRING	SC_LINE, MC_LINE, SD_DISPLAY_LCD;AN001;GHG    set display to LCD
	   endif_l_22:						;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, SC_437	;AN000;    append hardware code page
	   APPEND_STRING	SC_LINE, MC_LINE, S_STR120_2	;AN000;    append no of designates
	   APPEND_STRING	SC_LINE, MC_LINE, SC_CLOSE_BRAC ;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write DISPLAY.SYS command
	endif_l_23:						;AN000;
								;
	;;;S_STR120_1 = DEVICE=<path>\				;
	;;;S_STR120_2 = number of designates			;
	;;;write DEVICE=<path>\PRINTER.SYS LPT1=(<cdp parameters>,437,<desig>)
	;;;				   LPT2=(<cdp parameters>,437,<desig>)
	;;;				   LPT3=(<cdp parameters>,437,<desig>)
	;;;N_WORD_1 = parallel port number			;
	;;;N_WORD_2 set if driver is prepared			;
	INIT_VAR		N_WORD_1, 1			;AN000; set port number = 1
	INIT_VAR		N_WORD_2, 0			;AN000; set driver status = false
	cmp F_CPSW,E_CPSW_YES					;AN000; if code page switching required
	jne endif_l_25						;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_PRINTER_SYS;AN000;
	   repeat_l_3:						;AN000;    repeat code block
	      GET_PRINTER_PARAMS 0, N_WORD_1, N_RETCODE 	;AN000;       get printer parameters
	      cmp N_RETCODE,1					;AN000;       if valid return
	      jne endif_l_24
	      cmp S_CP_DRIVER,0			 		;AN000; 	 and driver and prepare
	      jle endif_l_24
	      cmp S_CP_PREPARE,0				;AN000; 	 parameters valid
	      jle endif_l_24
		 APPEND_STRING	SC_LINE, MC_LINE, SC_LPT	;AN000; 	 append LPT
		 WORD_TO_CHAR	N_WORD_1, S_STR120_3		;AN000;
		 APPEND_STRING	SC_LINE, MC_LINE, S_STR120_3	;AN000; 	 append lpt number
		 APPEND_STRING	SC_LINE, MC_LINE, SC_EQUAL_OPEN ;AN000; 	 append =(
		 APPEND_STRING	SC_LINE, MC_LINE, S_CP_DRIVER	;AN000; 	 append driver parameters
		 APPEND_STRING	SC_LINE, MC_LINE, SC_COMMA	;AN000; 	 append comma
		 APPEND_STRING	SC_LINE, MC_LINE, S_STR120_2	;AN000; 	 append no of designates
		 APPEND_STRING	SC_LINE, MC_LINE, SC_CLOSE_BRAC ;AN000; 	 append close bracket
		 INIT_VAR	N_WORD_2, 1			;AN000; 	 set driver status = valid
	      endif_l_24:					;AN000;
	      INC_VAR		N_WORD_1			;AN000;       inc printer number
	   cmp N_WORD_1,3					;AN000;    end of repeat block
	   jle repeat_l_3
	   cmp N_WORD_2,1					;AN000; if driver status is valid
	   jne @F						;AN000;
	      WRITE_LINE	SC_LINE 			;AN000;    write PRINTER.SYS command
	   @@:							;AN000;
	endif_l_25:						;AN000;
								;
	;;;init S_STR120_1 to INSTALL=<path>\			;
	MERGE_STRING		S_STR120_1,M_STR120_1,SC_INSTALL,S_DOS_PATH	 ;AN000;
								;
	;;;write INSTALL=<path>\KEYB.COM US,,<path>\KEYBOARD.SYS
	COMPARE_STRINGS 	S_KEYBOARD, S_US		;AN000;
	jnc endif_l_26						;AN000; if keyboard not US (will be handled in autoexec)
	cmp N_KYBD_VAL,E_KYBD_VAL_YES				;AN000; if keyboard is valid
	jne endif_l_26						;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_KEYB_C ;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_US		;AN000;    append keyboard id = US
	   APPEND_STRING	SC_LINE, MC_LINE, SC_COMMAS	;AN000;    append comma
	   APPEND_STRING	SC_LINE, MC_LINE,S_DOS_PATH	;AN000;    append install path
	   APPEND_STRING	SC_LINE,MC_LINE,SC_KEYBOARD_SYS ;AN000;    append KEYBOARD.SYS
	   WRITE_LINE		SC_LINE 			;AN000;    write KEYB command
	endif_l_26:						;AN000;
								;
	;;;S_STR120_1 = INSTALL=<path>\ 			;
	;;;write INSTALL=<path>\SHARE <parameter>		;
	cmp F_SHARE,E_SHARE_YES					;AN000; if SHARE support required
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_SHARE;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_SHARE	;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write SHARE command
	@@:							;AN000;
								;
	;;;S_STR120_1 = INSTALL=<path>\ 			;
	;;;write INSTALL=<path>\FASTOPEN <parameter>		;
	cmp F_FASTOPEN,E_FASTOPEN_YES				;AN000; if FASTOPEN support required
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_FASTOPEN;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_FASTOPEN	;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write FASTOPEN command
	@@:							;AN000;
								;
	;;;S_STR120_1 = INSTALL=<path>\ 			;
	;;;write INSTALL=<path>\NLSFUNC <path>\COUNTRY.SYS	;
	cmp F_CPSW,E_CPSW_YES					;AN000; if code page switching support required
	jne @F							;AN000;
	   MERGE_STRING 	SC_LINE,MC_LINE,S_STR120_1,SC_NLSFUNC;AN000;
	   APPEND_STRING	SC_LINE,MC_LINE,S_DOS_PATH	;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE,SC_COUNTRY_SYS ;AN000;
	   WRITE_LINE		SC_LINE 			;AN000;    write NLSFUNC command
	@@:							;AN000;
								;
	RET							;AN000;
CREATE_CONFIG_SYS	ENDP					;AN000;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Create DOSSHELL.BAT file
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CREATE_SHELL_BAT     PROC					;AN000;DT
								;AN000;DT
	;;;write SHELL <parameter>				;AN000;DT
	cmp I_DEST_DRIVE,E_DEST_DRIVE_C				;AN000; If install fixed disk ;AN111;JW
	jne @F
	   WRITE_LINE		SC_DRIVE_C			;AN013;JW
	   COPY_STRING		SC_LINE, MC_LINE, SC_CD 	;AN000;
	   APPEND_STRING	SC_LINE, MC_LINE, S_INSTALL_PATH ;AN000;
	   WRITE_LINE		SC_LINE 			;AN000; write CD path command
	@@:							;AN000;
								;
	WRITE_LINE	     SC_SHELLC_1			;AN000;DT
	MERGE_STRING	     SC_LINE,MC_LINE,SC_AT_SIGN,SC_BREAK      ;AN092;SEH break=off
	APPEND_STRING	     SC_LINE,MC_LINE,S_OFF		;AN092;SEH
	WRITE_LINE	     SC_LINE				;AN092;SEH
	MERGE_STRING	     SC_LINE,MC_LINE,SC_SHELLC,S_SHELL	;AN000;DT
	WRITE_LINE	     SC_LINE				;AN000;DT    write SHELL command
	WRITE_LINE	     SC_SHELLC_2			;AN000;DT
								;
	;;;restore BREAK=<parameter>				;
	cmp S_BREAK,0						;AN000;JW if field length > zero
	jle @F
	   MERGE_STRING 	SC_LINE,MC_LINE,SC_AT_SIGN,SC_BREAK ;AN000;JW
	   APPEND_STRING	SC_LINE,MC_LINE,S_BREAK 	;AN000;JW
	   WRITE_LINE		SC_LINE 			;AN000;JW    write BREAK command
	@@:							;AN000;JW
								;
								;
	RET							;AN000;DT
CREATE_SHELL_BAT     ENDP					;AN000;DT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SELECT	 ENDS							;AN000;
	 END							;AN000;
