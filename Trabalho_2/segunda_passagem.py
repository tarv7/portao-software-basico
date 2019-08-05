# ILC = 0;
# while(! fim_de_arquivo){
# 	tipo = obtém_tipo();
# 	opcode = obtém_opcode();
# 	comp = obtém_comprimento();
# 	linha = obtém_linha();
# 	switch(tipo){
# 		case 1: produz_saída(opcode, comp, linha, code); break;
# 		case 2: produz_saída(opcode, comp, linha, code); break;
# 	}
# 	escreve_saída(code);
# 	escreve_listagem(code, linha);
# 	ILC = ILC + comp;
# }