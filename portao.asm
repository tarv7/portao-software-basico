; ----------------------------------------------------------------------------------------
; To assemble and run:
;
;     nasm -felf64 portao.asm && ld portao.o && ./a.out
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

LF equ 0x0A
NULL equ 0x00

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

    mov rax, SYS_READ   ; systemcall for write
    mov rdi, STDIN      ; file handle 1 is stdint
    mov rsi, %1         ; address of string to input
    mov rdx, %2         ; number of bytes 
    syscall

%endmacro

section .data

    strLabelFechado db "DESENHANDO COM CARACTERES: FECHADO", LF
    lenStrLabelFechado equ $-strLabelFechado
    strFechado db "'---------------------            -------------------------'", LF, "'    /    /    /    /|		  /   /    /    /    /   / '", LF,  "'-------------------/|           |----------------------   '", LF, "'   |    |     |    |--------------------|    |    |    |  '", LF,  "'-------------------|                    |--------------   '", LF,  "'     |     |     | |                    |     |    |      '", LF, "'-----------------x||                    |--------------   '", LF, "'   |    |     |    |                    |    |    |    |  '", LF,  "'-------------------|                    |--------------   '", LF, "'             fcf  /|0-----()-----()-----| fca             '", LF,  "'                 /            /                           '", LF,  "'                /            /                            '", LF, "'               /            /                             '", LF, "'              /            /                              '", LF, "'             /            /                               '", LF, "'            /            /                                '", LF, "'    / \                                                   '", LF, "'   /   \                                                  '", LF, "'     |                                                    '", LF, "'     |                                                    '", LF, "'   |---|                                                  '", LF, "'   | 0 | ba                                               '", LF, "'   | 0 | bf                                               '", LF, "'   |---|                                                  '", LF, LF
    lenStrFechado equ $-strFechado

    strLabelAbrindo db "DESENHANDO COM CARACTERES: ABRINDO", LF
    lenStrLabelAbrindo equ $-strLabelAbrindo
    strAbrindo db "'----------------------            ---------------------'", LF, "'     /     /    /   /|           /     /     /    /   /'", LF, "'--------------------/|            -------------------  '", LF, "'    |     |     |  | |     -------------------    |  | '", LF, "'--------------------/|     |                 |-------  '", LF, "'      |      |     | |     |                 | |   |   '", LF, "'--------------------/|  x| |                 |-------  '", LF, "'    |     |     |  | |     |                 |   |   | '", LF, "'--------------------/      |                 |-------  '", LF, "'               fcf /       |0----()----()----|  fca    '", LF, "'                  /            /                       '", LF, "'                 /    --->    /                        '", LF, "'                /            /                         '", LF, "'               /            /                          '", LF, "'              /            /                           '", LF, "'             /            /                            '", LF, "'   / \                                                 '", LF, "'  /   \                                                '", LF, "'    |                                                  '", LF, "'    |                                                  '", LF, "'  |---|                                                '", LF, "'  | 0 | ba                                             '", LF, "'  | 0 | bf                                             '", LF, "'  |---|                                                '", LF, LF
    lenStrAbrindo equ $-strAbrindo

    strLabelFechando db "DESENHANDO COM CARACTERES: FECHANDO", LF
    lenStrLabelFechando equ $-strLabelFechando
    strFechando db "'----------------------            ---------------------'", LF, "'     /     /    /   /|           /     /     /    /   /'", LF, "'--------------------/|            -------------------  '", LF, "'    |     |     |  | |     -------------------    |  | '", LF, "'--------------------/|     |                 |-------  '", LF, "'      |      |     | |     |                 | |   |   '", LF, "'--------------------/|  x| |                 |-------  '", LF, "'    |     |     |  | |     |                 |   |   | '", LF, "'--------------------/      |                 |-------  '", LF, "'               fcf /       |0----()----()----|  fca    '", LF, "'                  /            /                       '", LF, "'                 /    <---    /                        '", LF, "'                /            /                         '", LF, "'               /            /                          '", LF, "'              /            /                           '", LF, "'             /            /                            '", LF, "'   / \                                                 '", LF, "'  /   \                                                '", LF, "'    |                                                  '", LF, "'    |                                                  '", LF, "'  |---|                                                '", LF, "'  | 0 | ba                                             '", LF, "'  | 0 | bf                                             '", LF, "'  |---|                                                '", LF, LF
    lenStrFechando equ $-strFechando
    
    strClear db 27,"[H",27,"[2J"
    lenStrClear equ $-strClear
    
    lenAscii equ 1

section .bss

    strAscii resb lenAscii

section .text
    global _start

    _start:
        print strLabelFechado, lenStrLabelFechado
        print strFechado, lenStrFechado
        scan strAscii, lenAscii

        print strClear, lenStrClear
        print strLabelAbrindo, lenStrLabelAbrindo
        print strAbrindo, lenStrAbrindo
        scan strAscii, lenAscii
        
        print strClear, lenStrClear
        print strLabelFechando, lenStrLabelFechando
        print strFechando, lenStrFechando
        scan strAscii, lenAscii

        exit