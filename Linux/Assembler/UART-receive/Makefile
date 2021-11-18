program=UART_receive

build:
	make $(program).hex
	make upload

upload: $(program).hex $(program).asm
	avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:$(program).hex

$(program).hex: $(program).asm
	avra -fI $(program).asm -o $(program).hex -l $(program).lst
	
monitor:
	stty -F /dev/ttyACM0 9600 raw -echo isig intr ^Q quit undef susp undef -clocal -echo
	cat /dev/ttyACM0
	
.PHONY: all upload
