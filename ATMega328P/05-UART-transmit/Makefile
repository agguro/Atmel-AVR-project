program=UART_transmit

$(program).hex: $(program).asm
	avra -fI $(program).asm -o $(program).hex -l $(program).lst

build:
	make $(program).hex
	make upload

upload: $(program).hex $(program).asm
	avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:$(program).hex

monitor:
	stty -F /dev/ttyACM0 9600 raw -clocal -echo
	cat /dev/ttyACM0

disassemble:
	avr-objdump -j .sec1 -d -m avr5 ${program}.hex >> ${program}_avr.asm

.PHONY: all upload
