Recreating the program LIBR.C to combine multiple object files into one file.

The C source code was RESTORED by disassembling the LIBR.COM executable file from the Hi-Tech v3.09 compiler package.

This file with some warning messages is compiled by Hi-Tech C compiler v3.09 and the resulting executable file performs all the functions provided. To compile, use the following command:

cc -o libr3.c

The created executable file almost completely matches the original image.

If an error occurs, the program returns the following error codes upon completion:

0 - normal completion

1 - if there are simple errors

2 - on file opening errors

3 - for file seek errors

4 - at the end of the program by the user

5 - if there are simple errors when replacing modules

6 - if there are fatal errors 


The following files are provided:

libr3.c   - Recreated Hi-Tech C source code program LIBR.COM;

libr3.asm - Disassembled code LIBR.COM in assembly language. The C code was recreated from it;

libr3.sym - The symbol file of the recreated program;

libr3.sym.sorted - symbol file sorted in ascending order of addresses.

The LIBR.COM program allows using Subkeys in the command line: d (defined) u (ndefined).

The available documentation does not describe this feature. If anyone knows how to use this functionality, please let me know. 

Mark Ogden made the following changes to the libr3.c program:
1. Fixed inaccuracies and decompilation errors.
2. Added explanatory comments.
3. Assigned meaningful names to variables and functions.
4. In some functions, excluded labels and goto statements.
5. With the encouragement of conditional compilation, the program is built and run on modern 64-bit systems.

Thanks to these changes, the program code has acquired a cleaner and more complete look.

Thanks to Mark Ogden for correcting the program code.

The new version of the program has the name libr.c.

Andrey Nikitin 18.10.2021
