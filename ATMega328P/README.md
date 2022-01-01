Most of the examples are from the internet or inspired by examples and
source code from the internet.
This directory has a lot of useless projects but by starting at zero
and building further on my experience, I've learned a lot.  That's the
reason I keep al these little projects here, as a later reference.

Initially I started with avra but soon I realized that when using avr-gdb
to debug with source code, the better option was using avr-as and avr-gcc.

The makefiles I've found at:

    https://ece-classes.usc.edu/ee459/library/
    
Allthough fuses is available in the Makefiles, I still don't have the courage
to use it.  An ATMEGA328p is cheap but expensive enough to not brick it.
(but at a given time I will experiment with fuses and I come back on this)

All projects can be build with ease with make flash.
I hope I don't have to mention that there is some electronics building involved to
have "a full experience" of what you've done.
Beside the internet examples some notes:
 - ALWAYS use resistors when dealing with leds (and other stuff)
 - ALWAYS measure the power that comes out of a power adapter

Better a resistor too much than a broken circuit or even MCU.

    make            : builds a main.hex, main.elf and an object file .o from the .S file
    make all        : same as make
    make clean      : clean up the mess
    make cpp        : looks for a main.c file and compile it using avr-gcc
    make disasm     : displays a disassembly file. with > you can redirect the output to a file
                      (obviously only very usefull when building projects with C source code)
    make flash      : flash main.hex to the ATMEGA238 mcu
    make fuse       : reprograms the ATMEGA238 fuses
                      more info: https://www.allaboutcircuits.com/projects/atmega328p-fuse-bits-and-an-external-crystal-oscillator/
                                 https://www.engbedded.com/fusecalc/
    make install    : makes the entire roject, flash it and reprogram the fuses.
                      same applies as for make fuse
    make load       : I have still no idea but you have to replace something in that line.
                      reference: https://ece-classes.usc.edu/ee459/library/
    
