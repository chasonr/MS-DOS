/*******************************************************************************
 * 
 * (C) Copyright Microsoft Corp. 1986
 * 
 *    TITLE:	CEMM.EXE - COMPAQ Expanded Memory Manager 386 Driver
 *		EMMLIB.LIB - Expanded Memory Manager Library
 *
 *    MODULE:	EMMFUNCT.C - EMM functions code.
 *
 *    VERSION:	0.10
 *
 *    DATE:	June 14,1986
 *
 *******************************************************************************
 *	CHANGE LOG
 *  Date     Version	   Description
 * --------  --------	-------------------------------------------------------
 * 06/14/86		Changed status return to return only AH.  And added
 *			PFlag to decide on selector versus segment on long
 *			address generation (SBP).
 * 06/14/86		Moved save_current_map and restore_map to ASM (SBP).
 * 06/15/86		Changed NULL_HANDLE to 0x0FFF (see emm.h) (SBP).
 * 06/21/86		Moved MapHandlePage to ASM (SBP).
 *			Handle # passed to client has high byte = NOT (low byte)
 *			as in the Above Board (SBP).
 *			Valid_Handle -> ASM (SBP).
 * 06/23/86		Make_Addr removed. source_addr and dest_addr added(SBP).
 * 06/25/86   0.02	Dealloc checks for save area in use (SBP).
 * 06/28/86   0.02	Name change from CEMM386 to CEMM (SBP).
 * 06/29/86   0.02	Return after NOT_ENOUGH_FREE_MEM error in Allocate(SBP).
 * 07/06/86   0.04	Changed _emm_page,_emm_free, & _pft386 to ptrs (SBP).
 * 07/06/86   0.04	moved SavePageMap and RestorePageMap to .ASM (SBP).
 * 07/08/86   0.04	moved GetSetPageMap to .ASM (SBP).
 * 07/09/86   0.04	removed code which places handle # in _pft386
 *			entry (SBP).
 * 07/09/86   0.05	fixed bug in deallocate (SBP).
 * 05/09/88   0.10	modified for MEMM, modifications are indicated in
 *			individual routines (ISP).
 *
 *******************************************************************************
 *     FUNCTIONAL DESCRIPTION
 *
 * Paged EMM Driver for the iAPX 386.
 * 
 * The basic concept is to use the 386's page tables to emulate
 * the functions of an EMM board. There are several constraints
 * that are a result of poor planning on the LIM specifiers part.
 * 	- maximum of 64K instantaneously mapped. this will
 * 	  be faithfully emulated in this design
 * 	- maximum of 8Mb of extended memory can be used.
 * 	  The actual reason for this is because each board
 * 	  can only support 128 16Kb pages and the limit of
 * 	  4 Aboveboards implies 512 pages maximum. This will
 * 	  not be adhered to since the limit in unnecessary.
 * 
 * The memory managed by this scheme can be discontiguous but
 * a 16Kb EMM page can not be composed of discontiguous pieces.
 * This is not necessary but does simplify the job of managing
 * the memory.
 * 
 * The LIM specification implies the existence of a partitioning
 * of extended memory into `boards'. While this concept is not
 * meaningfull in the 386 environment, a page to logical board
 * mapping is provided to support some of the LIM specified
 * functions:
 * 	pages 0 to 127 map to board 0
 * 	pages 128 to 255 map to board 1
 * 	...
 * The pages in this case are logical pages and pages on the
 * same logical board may actually reside on different physical
 * boards. (In fact, if contiguous memory, a page could actually
 * be split across 2 different boards.)
 *
 * A brief note on parameters:
 *	all parameters to EMM functions are passed in registers.
 *	on entry to the EMM dispatch code, the registers are pushed
 *	onto the stack. In order to access them, they are pointed 
 *	to by a global variable (regp). Defines are used to name
 *	these parameters and make the code more readable.
 * 
 * Definitions:
 * 	Handle:
 * 		16 bit value that references a block of
 * 		allocated memory. Internally, it is an index into a handle
 *		table. Externally, the high byte is the NOT of the low byte
 *		for compatibility with the Above Board EMM driver.
 * 
 * 	EMM page:
 * 		a 16Kb contiguous portion of memory, aligned on a
 * 		16Kb boundary in 8086 address space. In physical
 * 		address space it can be aligned on a 4Kb boundary.
 * 
 * 	page
 * 		386 page. 4Kb in size and 4Kb aligned in physical
 * 		address space.
 * 
 * 	far86 *
 * 		An iAPX 86 style 32 bit pointer.  It consists of
 * 		a 16 bit offset in the low word and a base
 * 		address in the high word.
 *
 *	Logical page
 *		an EMM page allocated to a handle via allocatepages
 *		function. each such page has a logical page number.
 *
 *	physical page frame
 *		the location in physical 8086 space that an EMM page
 *		gets mapped to. there are 4 such locations. they are
 *		contiguous starting at page_frame_base
 *
 *	386 page frame
 *		this is the physical page in 80386 physical
 *		address space. the address of a 386 page frame
 *		is the value placed in a 80386 page table entry's
 *		high 20 bits.
 ******************************************************************************/ 

/******************************************************************************
	INCLUDE FILES
 ******************************************************************************/ 
#include "emm.h"


/* Forward declarations */

void __cdecl AllocateRawPages(void);


/******************************************************************************
	ROUTINES
 ******************************************************************************/ 

/*
 * Avail_Pages()
 * returns: number of available emm pages
 *
 *	06/09/88	PC	added the function
 */
unsigned short
Avail_Pages(void)
{
	return(free_count) ;
}

/*
 * get_pages(num,pto)
 *	num --- number of pages desired
 *      pto --- offset into emm_page array where the pages got are to be copied
 * return value:
 *	emm_page[] index (pointer to list of allocated pages)
 *	NULL_PAGE means failure.
 *	
 * 	05/06/88  ISP	Updated for MEMM removed handle as a parameter 
 */
unsigned
get_pages(
        register unsigned num,
        register unsigned pto)
{
	register unsigned pg;
	unsigned	f_page;

	if(free_count < num)
		return(NULL_PAGE);	/* not enough memory */
	free_count -= num;		/* adjust free count */
	f_page = pg = pto;
/*	  emmpt_start += num;	*/	    /* new offset of avail area */

	/*
	 * copy num elements from the emm_free array
	 * to the emm_page table array and update the
	 * corresponding page frame table entry (with a 
	 * handle back pointer)
	 */
	wcopy(emm_free+free_top, emm_page+pg, num);
	free_top += num;
	return(f_page);
}


/*
 * free_pages(hp)
 *	hp --- handle whose pages should be deallocated
 *
 * Free the pages associated with the handle, but don't free the handle
 *
 *  05/09/88	ISP Pulled out from the deallocate page routine
 */
void
free_pages(register struct handle_ptr *hp)
{
	register unsigned		next;
	unsigned			new_start;
	unsigned			h_size;

	if (hp->page_count == 0) return ;
	/*
	 * copy freed pages to top of free stack 
	 */
	free_top -= hp->page_count;	/* free_top points to new top */
	free_count += hp->page_count;	/* bookkeeping */
	wcopy(emm_page+hp->page_index, /* addr of first of list */
		emm_free+free_top,	 /* addr of free space */
		hp->page_count);	 /* # of pages to be freed */

	/*
	 * now, the hard part. squeeze the newly created hole
	 * out of the emm_page array. this also requires updating the
	 *  handle_table entry via the backlink in the pft386 array.
	 *
	 * do this in two phases:
	 *	- copy the lower portion up to squeeze the hole out
	 *	- readjust the handle table to point to the new
	 *	   location of the head element
	 */

	next = hp->page_index + hp->page_count;
	if(next == emmpt_start )	/* any lists below? */
	{
		/* no, all done */
		emmpt_start -= hp->page_count;
		return;
	}

	new_start = emmpt_start - hp->page_count;
	wcopy(emm_page+next,	/* 1st of rest of list */
		emm_page+hp->page_index,/* addr of freed area */
		emmpt_start-next);	/* size of block of pages  */

	/*
	 * loop through the handle table entries, fixing up
	 * their page index fields
	 */
	h_size = hp->page_count;
	hp->page_count = 0;		/* not really necessary */
	for(hp=handle_table;hp < &handle_table[handle_table_size];hp++)
		if((hp->page_index != NULL_PAGE) &&
		   (hp->page_index >= next) )
			hp->page_index -= h_size;
	emmpt_start = new_start;		/* fix emmpt_start */
}

/*
 * get status
 *	no parameters
 *
 * return current status of EMM subsystem
 * (which, due to superior design is always just fine)
 *
 *  	05/06/88  ISP 	No Update needed for MEMM
 */
void __cdecl GetStatus(void)
{
	setAH((unsigned char)EMMstatus);	/* if we got here, we're OK */
}


/*
 * get page frame address
 *	no parameters
 *
 * return the address of where the pages get mapped 
 * in user space
 *
 *	05/06/88  ISP	Updated this routine from WIN386 sources.
 */
void __cdecl GetPageFrameAddress(void)
{
	/*
	 * return the 8086 style base address of
	 * the page frame base. 
	 */
	if ( page_frame_pages < 4 ) {
		setAH(EMM_HW_MALFUNCTION);	/* GET LOST!!! */
		if ( PF_Base == 0xFFFF )
			setBX(0xB000);		/* In case error is ignored */
		else
			setBX(PF_Base);	/* stunted page frame */
		return;
	}
	setBX(PF_Base);
	setAH((unsigned char)EMMstatus);	/* OK return */
}


/*
 * get unallocated page count
 *	no parameters
 *
 * returns:
 *	bx -- count of free pages
 *	dx -- total number of pages (free and allocated)
 *
 *	05/06/88  ISP	No update needed for MEMM
 */
void __cdecl GetUnallocatedPageCount(void)
{
	setBX(free_count);
	setDX(total_pages);
	setAH((unsigned char)EMMstatus);
}

/*
 * allocate pages
 *	parameters:
 *		n_pages (bx) -- allocation size request
 *
 * allocates the requested number of pages, creates
 * a handle table entry and returns a handle to the
 * allocated pages.
 *	calls AllocateRawPages
 *
 *  05/09/88  ISP   updated for MEMM.  Only handle value returned, not handle
 *		    value with high byte as not of handle value. call to get
 *		    pages also updated to remove handle parameter.
 */
void __cdecl AllocatePages(void)
{
#define	n_pages	((unsigned)regp->hregs.x.rbx)
	if(handle_count == handle_table_size){	/* no more handles? */
		setAH(NO_MORE_HANDLES);	/* nope */
		return;
	}

	if(n_pages == 0) {
		setAH(ZERO_PAGES);
		return;
	}

	AllocateRawPages() ;
}
#undef	n_pages

/*
 * allocate raw pages
 *	parameters:
 *		n_pages (bx) -- allocation size request
 *
 * allocates the requested number of raw pages,
 * allocating 0 page is Okay
 * calls allocated pages if non-zero.
 *
 * CREATED : 08/08/88 PLC
 */
void __cdecl AllocateRawPages(void)
{
#define	n_pages	((unsigned)regp->hregs.x.rbx)
	register unsigned handle;	/* handle table index */
	register struct handle_ptr *hp;

	if(handle_count == handle_table_size){	/* no more handles? */
		setAH(NO_MORE_HANDLES);	/* nope */
		return;
	}

	if(n_pages > total_pages) {
		setAH(NOT_ENOUGH_EXT_MEM);
		return;
	}

	/*
	 * loop through table to
	 * find available handle (page_index = NULL_PAGE)
	 */
	hp = (struct handle_ptr *)handle_table;
	for(handle=0;handle<handle_table_size;handle++,hp++)
		if(hp->page_index == NULL_PAGE) 
			break;		/* found a free one */
	/*
	 * try and allocate pages 
	 */
	if((hp->page_index=get_pages(n_pages,emmpt_start)) != NULL_PAGE) {
		emmpt_start += n_pages;
		setAH((unsigned char)EMMstatus);	/* got them! */
	}
	else {
		setAH(NOT_ENOUGH_FREE_MEM);	/* out of pages */
		return;
	}

	hp->page_count=n_pages;	/* set count */
	handle_count++;
	setDX(handle);

/*	AutoUpdate();*/	/* update status of Auto mode */

}
#undef	n_pages

/*
 * deallocate pages
 *	parameters:
 *		dx -- handle
 *
 * free up the pages and handle table entry associated
 * with this handle
 *
 * 05/09/88  ISP    Updated for MEMM. Pulled out free_page routine and
 *		    added support for handle name blanking.
 */
void __cdecl DeallocatePages(void)
{
#define	handle ((unsigned)regp->hregs.x.rdx)
	register struct handle_ptr	*hp;
	long	*Name ;		/* points to handle name entry to clear */

	if ( handle == 0 ) {		/* Special handle, don't release */
		int savbx = regp->hregs.x.rbx;
		regp->hregs.x.rbx = 0;
		ReallocatePages();
		regp->hregs.x.rbx = savbx;
		return;
	}

	if((hp=valid_handle(handle)) == NULL_HANDLE)
		return;  /* invalid handle, error code set */
	/*
	 * check for save area in use for this handle
	 */
	if( save_map[ (handle & 0x00FF) ].s_handle != (unsigned)NULL_HANDLE )
	{
		setAH(SAVED_PAGE_DEALLOC);
		return;
	}

	free_pages(hp); 	      /*free the pages associated with handle*/
	hp->page_index = NULL_PAGE;   /*and then free the handle*/
	hp->page_count = 0;	      /*bookkeeping*/
	Name = (long *)Handle_Name_Table[handle & 0xFF];
	*(Name+1) = *(Name) = 0L;     /* zero the eight byte name */
	handle_count--; 	      /* one less active handle */

/*	AutoUpdate();*/	/* update status of Auto mode */
	setAH((unsigned char)EMMstatus);	/* done */
}
#undef	handle 
	

/*
 * get emm version
 *	no parameters
 *
 * returns the version number of the emm driver
 *
 * 	05/06/88  ISP	No update needed for MEMM
 */
void __cdecl GetEMMVersion(void)
{
	setAX( (EMMstatus<<8) | EMM_VERSION );
}

/*
 * Get EMM handle count
 *	no parameters
 *
 * return the number of active EMM handles
 *
 * 	05/06/88  ISP 	No update needed for MEMM
 */
void __cdecl GetEMMHandleCount(void)
{
	setBX(handle_count);
	setAH((unsigned char)EMMstatus);
}

/*
 * Get EMM handle pages
 *	parameters:
 *		dx -- handle
 *
 * return the number of pages allocated to specified handle in BX
 *
 *	05/09/88  ISP	No update needed for MEMM
 */
void __cdecl GetEMMHandlePages(void)
{
#define	handle	((unsigned)regp->hregs.x.rdx)
	register struct handle_ptr *hp;

	if((hp=valid_handle(handle))==NULL_HANDLE)	/*valid handle? */
		return;				/* no */
	setBX(hp->page_count);
	setAH((unsigned char)EMMstatus);
}

/*
 * Get All EMM Handle Pages
 *	parameters:
 *		es:di -- userptr
 *
 * fill out array of handle/size pairs
 *
 * 05/09/88  ISP    Updated for MEMM (just removed upper byte of handle)
 */
void __cdecl GetAllEMMHandlePages(void)
{
	unsigned far *u_ptr;
	register struct handle_ptr *hp;
	register unsigned h_index;

	/*
	 * scan handle table and for each valid entry,
	 * copy handle and size to user array
	 */
	u_ptr = dest_addr();

	hp=handle_table;
	for(h_index=0;h_index<handle_table_size;h_index++)   
	{
		/* scan table for entries */
		if(hp->page_index != NULL_PAGE)	/* valid entry? */
		{
			*u_ptr++ = h_index;   /* handle */
			*u_ptr++ = hp->page_count;	/*# of pgs for handle*/
		}
		hp++;				/* next entry */
	}
	setBX(handle_count);			/* bx <-- handle count */
	setAH((unsigned char)EMMstatus);
}

/*
 * Get Page Mapping Register I/O Port Array
 *	parameters:
		es:di -- user array
 *
 *  05/09/88  ISP   Function not supported
 */
void __cdecl GetPageMappingRegisterIOArray(void)
{

	setAH(INVALID_FUNCTION);
}

/*
 * Get Logical to Physical Page Translation Array
 *	parameters:
 *		es:di -- pointer to user array
 *		dx ----- EMM handle
 *
 *  05/09/88  ISP   Function not supported
 */
void __cdecl GetLogicalToPhysicalPageTrans(void)
{
	setAH(INVALID_FUNCTION);
}
