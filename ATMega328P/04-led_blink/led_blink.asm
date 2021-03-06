;name:            led_blink.asm
;assemble:        avra led_blink.asm
;flash:           avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:led_blink.hex
;description:     Toggles PB5 (led at pin 13) constantly on and of with a 4secs delay.
;inspir(at)ed by: http://www.rjhcoding.com/avr-asm-led-blink.php
;nov 5, 2021 - agguro - no-license license

.device ATmega328P

.equ    DDRB = 0x04
.equ    PORTB = 0x05

.cseg
.org 0x00

start:  
    ldi     r16,0b00100000  ;r16 = 0x20 PB5 as output
    out     DDRB,r16        ;r16 to DDRB (0x04) controls PORTB's in/out state.
    ldi     r22,0b00100000  ;to use as mask  
loop:
    ;re-use r16 = 0x00100000 to set PB5 high (the famous pin 13 on Arduino Uno Rev3)
    out     PORTB,r16        ;set PORTB with values from r16, pin 13 = low
    call    delay
    eor     r16,r22         ;toggle bit PB5
    rjmp    loop
    
;Assembly code auto-generated by utility from Bret Mulvey
;Delay 31 999 991 cycles 1s 999ms 999us 437 1/2 ns at 16.0 MHz
;http://darcy.rsgc.on.ca/ACES/TEI4M/AVRdelay.html
delay:
    ldi     r18, 82
    ldi     r19, 43
    ldi     r20, 254
l1: 
    dec     r20
    brne    l1
    dec     r19
    brne    l1
    dec     r18
    brne    l1
    nop
    ret
