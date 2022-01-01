DEVICE     = attiny85
CLOCK      = 1000000
PROGRAMMER = -c stk500v1 -P /dev/ttyACM0 -b 19200
OBJECTS    = attiny85_all_leds_off.o
FUSES      = -U lfuse:w:0x62:m -U hfuse:w:0xDF:m -U efuse:w:0xFE:m -U lock:w:0xFF:m 

# Fuse Low Byte = 0xE0   Fuse High Byte = 0xD9   Fuse Extended Byte = 0xFE      Fuse Lockbit = 0xFF
# Bit 7: CKDIV8  = 1     Bit 7: RSTDISBL  = 1    Bit 7:                         Bit 7: 
#     6: CKOUT   = 0         6: DWEN      = 1        6:                         Bit 6:
#     5: SUT1    = 0         5: SPIEN     = 0        5:                         Bit 5:
#     4: SUT0    = 1         4: WDTON     = 1        4:                         Bit 4:
#     3: CKSEL3  = 1         3: EESAVE    = 1        3:                         Bit 3:
#     2: CKSEL2  = 1         2: BODLEVEL2 = 0        2:                         Bit 2:
#     1: CKSEL1  = 0         1: BODLEVEL1 = 0        1:                         Bit 1:
#     0: CKSEL0  = 1         0: BODLEVEL0 = 1        0: SELFPRGEN = 1           Bit 0:

# Tune the lines below only if you know what you are doing:

AVRDUDE = avrdude -v -p$(DEVICE) $(PROGRAMMER)
COMPILE = avr-gcc -Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE) -nostartfiles

# symbolic targets:
all:	main.hex

.c.o:
	$(COMPILE) -c $< -o $@

.S.o:
	$(COMPILE) -x assembler-with-cpp -c $< -o $@
# "-x assembler-with-cpp" should not be necessary since this is the default
# file type for the .S (with capital S) extension. However, upper case
# characters are not always preserved on Windows. To ensure WinAVR
# compatibility define the file type manually.

.c.s:
	$(COMPILE) -S $< -o $@

flash:	all
	$(AVRDUDE) -U flash:w:main.hex:i 

fuse:
	$(AVRDUDE) $(FUSES)

# Xcode uses the Makefile targets "", "clean" and "install"
install: flash fuse

# if you use a bootloader, change the command below appropriately:
load: all
	bootloadHID main.hex

clean:
	rm -f main.hex main.elf $(OBJECTS)

# file targets:
main.elf: $(OBJECTS)
	$(COMPILE) -o main.elf $(OBJECTS)

main.hex: main.elf
	rm -f main.hex
	avr-objcopy -j .text -j .data -O ihex main.elf main.hex
	avr-size --format=avr --mcu=$(DEVICE) main.elf
# If you have an EEPROM section, you must also create a hex file for the
# EEPROM and add it to the "flash" target.

# Targets for code debugging and analysis:
disasm:	main.elf
	avr-objdump -d main.elf

cpp:
	$(COMPILE) -E main.c
