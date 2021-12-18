;*************************************************************
;       at328-1s.S - Demonstrate simple I/O functions of ATmega328
;
;       Port C, bit 1 - input from switch (0 = pressed, 1 = not pressed)
;       Port C, bit 0 - output to LED anode (1 = LED on, 0 = LED off)
;
;       When the switch is pressed, the LED comes on.
;
; Revision History
; Date     Author      Description
; 06/06/13 A. Weber    Translated from C version
; 11/18/13 A. Weber    Renamed for ATmega328P
;************************************************************

#include <avr/io.h>

	.section .text
	.global	main

main:
	sbi	_SFR_IO_ADDR(DDRC), PC0  ; Set PC0 for output
	sbi	_SFR_IO_ADDR(PORTC), PC1 ; Enable PC1 pull-up resistor

loop:
	sbis	_SFR_IO_ADDR(PINC), PC1  ; If PC1 = 1, skip next inst.
	rjmp	ledon			 ; Go turn on LED
	cbi	_SFR_IO_ADDR(PORTC), PC0 ; Turn off the LED
	rjmp	loop
ledon:
	sbi	_SFR_IO_ADDR(PORTC), PC0 ; Tun on the LED
	rjmp	loop
.end
