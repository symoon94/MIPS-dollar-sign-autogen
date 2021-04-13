# MIPS-dollar-sign-autogen

Automatic dollar signs assignment for MIPS. Please just make sure your code contains "___.globl___" and your input and output files have ___a different name or path___. Also, registers should have an interval with at least one space or tab.

## Usage

To autogenerate dollar signs in your mips file:

    $ python mips.py  INPUTFILE \
                      -o FILE --output=FILE 

To see the argument options, run:

    $ python mips.py --help

which will print:

    usage: mips.py [-h] [-o OUTPUT] input

    positional arguments:
        input                 path of the input file

    optional arguments:
        -h, --help            show this help message and exit
        -o OUTPUT, --output OUTPUT
                              path of the output file


## Result

Input file:
![Result1](assets/preasm.png)

Output file:
![Result2](assets/asm.png)

## To-do
- [ ] Add an option to overwrite the input file

## Author

Sooyoung Moon / [@symoon94](https://www.facebook.com/msy0128) 
