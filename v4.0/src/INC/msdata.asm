;	SCCSID = @(#)ibmdata.asm	1.1 85/04/10
;
; DATA Segment for DOS.
;

.xlist
.xcref
include mssw.asm
include dosseg.asm
debug = FALSE                           ; No dossym (too big)
INCLUDE dosmac.inc
INCLUDE sf.inc
INCLUDE dirent.inc
INCLUDE curdir.inc
INCLUDE dpb.inc
INCLUDE buffer.inc
INCLUDE arena.inc
INCLUDE vector.inc
INCLUDE devsym.inc
INCLUDE pdb.inc
INCLUDE find.inc
INCLUDE mi.inc
.cref
.list

TITLE   IBMDATA - DATA segment for DOS
NAME    IBMDATA

installed = TRUE

include ms_data.asm
include msinit.asm
	END
