# Token de instruções
$insts = ['mov', 'xor', 'cmp', 'je', 'jmp', 'call', 'syscall']

# Lista de macros do programa
$macros = ['exit', 'print', 'scan', 'opcaoIncorreta']

# Hash que será enchida com as linhas de cada macro
$linhas_macro = { }

# Lista de rótulos e seus endereços de memória
$labels = { '.start': '28',
            '.opened': '3b',
            '.opening': '4e',
            '.closed': '61',
            '.closing': '74',
            '.starting': '67',
            '.end': 'bc', 
            '.open': 'b8', 
            '.close': '11' }

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
$ver_op_3 = ['mov rax', 'mov rdx', 'mov rdi', 'mov BYTE[status]', 'cmp']

# Constantes do sistema
$constantes = { 'STDIN': 0,
                'STDOUT': 1,
                'STDERR': 2,
                'SYS_READ': 0,
                'SYS_WRITE': 1,
                'SYS_EXIT': 60 }

# Variáveis do sistema (precisa alterar para o tamanho certo, fiquei com preguiça)
$variaveis = {  'lenLabelFechado': 99,
                'lenPortaoFechado': 99,
                'lenLabelAbrindo': 99,
                'lenPortaoAbrindo': 99,
                'lenLabelFechando': 99,
                'lenLabelAberto': 99,
                'lenPortaoAberto': 99,
                'lenClear': 99,
                'lenEstadoAberto': 99,
                'lenMenu': 99,
                'lenMenuPrincipal': 99,
                'lenMenuFechado': 99,
                'lenMenuFechando': 99,
                'lenMenuAberto': 99,
                'lenIncorreta': 99,
                'lenOpcao': 99 }

# Parâmetros recebidos na macro
$variaveis_macro = ['%1', '%2', '%3', '%4', '%1,', '%2,', '%3,', '%4,']

# Variável de ILC 
$ilc = 0
