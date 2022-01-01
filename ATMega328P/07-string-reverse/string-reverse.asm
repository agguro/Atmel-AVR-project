;name:            string_reverse.asm
;assemble:        avra string_reverse.asm
;flash:           avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:string_reverse.hex
;description:     read a string from the UART and reverse writes it to the UART
;monitor:         stty -F /dev/ttyACM0 9600 raw -clocal -echo
;                 cat /dev/ttyACM0
;inspir(at)ed from: http://www.rjhcoding.com/avr-asm-uart.php
;nov 5, 2021 - agguro - no-license license

.device ATmega328P

.equ    baud = 9600
.equ    bps  = 16000000/16/baud-1

.cseg
.org 0x00

start:
    ldi     r16,LOW(bps)                ;load baud prescale
    ldi     r17,HIGH(bps)               ;into r17:r16
    call    UART_init

loop1:
    ldi     r16,0x0a                    ;push newline onto the stack
    push    r16
    ldi     r16,0x3e                    ;print ">"    
    call    UART_putc
    
loop2:
    call    UART_getc                   ;receive a character
    call    UART_putc                   ;print character
    cpi     r16,0x0a
    breq    input_finished              ;if it's a newline jump to input_finished
    push    r16                         ;otherwise push it to the stack
    rjmp    loop2

input_finished:
    pop     r16                         ;remove char from top of stack
    call    UART_putc                   ;transmit it
    cpi     r16,0x0a
    breq    loop1                       ;if it's a newline, full string has been sent so go back to start
    rjmp    input_finished

;initialize UART with LOW(bps) in r16 and HIGH(bps) in r17.
;bps = cpuFrequency/16/baud-1
UART_init:
    sts     0xc4,r16                    ;load baud prescale
    sts     0xc5,r17                    ;to UBRR0
    ldi     r16,(1<<0x03)|(1<<0x04)     ;enable transmitter
    sts     0xc1,r16                    ;and receiver
    ldi     r16,0b00001110              ;set frame format to async, no parity, 8 data bits and 1 stop bit
    sts     0xc2,r16
    ret

;send a byte in r16 to the UART
UART_putc:
    lds     r17,0xc0                    ;load UCSR0A into r17
    sbrs    r17,0x05                    ;wait for empty transmit buffer
    rjmp    UART_putc                   ;repeat loop
    sts     0xc6,r16                    ;transmit character
    ret                                 ;return from subroutine
    
;receives single ASCII character via UART in r16
UART_getc:
    lds     r17,0xc0                    ;load UCSR0A into r17
    sbrs    r17,7                       ;receive complete
    rjmp    UART_getc                   ;repeat loop
    lds     r16,0xc6                    ;get received character
    ret
