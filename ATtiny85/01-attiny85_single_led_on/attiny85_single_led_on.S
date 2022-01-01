;name:        attiny85_single_led_on.S
;description: turn on the LED connected to PINB3.
;             don't try this with PINB5, this pin cannot be used because it is setup as RESET pin,
;             PINB6 and PINB7 are reserved pins by the manufacturer.
;build:       make flash

#define    DDRB  0x17
#define    PORTB 0x18
#define    PINB  0x16
#define    PINB3 0x03

.section .text
.global main

main:
    sbi      DDRB, PINB3        ;set PINB3 in DDRB as output    
    sbi      PORTB, PINB3       ;set PINB3 of PORTB to HIGH
    
loop:    
    rjmp     loop

.end
