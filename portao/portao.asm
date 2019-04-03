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
;
; definicoes
;   estado do portao: {a: aberto, f: fechado, i: abrindo, n: fechando}

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

%macro opcaoIncorreta 4
    print   %1, %2
    scan    %3, 1
    call      %4
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
    menu2 db "a - Abrir o portao", LF, "f - Fechar o portao?", LF, LF
    lenMenu2 equ $-menu2

    menuFechado db "a - Abrir o portao", LF, "0 - Sair", LF, LF
    lenMenuFechado equ $-menuFechado
    
    menuAbrindo db "a - Continuar abertura", LF, "f - Fechar o portao", LF, "0 - Sair", LF, LF
    lenMenuAbrindo equ $-menuAbrindo
    
    menuFechando db "a - Abrir o portao", LF, "f - Continuar fechando o portao", LF, "0 - Sair", LF, LF
    lenMenuFechando equ $-menuFechando
    
    menuAberto db "f - Fechar o portao", LF, "0 - Sair", LF, LF
    lenMenuAberto equ $-menuAberto


    
    teste db "*** Opção incorreta, digite novamente ***", LF, LF
    lenTeste equ $-teste


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
            print   menu2, lenMenu2
            scan    opcao, 1
            call _checkOption

        _menuAberto:
            print   menuAberto, lenMenuAberto
            scan    opcao, 1
            call _checkOptionAberto

        _menuAbrindo:
            print   menuAbrindo, lenMenuAbrindo
            scan    opcao, 1
            call _checkOptionAbrindo

        _menuFechado:
            print   menuFechado, lenMenuFechado
            scan    opcao, 1
            call _checkOptionFechado

        _menuFechando:
            print   menuFechando, lenMenuFechando
            scan    opcao, 1
            call _checkOptionFechando

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
            opcaoIncorreta teste, lenTeste, opcao, _menu

            .open:
                print labelAberto, lenLabelAberto
                print portaoAberto, lenPortaoAberto
                scan opcao, 1
                call _menuAberto

            .close:
                print labelFechado, lenLabelFechado
                print portaoFechado, lenPortaoFechado
                scan opcao, 1
                call _menuFechado
        .end:
            exit


        _checkOptionAberto:
            mov     al, '0'
            cmp     [opcao], al
            je      .end

            mov     al, 'f'
            cmp     [opcao], al
            je      .close
            opcaoIncorreta teste, lenTeste, opcao, _menuAberto

            .close:
                print labelFechando, lenLabelFechando
                print portaoFechando, lenPortaoFechando
                scan opcao, 1
                call _menuFechando
        .end:
            exit

        _checkOptionAbrindo:
            mov     al, '0'
            cmp     [opcao], al
            je      .end

            mov     al, 'a'
            cmp     [opcao], al
            je      .open

            mov     al, 'f'
            cmp     [opcao], al
            je      .close
            opcaoIncorreta teste, lenTeste, opcao, _menuAbrindo

            .open:
                print labelAberto, lenLabelAberto
                print portaoAberto, lenPortaoAberto
                scan opcao, 1
                call _menuAberto

            .close:
                print labelFechando, lenLabelFechando
                print portaoFechando, lenPortaoFechando
                scan opcao, 1
                call _menuFechando
        .end:
            exit

        _checkOptionFechando:
            mov     al, '0'
            cmp     [opcao], al
            je      .end

            mov     al, 'a'
            cmp     [opcao], al
            je      .open

            mov     al, 'f'
            cmp     [opcao], al
            je      .close
            opcaoIncorreta teste, lenTeste, opcao, _menuFechando

            .open:
                print labelAbrindo, lenLabelAbrindo
                print portaoAbrindo, lenPortaoAbrindo
                scan opcao, 1
                call _menuAbrindo

            .close:
                print labelFechado, lenLabelFechado
                print portaoFechado, lenPortaoFechado
                scan opcao, 1
                call _menuFechado
        .end:
            exit

        _checkOptionFechado:
            mov     al, '0'
            cmp     [opcao], al
            je      .end

            mov     al, 'a'
            cmp     [opcao], al
            je      .open
            opcaoIncorreta teste, lenTeste, opcao, _menuFechado

            .open:
                print labelAbrindo, lenLabelAbrindo
                print portaoAbrindo, lenPortaoAbrindo
                scan opcao, 1
                call _menuAbrindo
        .end:
            exit