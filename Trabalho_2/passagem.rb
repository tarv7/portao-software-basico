# Carrega as variaveis, constantes, operadoras, etc que foram
# definidas de acordo com o EDB
load 'variables.rb'

# Função responsável por Encher o dicinário de macros do programa
def encheMacro(macro, i)
    # ler tudo que está na definição da macro
    while $linhas[i] != '%endmacro' do
        # le a linha e já retira os espaços inutes
        linha = $linhas[i].strip

        # caso seja a primeira linha da macro, inicializa ela
        if $linhas_macro[macro].nil?
            $linhas_macro[macro] = []
        end

        # coloca na hash o array de linhas da macro
        if $insts.include?(linha.split[0]) || $macros.include?(linha.split[0])
            $linhas_macro[macro] += [linha]
            #puts linha
        end
        i += 1
    end

    # valor de retorno da função
    i
end

# Função responsável por tratar cada linha que for processada para o código final
def trata(mnem, operandos, inst, operandos_macro)
    # Só trata a linha na segunda passagem
    return if $passagem == 1
    ilc = $ilc.to_s(16)

    # Obter o opcode do mnemonico em questão
    opcode = mnem[:hexa]
    if $ver_op_3.include?(inst)
        # terceiro operando
        if operandos[0] == 'je'
            terceiro = operandos[1]
        else
            terceiro = operandos[2]
        end

        # Caso o terceiro operando seja do tipo -> %1, %2, %3 ou %4 ele
        # será alterado pelo operador da chamada original
        if $variaveis_macro.include?(terceiro)
            terceiro = operandos_macro[terceiro[1].to_i].split(',')[0]
        end
        # Padding apenas para não termos complicações lá na frente
        terceiro = terceiro.rjust(2, '0')

        # Caso seja uma constante, uma variavel ou um imediato...
        terceiro = $constantes[terceiro.to_sym] || $variaveis[terceiro.to_sym] || $labels[terceiro.to_sym] || terceiro[1].bytes[0]
        
        #puts $labels[terceiro.to_s]
        #if $labels[terceiro.to_s]
        #    puts 'aqui utilizei o hexa da label: ' + terceiro.to_s + ' de valor: ' + $labels[terceiro.to_sym]
        #end

        # Coloca padding de zeros na esquerda
        terceiro = terceiro.to_s(16).rjust(2, '0')
        #puts 'terceiro: ' + terceiro

        opcode += terceiro # mais o 3 operando tratado
    end

    # Resultado do tratamento
    res = ilc.to_s.rjust(6, '0') + ' ' + opcode.to_s.ljust(16, '0').scan(/.{4}/).join(' ')

    # Printando resultado final de cada linha
    puts res

    # Criando o arquivo .o
    File.write("passagem.o", res + "\n", mode: "a")
end

# Essa função serve para processar uma chamada de macro do proograma
def chama_macro(operandos_macro)
    # Para cada linha da macro, faça...
    $linhas_macro[operandos_macro[0]].each do |linha|
        # Aqui definimos os operados de cada linha da macro
        operandos = linha.split

        # Caso seja uma instrução...
        if $insts.include?(operandos[0])
            # Se for do tipo mov ele usa o segundo operando tbm
            mnem = operandos[0] == 'mov' ? "#{operandos[0]} #{operandos[1]}".split(',')[0] : operandos[0]

            # Atualiza o ILC
            $ilc += $mnems[mnem.to_sym][:tamanho]

            # Tratando os dados para serem printados
            trata($mnems[mnem.to_sym], operandos, mnem, operandos_macro)
        # Caso seja a chamada de uma macro...
        elsif $macros.include?(operandos[0])
            # Caso o terceiro operando seja do tipo -> %1, %2, %3 ou %4 ele
            # será alterado pelo operador da chamada original
            if $variaveis_macro.include?(operandos[1])
                operandos[1] = operandos_macro[operandos[1][1].to_i]
            end
            if $variaveis_macro.include?(operandos[2])
                operandos[2] = operandos_macro[operandos[2][1].to_i]
            end

            # Quando uma macro chama outras macros...
            chama_macro(operandos)
        end
    end
end

# Criando o arquivo objeto de saída ou zerando ele
File.write("passagem.o", "")

# Cria vetor de linhas do arquivo
$linhas = File.readlines('../Trabalho_1/portao.old.asm').map(&:chomp)

# Realiza o algooritmo de duas passagens no programa Portão
2.times do
    # Zera o dicionário de vetores contendo as linhas de cada macro
    $linhas_macro = { }

    # Define em qual passagem estamos
    $passagem += 1

    # Zera o ILC a cada passagem
    $ilc = 0

    # Variável de controle do laço
    i = 0

    # Lê todas as linhas do arquivo
    while i < $linhas.size do
        linha = $linhas[i]

        # tirando espaços em brancos dos lados
        linha = linha.strip

        # divide a linha lida por espaços
        operandos = linha.split

        # desconsidera comentários
        if linha[0] == ';'
            i += 1
            next
        end

        # caso encontre uma instrução
        if $insts.include?(operandos[0])
            # se for do tipo mov, ele especifica mais ainda com o segundo operador
            mnem = operandos[0] == 'mov' ? "#{operandos[0]} #{operandos[1]}".split(',')[0] : operandos[0]

            # calculo do ILC
            $ilc += $mnems[mnem.to_sym][:tamanho]

            # Função para tratar a linha lida
            trata($mnems[mnem.to_sym], operandos, mnem, [])
        # caso encontre a definição de uma macro
        elsif operandos[0] == '%macro'
            # salvando as linhas de cada macro
            i = encheMacro(operandos[1], i + 1)
        # caso encontre uma chamada de macro
        elsif $macros.include?(operandos[0])
            chama_macro(operandos)
        elsif $passagem == 1 && !operandos.empty? && (operandos[0][0] == '.' || operandos[0][0] == '_')
            $labels[operandos[0].to_sym] = $ilc.to_s(16)
        end

        i = i + 1
    end
end