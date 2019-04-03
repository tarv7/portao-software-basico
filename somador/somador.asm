; ----------------------------------------------------------------------------------------
; To assemble and run:
;
;     nasm -felf64 somador.asm && ld somador.o && ./a.out
; ----------------------------------------------------------------------------------------
; section .data
;   db  = define byte        (8 bits)
;   dw  = define word        (2 * 8 bits = 16 bits)
;   dd  = define double word (2 * 16 bits = 32 bits)
;   dq  = define quad word   (4 * 16 bits = 64 bits)
;   0   = termination (\0)
;   10  = termination (\n)
;   13  = carriage return
; 
; section .bss
;   resb = reserve byte
;   resw = reserve word
;   resd = reserve double word

STDIN equ 0
STDOUT equ 1
STDERR equ 2

SYS_READ equ 0
SYS_WRITE equ 1
SYS_EXIT equ 60

%macro exit 0

    mov rax, SYS_EXIT   ; system call for exit
    xor rdi, rdi        ; exit code 0
    syscall             ; invoke operating system to exit

%endmacro

%macro print 2

    mov rax, SYS_WRITE  ; systemcall for write
    mov rdi, STDOUT     ; file handle 1 is stdout
    mov rsi, %1         ; address of string to output
    mov rdx, %2         ; number of bytes 
    syscall

%endmacro

%macro scan 2

    mov rax, SYS_READ   ; systemcall for read
    mov rdi, STDIN      ; file handle 1 is stdin
    mov rsi, %1         ; address of string to input
    mov rdx, %2         ; number of bytes 
    syscall

%endmacro

section .data

    array dd 3, 4, -1    ; Array definition
    lenArray equ $-array ; Array length

section .bss
    sum resb 1   ; Sum

section	.text
   global _start
	
    _start:	        
        call _sum
        print   sum, 1
        mov     al, 10
        mov     [sum], al
        print   sum, 1
        exit

        _sum:
            mov     rax, 0 ; Sum
            mov     rdx, 0 ; Index
            mov     rdi, array ; Array pointer
            mov     rsi, lenArray ; Array size
            .loop:
                cmp     rdx, rsi
                jge     .end
                add     rax, [rdi+rdx*4]
                add     rdx, 1
                jmp     .loop
            .end:
                add     rax, 48 ; '0'
                mov     [sum], rax 
                ret