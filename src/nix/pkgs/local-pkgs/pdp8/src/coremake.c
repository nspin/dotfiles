/* File: coremake.c
   Author: Douglas Jones, Dept. of Comp. Sci., U. of Iowa, Iowa City, IA 52242.
   Date:
   Language: C (UNIX)
   Purpose: DEC PDP-8/e emulator core file creation program.
   Operation: read a .rim file from standard input and output a core image
	to the file named on the command line.
   Requires: utility.c -- the utility routines for the emulator.
*/

/* First, declare that this is a main program */
#define MAIN

#include <stdio.h>
#include <stdlib.h>
#include "bus.h"


void rim()
/* rim loader (logic reproduced as closely as possible from DEC documents) */
{
	int c, cc;
	int ma = 0;
	for (;;) {
		do {
			if ((c = getchar()) == EOF) {
				return;
			}
		} while (c > 0177);
		c = (c << 6);
		if ((cc = getchar()) == EOF) {
			return;
		}
		c = c | cc;
		if (c <= 07777) {
			memory[ma] = c;
		}
		ma = c & 07777;
	}
}

/* main program */
int main(argc, argv)
int argc;
char *argv[];
{
	getargs(argc, argv);
        if (corename == NULL) { /* no file specified */
		fprintf( stderr, "%s: no core file specified\n", argv[0] );
		exit(-1);
	}
	rim();
	dumpcore();
    return 0;
}
