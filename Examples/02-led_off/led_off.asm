;name:            led_off.asm
;assemble:        avra led_off.asm
;flash:           avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:led_off.hex
;description:     Turns off the LED which is connected to PB5 (digital out 13).
;inspir(at)ed by: http://www.rjhcoding.com/avr-asm-led-blink.php
;nov 5, 2021 - agguro - no-license license

.device ATmega328P
.cseg
.org 0x00

start:
    ldi      r16,0b00100000 ;r16 = 0x20 PB5 as output
    out      0x04,r16       ;r16 to DDRB (0x04) controls PORTB's in/out state.
    ldi      r16,0b00000000 ;r16 = 0x00 set PB5 low (the famous pin 13 on Arduino Uno Rev3)
    out      0x05,r16       ;set PORTB with values from r16, pin 13 = low
loop:
    rjmp     loop
