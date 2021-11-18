#!/usr/bin/bash
#
## include files on this system: /usr/lib/avr/include/avr
#
# object file
avr-gcc -Os -save-temps -DF_CPU=16000000UL -mmcu=atmega328p -c -o blink_led.o blink_led.c
# executable
avr-gcc -mmcu=atmega328p blink_led.o -o blink_led
# executable to binary(hex)
avr-objcopy -O ihex -R .eeprom blink_led blink_led.hex
# upload hex file
## avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink_led.hex
