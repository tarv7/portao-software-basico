def get_variable(line : str, variables : dict):
    """
    This function gets a variable

    Parameters
    ----------
    line : str 
        The line to be checked

    constants : dict
        A dict containing all constants
    """
    const, _, value = line.split()
    constants[const] = value

def get_constant(line : str, constants : dict):
    """
    This function gets a constant

    Parameters
    ----------
    line : str 
        The line to be checked

    constants : dict
        A dict containing all constants
    """
    const, _, value = line.split()
    constants[const] = value

def main():
    """
    This function handles main loop
    """
    file = open('../Trabalho_1/portao.asm', 'r') 
    txt = file.readlines()
    file.close()

    constants = dict()
    variables = dict()
    macros = dict()

    for i, line in enumerate(txt):
        line = line.strip()
        if 'db' in line:
            get_variable(line, variables)
        elif 'equ' in line:
            get_constant(line, constants)
        elif line.startswith('%macro'):
            j = i + 1
            _, macro_name, macro_size = line.split()
            macro_size = int(macro_size)
            macros[(macro_name, macro_size)] = list()
        elif line.startswith('%endmacro'):
            k = i
            macros[(macro_name, macro_size)] = [l.strip() for l in txt[j:k]]

    print(f"CONSTANTES: {constants}\n")
    print(f"MACROS: {macros}\n")

if __name__ == '__main__':
    main()
