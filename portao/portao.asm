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
    mov rsi, %1         ; address of ing to output
    mov rdx, %2         ; number of bytes 
    syscall

%endmacro

%macro scan 2

    mov rax, SYS_READ   ; systemcall for read
    mov rdi, STDIN      ; file handle 1 is stdin
    mov rsi, %1         ; address of ing to input
    mov rdx, %2         ; number of bytes 
    syscall

%endmacro

section .data

    labelFechado db "DESENHANDO COM CARACTERES: FECHADO", LF
    lenLabelFechado equ $-labelFechado
    portaoFechado db "'---------------------            -------------------------'", LF, "'    /    /    /    /|		  /   /    /    /    /   / '", LF,  "'-------------------/|           |----------------------   '", LF, "'   |    |     |    |--------------------|    |    |    |  '", LF,  "'-------------------|                    |--------------   '", LF,  "'     |     |     | |                    |     |    |      '", LF, "'-----------------x||                    |--------------   '", LF, "'   |    |     |    |                    |    |    |    |  '", LF,  "'-------------------|                    |--------------   '", LF, "'             fcf  /|0-----()-----()-----| fca             '", LF,  "'                 /            /                           '", LF,  "'                /            /                            '", LF, "'               /            /                             '", LF, "'              /            /                              '", LF, "'             /            /                               '", LF, "'            /            /                                '", LF, "'    / \                                                   '", LF, "'   /   \                                                  '", LF, "'     |                                                    '", LF, "'     |                                                    '", LF, "'   |---|                                                  '", LF, "'   | 0 | ba                                               '", LF, "'   | 0 | bf                                               '", LF, "'   |---|                                                  '", LF, LF
    lenPortaoFechado equ $-portaoFechado

    labelAbrindo db "DESENHANDO COM CARACTERES: ABRINDO", LF
    lenLabelAbrindo equ $-labelAbrindo
    portaoAbrindo db "'----------------------            ---------------------'", LF, "'     /     /    /   /|           /     /     /    /   /'", LF, "'--------------------/|            -------------------  '", LF, "'    |     |     |  | |     -------------------    |  | '", LF, "'--------------------/|     |                 |-------  '", LF, "'      |      |     | |     |                 | |   |   '", LF, "'--------------------/|  x| |                 |-------  '", LF, "'    |     |     |  | |     |                 |   |   | '", LF, "'--------------------/      |                 |-------  '", LF, "'               fcf /       |0----()----()----|  fca    '", LF, "'                  /            /                       '", LF, "'                 /    --->    /                        '", LF, "'                /            /                         '", LF, "'               /            /                          '", LF, "'              /            /                           '", LF, "'             /            /                            '", LF, "'   / \                                                 '", LF, "'  /   \                                                '", LF, "'    |                                                  '", LF, "'    |                                                  '", LF, "'  |---|                                                '", LF, "'  | 0 | ba                                             '", LF, "'  | 0 | bf                                             '", LF, "'  |---|                                                '", LF, LF
    lenPortaoAbrindo equ $-portaoAbrindo

    labelFechando db "DESENHANDO COM CARACTERES: FECHANDO", LF
    lenLabelFechando equ $-labelFechando
    portaoFechando db "'----------------------            ---------------------'", LF, "'     /     /    /   /|           /     /     /    /   /'", LF, "'--------------------/|            -------------------  '", LF, "'    |     |     |  | |     -------------------    |  | '", LF, "'--------------------/|     |                 |-------  '", LF, "'      |      |     | |     |                 | |   |   '", LF, "'--------------------/|  x| |                 |-------  '", LF, "'    |     |     |  | |     |                 |   |   | '", LF, "'--------------------/      |                 |-------  '", LF, "'               fcf /       |0----()----()----|  fca    '", LF, "'                  /            /                       '", LF, "'                 /    <---    /                        '", LF, "'                /            /                         '", LF, "'               /            /                          '", LF, "'              /            /                           '", LF, "'             /            /                            '", LF, "'   / \                                                 '", LF, "'  /   \                                                '", LF, "'    |                                                  '", LF, "'    |                                                  '", LF, "'  |---|                                                '", LF, "'  | 0 | ba                                             '", LF, "'  | 0 | bf                                             '", LF, "'  |---|                                                '", LF, LF
    lenPortaoFechando equ $-portaoFechando
    
    labelAberto db "DESENHANDO COM CARACTERES: ABERTO", LF
    lenLabelAberto equ $-labelAberto
    portaoAberto db '----------------------            ---------------------', LF, '     /     /    /   /|           /     /     /    /   /', LF, '--------------------/|            -------------------  ', LF, '    |     |     |  | |           -------------------  |', LF, '--------------------/|           |                 |---', LF, '      |      |     | |           |                 |   ', LF, '--------------------/|         x||                 |---', LF, '    |     |     |  | |           |                 | | ', LF, '--------------------/            |                 |---', LF, '               fcf /             |0----()----()----|fca', LF, '                  /            /                       ', LF, '                 /    <---    /                        ', LF, '                /            /                         ', LF, '               /            /                          ', LF, '              /            /                           ', LF, '             /            /                            ', LF, '   / \                                                 ', LF, '  /   \                                                ', LF, '    |                                                  ', LF, '    |                                                  ', LF, '  |---|                                                ', LF, '  | 0 | ba                                             ', LF, '  | 0 | bf                                             ', LF, '  |---|                                                ', LF
    lenPortaoAberto equ $-portaoAberto
    
    clear db 27,"[H",27,"[2J"
    lenClear equ $-clear
    
    estadoFechado db "Portao fechado!", LF
    lenEstadoFechado equ $-estadoFechado

    estadoAberto db "Portao aberto!", LF
    lenEstadoAberto equ $-estadoAberto

    menu db "O que voce deseja fazer?", LF
    lenMenu equ $-menu

    menuFechado db "a - Abrir o portao", LF, "0 - Sair", LF, LF
    lenMenuFechado equ $-menuFechado
    
    menuAbrindo db "c - Continuar abertura", LF, "f - Fechar o portao", LF, "0 - Sair", LF, LF
    lenMenuAbrindo equ $-menuAbrindo
    
    menuFechando db "a - Abrir o portao", LF, "f - Continuar fechando o portao", LF, "0 - Sair", LF, LF
    lenMenuFechando equ $-menuFechando
    
    menuAberto db "f - Fechar o portao", LF, "0 - Sair", LF, LF
    lenMenuAberto equ $-menuAberto


    estado db "0", 0

    opcao db "0", 0

section .bss

    ; opcao resb lenOpcao

section .text
    global _start

    _start:

        call _menu


        _menu:
            print   menu, lenMenu
            scan    opcao, 1
            call _checkOption

        _checkOption:
            mov     al, '0'
            cmp     [opcao], al
            je      .end

            mov     al, 'a'
            cmp     [opcao], al
            je      .open

            mov     al, 'f'
            cmp     [opcao], al
            je      .close

            .open:
                print labelAbrindo, lenLabelAbrindo
                print portaoAbrindo, lenPortaoAbrindo
                scan opcao, 1

            .close:
        ; print labelFechado, lenLabelFechado
        ; print portaoFechado, lenPortaoFechado
        ; scan Char, lenChar

        ; print clear, lenClear
        
        ; print clear, lenClear
        ; print labelFechando, lenLabelFechando
        ; print portaoFechando, lenPortaoFechando
        .end:
            exit