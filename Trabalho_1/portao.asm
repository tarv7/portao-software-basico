section .data

labelFechado db "DESENHANDO COM CARACTERES: FECHADO", 10
lenLabelFechado equ $-labelFechado
portaoFechado db "'---------------------            -------------------------'",10,"'    /    /    /    /|  /   /    /    /    /   / '",10, "'-------------------/|           |----------------------   '",10,"'   |    |     |    |--------------------|    |    |    |  '",10, "'-------------------|                    |--------------   '",10, "'     |     |     | |                    |     |    |      '",10,"'-----------------x||                    |--------------   '",10,"'   |    |     |    |                    |    |    |    |  '",10, "'-------------------|                    |--------------   '",10,"'             fcf  /|0-----()-----()-----| fca             '",10, "'                 /            /                           '",10, "'                /            /                            '",10,"'               /            /                             '",10,"'              /            /                              '",10,"'             /            /                               '",10,"'            /            /                                '",10,"'    / \                                                   '",10,"'   /   \                                                  '",10,"'     |                                                    '",10,"'     |                                                    '",10,"'   |---|                                                  '",10,"'   | 0 | ba                                               '",10,"'   | 0 | bf                                               '",10,"'   |---|                                                  '",10,10
lenPortaoFechado equ $-portaoFechado

labelAbrindo db "DESENHANDO COM CARACTERES: ABRINDO", 10
lenLabelAbrindo equ $-labelAbrindo
portaoAbrindo db "'----------------------            ---------------------'", 10, "'     /     /    /   /|           /     /     /    /   /'", 10, "'--------------------/|            -------------------  '", 10, "'    |     |     |  | |     -------------------    |  | '", 10, "'--------------------/|     |                 |-------  '", 10, "'      |      |     | |     |                 | |   |   '", 10, "'--------------------/|  x| |                 |-------  '", 10, "'    |     |     |  | |     |                 |   |   | '", 10, "'--------------------/      |                 |-------  '", 10, "'               fcf /       |0----()----()----|  fca    '", 10, "'                  /            /                       '", 10, "'                 /    --->    /                        '", 10, "'                /            /                         '", 10, "'               /            /                          '", 10, "'              /            /                           '", 10, "'             /            /                            '", 10, "'   / \                                                 '", 10, "'  /   \                                                '", 10, "'    |                                                  '", 10, "'    |                                                  '", 10, "'  |---|                                                '", 10, "'  | 0 | ba                                             '", 10, "'  | 0 | bf                                             '", 10, "'  |---|                                                '", 10, 10
lenPortaoAbrindo equ $-portaoAbrindo

labefechando db "DESENHANDO COM CARACTERES: FECHANDO", 10
lenLabefechando equ $-labefechando
portaoFechando db "'----------------------            ---------------------'", 10, "'     /     /    /   /|           /     /     /    /   /'", 10, "'--------------------/|            -------------------  '", 10, "'    |     |     |  | |     -------------------    |  | '", 10, "'--------------------/|     |                 |-------  '", 10, "'      |      |     | |     |                 | |   |   '", 10, "'--------------------/|  x| |                 |-------  '", 10, "'    |     |     |  | |     |                 |   |   | '", 10, "'--------------------/      |                 |-------  '", 10, "'               fcf /       |0----()----()----|  fca    '", 10, "'                  /            /                       '", 10, "'                 /    <---    /                        '", 10, "'                /            /                         '", 10, "'               /            /                          '", 10, "'              /            /                           '", 10, "'             /            /                            '", 10, "'   / \                                                 '", 10, "'  /   \                                                '", 10, "'    |                                                  '", 10, "'    |                                                  '", 10, "'  |---|                                                '", 10, "'  | 0 | ba                                             '", 10, "'  | 0 | bf                                             '", 10, "'  |---|                                                '", 10, 10
lenPortaoFechando equ $-portaoFechando

labelAberto db "DESENHANDO COM CARACTERES: ABERTO", 10
lenLabelAberto equ $-labelAberto
portaoAberto db '----------------------            ---------------------', 10, '     /     /    /   /|           /     /     /    /   /', 10, '--------------------/|            -------------------  ', 10, '    |     |     |  | |           -------------------  |', 10, '--------------------/|           |                 |---', 10, '      |      |     | |           |                 |   ', 10, '--------------------/|         x||                 |---', 10, '    |     |     |  | |           |                 | | ', 10, '--------------------/            |                 |---', 10, '               fcf /             |0----()----()----|fca', 10, '                  /            /                       ', 10, '                 /    <---    /                        ', 10, '                /            /                         ', 10, '               /            /                          ', 10, '              /            /                           ', 10, '             /            /                            ', 10, '   / \                                                 ', 10, '  /   \                                                ', 10, '    |                                                  ', 10, '    |                                                  ', 10, '  |---|                                                ', 10, '  | 0 | ba                                             ', 10, '  | 0 | bf                                             ', 10, '  |---|                                                ', 10
lenPortaoAberto equ $-portaoAberto

clear db 27,"[H",27,"[2J"
lenClear equ $-clear

estadoFechado db "Portao fechado!", 10
lenEstadoFechado equ $-estadoFechado

estadoAberto db "Portao aberto!", 10
lenEstadoAberto equ $-estadoAberto

menu db "O que voce deseja fazer?", 10
lenMenu equ $-menu
menuPrincipal db "a - Abrir o portao", 10, "f - Fechar o portao?", 10, "0 - Sair", 10, 10
lenMenuPrincipal equ $-menuPrincipal

menuFechado db "a - Abrir o portao", 10, "0 - Sair", 10, 10
lenMenuFechado equ $-menuFechado

menuAbrindo db "a - Continuar abertura", 10, "f - Fechar o portao", 10, "0 - Sair", 10, 10
lenMenuAbrindo equ $-menuAbrindo

menuFechando db "a - Abrir o portao", 10, "f - Continuar fechando o portao", 10, "0 - Sair", 10, 10
lenMenuFechando equ $-menuFechando

menuAberto db "f - Fechar o portao", 10, "0 - Sair", 10, 10
lenMenuAberto equ $-menuAberto

incorreta db "*** Opção incorreta, digite novamente ***", 10, 10
lenIncorreta equ $-incorreta

status db "?", 0

lenOpcao equ 1

section .bss
opcao resb lenOpcao

section .text
global _start

_start:

_menu:
mov rax, 1  
mov rdi, 1     
mov rsi, menu         
mov rdx, lenMenu         
syscall

.checkStatus: 
cmp BYTE[status], '?'
je .start
cmp BYTE[status], '0'
je .opened
cmp BYTE[status], '1'
je .opening
cmp BYTE[status], '2'
je .closed
cmp BYTE[status], '3'
je .closing

.start:
mov rax, 1  
mov rdi, 1     
mov rsi, menuPrincipal         
mov rdx, lenMenuPrincipal         
syscall
jmp .check

.opened:
mov rax, 1  
mov rdi, 1     
mov rsi, menuAberto         
mov rdx, lenMenuAberto         
syscall 
jmp .check

.opening:
mov rax, 1  
mov rdi, 1     
mov rsi, menuAbrindo         
mov rdx, lenMenuAbrindo         
syscall 
jmp .check

.closed:
mov rax, 1  
mov rdi, 1     
mov rsi, menuFechado         
mov rdx, lenMenuFechado         
syscall 
jmp .check

.closing:
mov rax, 1  
mov rdi, 1     
mov rsi, menuFechando         
mov rdx, lenMenuFechando         
syscall 
jmp .check

.check:
mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, lenOpcao         
syscall
call _checkOption

_checkOption:
mov rax, 1  
mov rdi, 1     
mov rsi, clear         
mov rdx, lenClear         
syscall
cmp BYTE[status], '?'
je .starting
cmp BYTE[opcao], '0'
je .end
cmp BYTE[opcao], 'a'
je .open
cmp BYTE[opcao], 'f'
je .close

mov rax, 1  
mov rdi, 1     
mov rsi, incorreta         
mov rdx, lenIncorreta         
syscall

mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1

call _menu 

.starting:
cmp BYTE[opcao], '0'
je .end
cmp BYTE[opcao], 'a'
je .opened
cmp BYTE[opcao], 'f'
je .closed
mov rax, 1  
mov rdi, 1     
mov rsi, incorreta         
mov rdx, lenIncorreta         
syscall

mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1

call _menu 

.end:
mov rax, 60   
mov rdi, 0
syscall

.open:
cmp BYTE[status], '1'
je .opened
cmp BYTE[status], '2'
je .opening
cmp BYTE[status], '3'
je .opening
mov rax, 1  
mov rdi, 1     
mov rsi, incorreta         
mov rdx, lenIncorreta         
syscall

mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1

call _menu 

.close:
cmp BYTE[status], '0'
je .closing
cmp BYTE[status], '1'
je .closing
cmp BYTE[status], '3'
je .closed
mov rax, 1  
mov rdi, 1     
mov rsi, incorreta         
mov rdx, lenIncorreta         
syscall

mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1

call _menu 

.opened:
mov BYTE[status], '0'
mov rax, 1  
mov rdi, 1     
mov rsi, labelAberto         
mov rdx, lenLabelAberto         
syscall
mov rax, 1  
mov rdi, 1     
mov rsi, portaoAberto         
mov rdx, lenPortaoAberto         
syscall
mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1         
syscall
call _menu

.opening:
mov BYTE[status], '1'
mov rax, 1  
mov rdi, 1     
mov rsi, labelAbrindo         
mov rdx, lenLabelAbrindo         
syscall
mov rax, 1  
mov rdi, 1     
mov rsi, portaoAbrindo         
mov rdx, lenPortaoAbrindo         
syscall
mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1         
syscall
call _menu

.closing:
mov BYTE[status], '3'
mov rax, 1  
mov rdi, 1     
mov rsi, labefechando         
mov rdx, lenLabefechando         
syscall
mov rax, 1  
mov rdi, 1     
mov rsi, portaoFechando         
mov rdx, lenPortaoFechando         
syscall
mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1         
syscall
call _menu

.closed:
mov BYTE[status], '2'
mov rax, 1  
mov rdi, 1     
mov rsi, labelFechado         
mov rdx, lenLabelFechado         
syscall
mov rax, 1  
mov rdi, 1     
mov rsi, portaoFechado         
mov rdx, lenPortaoFechado         
syscall
mov rax, 0   
mov rdi, 0      
mov rsi, opcao         
mov rdx, 1         
syscall
call _menu