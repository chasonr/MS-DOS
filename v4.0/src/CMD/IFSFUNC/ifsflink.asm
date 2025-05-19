	PAGE	,132				; 
;	SCCSID = @(#)ifsflink.asm 1.0 87/05/11
TITLE	IFSFUNC LINK FIX ROUTINES - Routines to resolve ifsfunc externals
NAME	IFSFLINK

.xlist
.xcref
INCLUDE dossym.inc
INCLUDE devsym.inc
.cref
.list

CODE	SEGMENT BYTE PUBLIC 'CODE'
code	ENDS

include dosseg.asm

code	SEGMENT BYTE PUBLIC 'code'
	ASSUME	CS:dosgroup

	procedure OUTT,FAR
	entry	$DUP
	entry	MSG_RETRIEVAL
	entry	$ECS_CALL
	entry	$EXTENDED_OPEN
	entry	FASTINIT
	entry	$IFS_IOCTL
	entry	IFS_DOSCALL
	entry	$QUERY_DOS_VALUE
	entry	$STD_AUX_INPUT
	entry	LCRITDEVICE
	entry	$ABORT
	entry	$SET_TIME
	entry	$ALLOC
	entry	SETMEM
	entry	SKIPONE
	entry	$SET_DMA
	entry	$PARSE_FILE_DESCRIPTOR
	entry	$CREATETEMPFILE
	entry	$SLEAZEFUNCDL
	entry	$CHDIR
	entry	TWOESC
	entry	$GET_INTERRUPT_VECTOR
	entry	$FCB_SEQ_WRITE
	entry	DEVNAME
	entry	$GET_DEFAULT_DRIVE
	entry	$STD_CON_STRING_INPUT
	entry	$CLOSE
	entry	$RAW_CON_IO
	entry	$INTERNATIONAL
	entry	IDLE
	entry	$STD_CON_INPUT_NO_ECHO
	entry	$ASSIGNOPER
	entry	$LOCKOPER
	entry	$FCB_CLOSE
	entry	$STD_CON_STRING_OUTPUT
	entry	$DUP_PDB
	entry	GETCH
	entry	STRLEN
	entry	INITCDS
	entry	COPYONE
	entry	PJFNFROMHANDLE
	entry	$GET_VERIFY_ON_WRITE
	entry	$KEEP_PROCESS
	entry	STRCMP
	entry	$SET_INTERRUPT_VECTOR
	entry	$FCB_DELETE
	entry	$RAW_CON_INPUT
	entry	$RENAME
	entry	$FIND_FIRST
	entry	$FCB_RANDOM_WRITE
	entry	$SET_DEFAULT_DRIVE
	entry	$SETDPB
	entry	$STD_PRINTER_OUTPUT
	entry	$MKDIR
	entry	$DUP2
	entry	SET_SFT_MODE
	entry	$GET_DATE
	entry	$FCB_RENAME
	entry	$CREATE_PROCESS_DATA_BLOCK
	entry	$CREAT
	entry	ECRITDISK
	entry	PLACEBUF
	entry	$IOCTL
	entry	$READ
	entry	PATHCHRCMP
	entry	$GET_VERSION
	entry	COPYLIN
	entry	LCRITDISK
	entry	$LSEEK
	entry	STRCPY
	entry	$FILE_TIMES
	entry	BACKSP
	entry	$SET_VERIFY_ON_WRITE
	entry	SETYEAR
	entry	FASTRET
	entry	$RMDIR
	entry	DIVOV
	entry	$GET_FCB_POSITION
	entry	$DISK_RESET
	entry	$DIR_SEARCH_FIRST
	entry	$WAIT
	entry	FASTOPENCOM
	entry	STAY_RESIDENT
	entry	$ALLOCOPER
	entry	$GET_DEFAULT_DPB
	entry	DSTRLEN
	entry	CTRLZ
	entry	$USEROPER
	entry	$SET_DATE
	entry	$FCB_RANDOM_WRITE_BLOCK
	entry	EXITINS
	entry	$GET_IN_VARS
	entry	GETDEVLIST
	entry	DATE16
	entry	POINTCOMP
	entry	SFFROMSFN
	entry	SKIPSTR
	entry	FREE_SFT
	entry	SHARE_ERROR
	entry	NLS_IOCTL
	entry	$CURRENT_DIR
	entry	$FCB_CREATE
	entry	$WRITE
	entry	$GET_INDOS_FLAG
	entry	RECSET
	entry	$CREATENEWFILE
	entry	$STD_CON_INPUT_STATUS
	entry	REEDIT
	entry	GETTHISDRV
	entry	DSUM
	entry	$GETEXTENDEDERROR
	entry	$EXTHANDLE
	entry	$NAMETRANS
	entry	NLS_LSEEK
	entry	SCANPLACE
	entry	GETCDSFROMDRV
	entry	DSLIDE
	entry	UCASE
	entry	$STD_CON_OUTPUT
	entry	$FCB_RANDOM_READ_BLOCK
	entry	CHECKFLUSH
	entry	COPYSTR
	entry	$GETSETCDPG
	entry	$DIR_SEARCH_NEXT
	entry	$OPEN
	entry	SKIPVISIT
	entry	$EXEC
	entry	$DEALLOC
	entry	DOS_CLOSE
	entry	$STD_CON_INPUT
	entry	NLS_GETEXT
	entry	BUFWRITE
	entry	$GET_TIME
	entry	$SLEAZEFUNC
	entry	$CHAR_OPER
	entry	NET_I24_ENTRY
	entry	$COMMIT
	entry	$SETBLOCK
	entry	$FCB_OPEN
	entry	NLS_OPEN
	entry	$GET_DMA
	entry	$UNLINK
	entry	$FCB_SEQ_READ
	entry	$STD_CON_INPUT_FLUSH
	entry	$GET_DRIVE_FREESPACE
	entry	DRIVEFROMTEXT
	entry	$GETEXTCNTRY
	entry	SETVISIT
	entry	$EXIT
	entry	$STD_AUX_OUTPUT
	entry	KILNEW
	entry	$CHMOD
	entry	$FCB_RANDOM_READ
	entry	SHARE_VIOLATION
	entry	ECRITDEVICE
	entry	$GET_DPB
	entry	$FIND_NEXT
	entry	$GET_FCB_FILE_LENGTH
	entry	ENTERINS
	entry	DEVIOCALL2
	entry	$SERVERCALL
	entry	$GSETMEDIAID
	entry	FETCHI_CHECK
	entry	TABLEDISPATCH
	entry	DSKSTATCHK
	entry	SET_RQ_SC_PARMS
	entry	SAVE_MAP
	entry	RESTORE_MAP
	entry	DSKREAD
	entry	FAST_DISPATCH
	entry	DSKWRITE
	entry	INTCNE0
	entry	SHARE_INSTALL							 ;P3568
	entry	FAKE_VERSION							 ;D503
	NOP
EndProc OUTT

	code	ENDS
    END


