; name:        led_off.asm
; assemble:    avra led_off.asm
; flash:       avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:led_off.hex
; description: turns led on port 13 on.
;              It turns off the LED which is connected to PB5 (digital out 13).
; source:      http://www.rjhcoding.com/avr-asm-tutorials.php

.nolist
.include "./m328Pdef.inc"
.list

.cseg
.org 	0x00

start:
    ldi      r16,0xFF ; r16 = 0xFF (255)
    out      DDRB,r16 ; Out writes to SRAM, which is one way of accessing pins. DDRB controls PORTB's in/out state.
    ldi      r16,0x00 ; r16 is where we'll store current LED state, 0x00 means all pins low.
    out      PORTB,r16 ; set all B pins to current state. PORTB is where our favorite flashing pin is (pin 13)!

loop:
    rjmp     loop

