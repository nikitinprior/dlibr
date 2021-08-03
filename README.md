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

Andrey Nikitin 03.08.2021
