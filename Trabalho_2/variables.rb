# Guarda qual passagem estamos
$passagem = 0

# Token de instruções
$insts = ['mov', 'xor', 'cmp', 'je', 'jmp', 'call', 'syscall']

# Lista de macros do programa
$macros = ['exit', 'print', 'scan', 'opcaoIncorreta']

# Hash que será enchida com as linhas de cada macro
$linhas_macro = { }

# Lista de rótulos e seus endereços de memória
$labels = { }

# Mnemónicos responsáveis por determinar o opcode
$mnems = { 'mov rax':  { 'hexa': 'b8', 'tamanho': 5 },                   # não
           'mov rdx':  { 'hexa': 'ba', 'tamanho': 8 },                   # não
           'mov rdi':  { 'hexa': 'bf', 'tamanho': 8 },                   # não
           'mov rsi':  { 'hexa': '48be853640000000', 'tamanho': 8 },     # certo
           'mov BYTE[status]': { 'hexa': 'c60425aa3740', 'tamanho': 8 }, # não
           'cmp': { 'hexa': '803c25ac3740', 'tamanho': 8 },              # não
           'xor': { 'hexa': '4831ff', 'tamanho': 3 },                    # certo
           'je':  { 'hexa': '74', 'tamanho': 2 },                        # não
           'jmp': { 'hexa': 'eb57', 'tamanho': 2 },                      # certo
           'call':  { 'hexa': 'e8c3fbffff', 'tamanho': 5 },              # certo
           'syscall':  { 'hexa': '0f05', 'tamanho': 2 }, }               # certo

# Array que determina quais mnemónicos precisam levar em  consideração
# o terceiro operador
$ver_op_3 = ['mov rax', 'mov rdx', 'mov rdi', 'mov BYTE[status]', 'cmp', 'je']

# Constantes do sistema
$constantes = { 'STDIN': 0,
                'STDOUT': 1,
                'STDERR': 2,
                'SYS_READ': 0,
                'SYS_WRITE': 1,
                'SYS_EXIT': 60 }

# Variáveis do sistema (precisa alterar para o tamanho certo, fiquei com preguiça)
$variaveis = {  'lenLabelFechado': 35,
                'lenPortaoFechado': 1463,
                'lenLabelAbrindo': 35,
                'lenPortaoAbrindo': 1393,
                'lenLabelFechando': 36,
                'lenPortaoFechando': 1393,
                'lenLabelAberto': 34,
                'lenPortaoAberto': 1392,
                'lenClear': 9,
                'lenEstadoFechado': 16,
                'lenEstadoAberto': 15,
                'lenMenu': 25,
                'lenMenuPrincipal': 50,
                'lenMenuFechado': 29,
                'lenMenuAbrindo': 53,
                'lenMenuFechando': 61,
                'lenMenuAberto': 30,
                'lenIncorreta': 41,
                'lenStatus': 2 }

# Parâmetros recebidos na macro
$variaveis_macro = ['%1', '%2', '%3', '%4', '%1,', '%2,', '%3,', '%4,']

# Variável de ILC 
$ilc = 0
