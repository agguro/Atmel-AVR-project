;name:        attiny85_all_leds_on.S
;description: turn on all the LED connected to PINB0 .. PINB4.
;             don't try this with PINB5, this pin cannot be used because it is setup as RESET pin,
;             PINB6 and PINB7 are reserved pins by the manufacturer.
;build:       make flash

#define    DDRB  0x17
#define    PORTB 0x18
#define    PINB  0x16
;as information
#define    PINB0 0x00
#define    PINB1 0x01
#define    PINB2 0x02
#define    PINB3 0x03
#define    PINB4 0x04

.section .text
.global main

main:

    ldi     r16, 0x1F           ;pins 0..4 HIGH, pins 5, 6 and 7 are reserved
    out     DDRB, r16
    out     PORTB, r16          ;write to PORTB

loop:

    rjmp    loop                ;repeat

.end

