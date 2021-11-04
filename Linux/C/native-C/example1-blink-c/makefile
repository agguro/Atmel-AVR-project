all:
	avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o blink_led.o blink_led.c
	avr-gcc -mmcu=atmega328p blink_led.o -o blink_led
	avr-objcopy -O ihex -R .eeprom blink_led blink_led.hex
	avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink_led.hex
