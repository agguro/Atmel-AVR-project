;name:            UART_transmit.asm
;assemble:        avra UART_transmit.asm
;flash:           avrdude -p m328p -c stk500v1 -b 57600 -P /dev/ttyACM0 -U flash:w:UART_transmit.hex
;description:     writes to the UART
;                 the data can be viewed with Arduino serial monitor and serial plotter.
;                 Another nice tool can be found here: https://github.com/mich-w/QtSerialMonitor
;                 This tool you can keep running and connect and disconnect whenever you want.
;                 One draw back is that we need to send an extra 0x0a to the UART otherwise it
;                 doesn't show anything. (For the serial plotter we need to do this anyway).
;inspir(at)ed from: http://www.rjhcoding.com/avr-asm-uart.php
;nov 5, 2021 - agguro - no-license license
    
.cseg
.org 0x00

.equ    baud = 9600
.equ    bps  = 16000000/16/baud-1

start:
    ldi     r16,LOW(bps)                    ;load baud prescale
    ldi     r17,HIGH(bps)                   ;into r17:r16
    call    UART_init

    ;say hello
    ldi     r30,LOW(2*message)              ;load Z pointer with
    ldi     r31,HIGH(2*message)             ;datastring address
    
    ldi r16,0x36
    call    UART_putc
    ldi r16,0x37
    call    UART_putc
    ldi r16,0x0a
    call    UART_putc

    ;transmit a datastring
    ;this is viewable is serial monitor as just the string.
    ;In the serial plotter it is showed as 4 graphs.
loop:
    ldi     r30,LOW(2*datastring)           ;load Z pointer with
    ldi     r31,HIGH(2*datastring)          ;datastring address
    rcall   UART_puts                       ;transmit string

    rjmp loop

;initialize UART with LOW(bps) in r16 and HIGH(bps) in r17.
;bps = cpuFrequency/16/baud-1
UART_init:
    sts     0xc4,r16                ;load baud prescale
    sts     0xc5,r17                ;to UBRR0
    ldi     r16,(1<<0x03)|(1<<0x04) ;enable transmitter
    sts     0xc1,r16                ;and receiver
    ldi     r16,0b00001110          ;set frame format to async, no parity, 8 data bits and 1 stop bit
    sts     0xc2,r16
    ret                             ;return from subroutine

;send a byte in r16 to the UART
UART_putc:
    lds     r17,0xc0                ;load UCSR0A into r17
    sbrs    r17,0x05                ;wait for empty transmit buffer
    rjmp    UART_putc               ;repeat loop
    sts     0xc6,r16                ;transmit character
    ret                             ;return from subroutine

;send a zero terminated string to the UART
;Program Memory address of string to transmit is in r30:r31 (ZH:ZL)
UART_puts:
    lpm     r16,Z+                  ;load character from pmem
    cpi     r16,$00                 ;check if null
    breq    UART_puts_end           ;branch if null
UART_puts_wait:
    lds     r17,0xc0                ;load UCSR0A into r17
    sbrs    r17,0x05                ;wait for empty transmit buffer
    rjmp    UART_puts_wait          ;repeat loop
    sts     0xc6,r16                ;transmit character
    rjmp    UART_puts               ;repeat loop
UART_puts_end:
    ret                             ;return from subroutine

message:       .db     "Hello world.",0x0a,0x00    
datastring:    .db     "100 200 300 400 500",0x0a,0x00
