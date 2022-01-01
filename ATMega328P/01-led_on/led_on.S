;name:        led_on.S
;description: turn on the LED connected to PINB5.
;build:       make flash

#define    DDRB  0x04
#define    PORTB 0x05
#define    PINB5 5

.section .text
.global main

main:
    sbi      DDRB, PINB5       ;set pin 5 of DDRB register HIGH
    sbi      PORTB, PINB5      ;set pin 5 of PORTB HIGH

loop:
    rjmp     loop

.end
