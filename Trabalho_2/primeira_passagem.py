# ILC = 0;
# while(! fim_de_arquivo){
# 	linha = próxima_linha( );
# 	Se(linha != comentário){
# 		símbolo = obtém_símbolo(linha);
# 	Se(símbolo != null) armazene_símbolo(símbolo, ILC);
# 		literal = obtém_literal(linha);
# 	Se(literal != null) armazene_literal(literal);
# 	opcode = obtém_opcode(linha);
# 	tipo = obtém_pela_tabela(opcode);
# 	Se(tipo < 0) tipo = obtém_pseudo_opcode(opcode);
# 	switch(tipo){
# 		case 1: comprimento = obtém_comprimento_1(linha); break;
# 		case 2: comprimento = obtém_comprimento_2(linha); break;
# 	}
# 	escreve_arquivo_temporário(tipo, opcode, comprimento, linha);
# 	ILC = ILC + comprimento;
# 	}
# }

REGISTERS = ['rax', 'rbx', 'rcx', 'rdx', 'rbp', 'rsp', 'rdi', 'rsi', 'r8', 'r9', 'r10', 'r11', 'r12', 'r13', 'r14', 'r15']
OPCODE = 
OPSIZE = {
	'mov_reg_imm' : 5
	'mov_mem_imm' : 8
	'cmp_byte_imm' : 8
	'je' : 2
	'jmp' : 2
	'syscall' : 2
}
def is_comm(line : str):
	if line[0] == ';':
		return True
	return False

def get_symbol(line : str):
	pass

def store_symbol(symbol : str):
	pass

def get_literal(line : str):
	pass

def store_literal(literal : str):
	pass

def get_opcode(line : str):
	pass

def get_by_table(opcode : int):
	pass

def get_pseudo_opcode(opcode : int):
	pass



def main():
	ILC = 0 # Instruction Location Counter
	with open('../Trabalho_1/portao.asm') as a: # Open file
		for line in a: # Get lines
			line = line.strip() # Remove extra blank spaces
			if line != '' and not is_comm(line): # Check if line is empty or if it's a comment
				symbol = get_symbol(line)
				if symbol:
					store_symbol(symbol, ILC)
				literal = get_literal(line)
				if literal: 
					store_literal(literal)
				opcode = get_opcode(line)
				type_ = get_by_table(opcode)
				if type_ < 0:
				 	type_ = get_pseudo_opcode(opcode)
				if type_ == 1: 
					comprimento = get_comprimento_1(line)
				elif type_ == 2: 
					comprimento = get_comprimento_2(line)

				escreve_arquivo_temporário(type_, opcode, comprimento, line)
				ILC = ILC + comprimento
