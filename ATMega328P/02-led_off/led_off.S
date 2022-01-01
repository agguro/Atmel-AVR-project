;name:        led_on.S
;description: turn off the LED connected to PINB5 on PORTB.
;build:       make flash

#define    DDRB  0x04
#define    PORTB 0x05
#define    PINB5 5

.section .text
.global main

main:
    sbi      DDRB, PINB5       ;set pin 5 of DDRB register HIGH
    cbi      PORTB, PINB5      ;set pin 5 of PORTB HIGH

loop:
    rjmp     loop

.end
