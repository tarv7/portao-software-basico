import sys

opcode = {
    "mov rax": ("b8",5),
    "mov rdx": ("ba",5),
    "mov rdi": ("bf",5),
    "mov rsi": ("48be",10),
    "mov BYTE": ("c60425",8),

    "cmp BYTE": ("803c25", 2),

    "je": ("74",2),
    "jmp": ("eb",2),

    "call": ("e8",5),
    "syscall": ("0f05",2)
    }

def get_variable(line : str, variables : dict):
    """
    This function gets a variable

    Parameters
    ----------
    line : str 
        The line to be checked

    constants : dict
        A dict containing all variables
    """

    var, val = line.split("db")
    variables[var] = val

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
    const, value = line.split("equ")
    constants[const] = value

def main():
    """
    This function handles main loop
    """
    file = open("../Trabalho_1/portao.asm", "r") 
    txt = file.readlines()
    file.close()

    tokens = dict()

    ILC = 0
    for i, line in enumerate(txt):
        line = line.strip()
        if line:
            for opc in opcode.keys():
                if opc in line:
                    tokens[opc] = tokens[opc] + [ILC] if opc in tokens else [ILC]
                    ILC += opcode[opc][1]
            
    print(ILC)
    print(f"Tokens: {tokens}\n")

if __name__ == "__main__":
    main()