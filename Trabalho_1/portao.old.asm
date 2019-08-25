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
;   estado do portao: {0: aberto, 1: abrindo, 2: fechado, 3: fechando}

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
	mov rsi, %1         ; address of output
	mov rdx, %2         ; number of bytes 
	syscall
%endmacro

%macro scan 2
	mov rax, SYS_READ   ; systemcall for read
	mov rdi, STDIN      ; file handle 0 is stdin
	mov rsi, %1         ; address of input
	mov rdx, %2         ; number of bytes 
	syscall
%endmacro

%macro opcaoIncorreta 4
	print   %1, %2
	scan 	%3, 1
	call    %4
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
	menuPrincipal db "a - Abrir o portao", LF, "f - Fechar o portao?", LF, "0 - Sair", LF, LF
	lenMenuPrincipal equ $-menuPrincipal

	menuFechado db "a - Abrir o portao", LF, "0 - Sair", LF, LF
	lenMenuFechado equ $-menuFechado
	
	menuAbrindo db "a - Continuar abertura", LF, "f - Fechar o portao", LF, "0 - Sair", LF, LF
	lenMenuAbrindo equ $-menuAbrindo
	
	menuFechando db "a - Abrir o portao", LF, "f - Continuar fechando o portao", LF, "0 - Sair", LF, LF
	lenMenuFechando equ $-menuFechando
	
	menuAberto db "f - Fechar o portao", LF, "0 - Sair", LF, LF
	lenMenuAberto equ $-menuAberto
	
	incorreta db "*** Opção incorreta, digite novamente ***", LF, LF
	lenIncorreta equ $-incorreta

	status db "?", 0

	lenOpcao equ 1

section .bss

	opcao resb lenOpcao

section .text
	global _start

	_start:

		_menu:
			print   menu, lenMenu

			.checkStatus:
				cmp     BYTE[status], '?'
				je      .start
				cmp     BYTE[status], '0'
				je      .opened
				cmp     BYTE[status], '1'
				je      .opening
				cmp     BYTE[status], '2'
				je      .closed
				cmp     BYTE[status], '3'
				je      .closing

			.start:
				print   menuPrincipal, lenMenuPrincipal
				jmp .check

			.opened:
				print  menuAberto, lenMenuAberto 
				jmp .check

			.opening:
				print  menuAbrindo, lenMenuAbrindo 
				jmp .check

			.closed:
				print  menuFechado, lenMenuFechado 
				jmp .check

			.closing:
				print  menuFechando, lenMenuFechando 
				jmp .check

			.check:
				scan    opcao, lenOpcao
				call _checkOption

		_checkOption:
			print 	clear, lenClear
			cmp     BYTE[status], '?'
			je      .starting
			cmp     BYTE[opcao], '0'
			je      .end
			cmp     BYTE[opcao], 'a'
			je      .open
			cmp     BYTE[opcao], 'f'
			je      .close

			opcaoIncorreta incorreta, lenIncorreta, opcao, _menu 

			.starting:
				cmp     BYTE[opcao], '0'
				je      .end
				cmp     BYTE[opcao], 'a'
				je      .opened
				cmp     BYTE[opcao], 'f'
				je      .closed
				opcaoIncorreta incorreta, lenIncorreta, opcao, _menu 

			.end:
				exit

			.open:
				cmp     BYTE[status], '1'
				je      .opened
				cmp     BYTE[status], '2'
				je      .opening
				cmp     BYTE[status], '3'
				je      .opening
				opcaoIncorreta incorreta, lenIncorreta, opcao, _menu 

			.close:
				cmp     BYTE[status], '0'
				je      .closing
				cmp     BYTE[status], '1'
				je      .closing
				cmp     BYTE[status], '3'
				je      .closed
				opcaoIncorreta incorreta, lenIncorreta, opcao, _menu 

			.opened:
				mov     BYTE[status], '0'
				print   labelAberto, lenLabelAberto
				print   portaoAberto, lenPortaoAberto
				scan opcao, 1
				call _menu

			.opening:
				mov     BYTE[status], '1'
				print   labelAbrindo, lenLabelAbrindo
				print   portaoAbrindo, lenPortaoAbrindo
				scan opcao, 1
				call _menu

			.closing:
				mov     BYTE[status], '3'
				print   labelFechando, lenLabelFechando
				print   portaoFechando, lenPortaoFechando
				scan opcao, 1
				call _menu

			.closed:
				mov     BYTE[status], '2'
				print   labelFechado, lenLabelFechado
				print   portaoFechado, lenPortaoFechado
				scan opcao, 1
				call _menu