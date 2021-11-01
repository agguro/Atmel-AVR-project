/*
 * compile:
 * avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o blink_led.o blink_led.c
 * link:
 * avr-gcc -mmcu=atmega328p blink_led.o blink_led
 * make eeprom code:
 * avr-objcopy -O ihex -R .eeprom blink_led blink_led.hex
 * flash Arduino Uno rev 3
 * avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:blink_led.hex
 */

#include <avr/io.h>
#include <util/delay.h>

#define MS_DELAY 3000

int main (void) {
    /*Set to one the fifth bit of DDRB to one
    **Set digital pin 13 to output mode */
    DDRB |= _BV(DDB5);

    while(1) {
        /*Set to one the fifth bit of PORTB to one
        **Set to HIGH the pin 13 */
        PORTB |= _BV(PORTB5);

        /*Wait 3000 ms */
        _delay_ms(MS_DELAY);

        /*Set to zero the fifth bit of PORTB
        **Set to LOW the pin 13 */
        PORTB &= ~_BV(PORTB5);

        /*Wait 3000 ms */
        _delay_ms(MS_DELAY);
    }
}    
