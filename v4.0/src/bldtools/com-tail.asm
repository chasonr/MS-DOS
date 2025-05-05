; Code placed by make-com.rb at the end of the output binary

COM_segment segment byte public "DATA"

; Skip over the PSP
PSP      db 256 dup (0)
; Skip over the conversion preamble
preamble db 16 dup (0)

; MZ header begins here
mz_header:
mz_sig       dw 0 ; MZ signature
             dw 0 ; Size of last 512-byte page
             dw 0 ; Count of 512-byte pages including partial page at end
reloc_count  dw 0 ; Number of relocation entries
header_size  dw 0 ; Header size in paragraphs
             dw 0 ; Minimum memory allocation
             dw 0 ; Maximum memory allocation
mz_init_ss   dw 0 ; Initial SS
mz_init_sp   dw 0 ; Initial SP
             dw 0 ; Checksum
mz_init_ip   dw 0 ; Initial IP
mz_init_cs   dw 0 ; Initial CS
reloc_offset dw 0 ; Offset to relocation table

; In the generated binary, this will be the first non-zero byte
db 0FFh

COM_segment ends

CODE segment byte public "CODE"

        assume ds:COM_segment, es:COM_segment

init_ip dw 0
init_cs dw 0
init_sp dw 0
init_ss dw 0

        ; On entry: segment registers are as for entry to a .COM program:
        ; DS = ES = FS = GS, and the .COM image begins at DS:0100.
        ; The conversion preamble runs for 16 bytes, so the MZ signature
        ; appears at DS:0110.

        ; Load the current address into BX
        call    bx_addr
bx_addr:                        ; BX gets this address
        pop     bx

        push    ax

        ; AX <- segment where saved program begins

        mov     ax,es
        add     ax,0010h

        ; Establish the SS:SP and CS:IP pointers

        mov     cx,mz_init_ss
        add     cx,ax
        mov     (init_ss-bx_addr)[bx],cx
        mov     cx,mz_init_cs
        add     cx,ax
        mov     (init_cs-bx_addr)[bx],cx
        mov     cx,mz_init_sp
        mov     (init_sp-bx_addr)[bx],cx
        mov     cx,mz_init_ip
        mov     (init_ip-bx_addr)[bx],cx

        ; DI <- offset to relocation table

        mov     di,reloc_offset

        ; DX <- offset to program text

        mov     dx,header_size
        mov     cl,4
        shl     dx,cl

        ; CX <- number of relocation entries

        mov     cx,reloc_count

        ; DS will get clobbered
        assume ds:nothing

        ; Step through the relocation table

        jcxz    end_fixup
        fixup:
            ; DS:SI <- one relocation entry

            lds     si,dword ptr mz_header[di]
            add     di,4

            ; Point DS to the program text
            mov     bp,ds
            add     bp,es:header_size
            add     bp,1    ; For the conversion preamble
            add     bp,ax
            mov     ds,bp

            ; Add the relocation to the segment in the program text

            add     [si],ax
        loop    fixup
        end_fixup:

        ; Point DS to the .COM segment once more
        push    cs
        pop     ds
        assume ds:COM_segment

        ; Move program text to start of program area

        mov     di,offset preamble
        mov     si,dx
        add     si,offset mz_header
        mov     cx,bx       ; Length of copy, up to bx_addr
        sub     cx,si
        rep movsb

        pop     ax

        ; Load SS:SP, being careful not to let an interrupt intervene
        cli
        mov     ss,(init_ss-bx_addr)[bx]
        mov     sp,(init_sp-bx_addr)[bx]
        sti

        ; Go to program start
        jmp     dword ptr (init_ip-bx_addr)[bx]

CODE ends
end
