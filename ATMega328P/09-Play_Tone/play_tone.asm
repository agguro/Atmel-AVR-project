;name:          5161AS-single-digit-led.asm
;assemble:      avra 5161AS-single-digit-led.asm
;flash:         avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:5161AS-single-digit-led.hex
;description:   small demonstration on how to deal with the 5161AS single digit led.
;               the program lits one led at a time with a 05. sec delay between the next state.
;               the only registers used is r16 and the carry flag.
;               assumed is that the led segments are connected to PORTD with the next configuration:
;               led - gate - value in r16
;                A     0       00000001
;                B     1       00000010
;                C     2       00000100
;                D     3       00001000
;                E     4       00010000
;                F     5       00100000
;                G     6       01000000
;               DP     7       10000000
;remark:        not using the delay functions gives the impression that all leds lits as one.
;dec 9, 2021 - agguro - no-license license

.device ATmega328P

.equ    PORTB   = 0x05
.equ    DDRB    = 0x04

.cseg
.org 0x00



start:
    ldi     r16,0b00000001  ;r16 = 0xFF all ports as output
    out     DDRB,r16        ;r16 to DDRD (0x0a) controls PORTD's in/out state.
    out     PORTB,r16       ;write r16 to PORTD
    
    call    delay           ;wait a while
    ldi     r16,0b00000000  ;r16 = 0xFF all ports as output
    out     PORTB,r16       ;write r16 to PORTD
    
loop:    
    rjmp    loop            ;continu rotating and writing
    
;Assembly code auto-generated by utility from Bret Mulvey
;Delay 7 999 996 cycles - 499ms 999us 750 ns at 16.0 MHz
;http://darcy.rsgc.on.ca/ACES/TEI4M/AVRdelay.html
delay:
    ldi     r18, 21
    ldi     r19, 75
    ldi     r20, 64
l1: 
    dec     r20
    brne    l1
    dec     r19
    brne    l1
    dec     r18
    brne    l1
    ret