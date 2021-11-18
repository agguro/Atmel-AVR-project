;name:            UART_receive.asm
;assemble:        avra UART_receive.asm
;flash:           avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:UART_receive.hex
;description:     reads user input from the UART and redisplays it.
;                 the data can be viewed with Arduino serial monitor.
;                 Another nice tool can be found here: https://github.com/mich-w/QtSerialMonitor
;                 This tool you can keep running and connect and disconnect whenever you want.
;                 One draw back is that we need to send an extra 0x0a to the UART otherwise it
;                 doesn't show anything. (For the serial plotter we need to do this anyway).
;inspir(at)ed from: http://www.rjhcoding.com/avr-asm-uart.php
;nov 5, 2021 - agguro - no-license license

.include "../../Include/m328Pdef.inc"

.dseg
.org 0x100
name:       .byte 255

.cseg
.org 0x00

.equ    baud = 9600
.equ    bps  = 16000000/16/baud-1

start:

    ldi     r16,LOW(bps)                    ;load baud prescale
    ldi     r17,HIGH(bps)                   ;into r17:r16
    call    UART_init

    ;send message so user knows when to start
    ldi     ZL,LOW(2*hello)
    ldi     ZH,HIGH(2*hello)
    call    UART_puts
    
    ;wait for a keypress
    call    UART_getc
    ;we don't have to check, any key will do
    
    ldi     ZL,LOW(2*question)
    ldi     ZH,HIGH(2*question)
    call    UART_puts
    
    ldi     ZL,LOW(2*name)
    ldi     ZH,HIGH(2*name)
    call    UART_gets
    
    ;say bye bye
    ldi     ZL,LOW(2*bye)
    ldi     ZH,HIGH(2*bye)                   ;into r17:r16
    call    UART_puts
    
    ;and print the response
    ldi     ZL,LOW(2*name)
    ldi     ZH,HIGH(2*name)                   ;into r17:r16
    call    UART_puts
    
    
loop:
    rjmp loop

;initialize UART with LOW(bps) in r16 and HIGH(bps) in r17.
;bps = cpuFrequency/16/baud-1
UART_init:
    sts     0xc4,r16                        ;load baud prescale
    sts     0xc5,r17                        ;to UBRR0
    ldi     r16,(1<<0x03)|(1<<0x04)         ;enable transmitter
    sts     0xc1,r16                        ;and receiver
    ldi     r16,0b00001110                  ;set frame format to async, no parity, 8 data bits and 1 stop bit
    sts     0xc2,r16
    ret

;send a byte in r16 to the UART
UART_putc:
    lds     r17,0xc0                        ;load UCSR0A into r17
    sbrs    r17,0x05                        ;wait for empty transmit buffer
    rjmp    UART_putc                       ;repeat loop
    sts     0xc6,r16                        ;transmit character
    ret                                     ;return from subroutine

;send a zero terminated string to the UART
;Program Memory address of string to transmit is in r30:r31 (ZH:ZL)
UART_puts:
    lpm     r16,Z+                          ;load character from pmem
    cpi     r16,$00                         ;check if null
    breq    UART_puts_end                   ;branch if null
UART_puts_wait:
    lds     r17,0xc0                        ;load UCSR0A into r17
    sbrs    r17,0x05                        ;wait for empty transmit buffer
    rjmp    UART_puts_wait                  ;repeat loop
    sts     0xc6,r16                        ;transmit character
    rjmp    UART_puts                       ;repeat loop
UART_puts_end:
    ret

;receives single ASCII character via UART in r16
UART_getc:
    lds     r17,UCSR0A                      ;load UCSR0A into r17
    sbrs    r17,RXC0                        ;receive complete
    rjmp    UART_getc                       ;repeat loop
    lds     r16,UDR0                        ;get received character
    ret

;**************************************************************
;* subroutine: gets
;*
;* inputs: XH:XL - SRAM buffer address for rcv'd string
;*
;* outputs: none
;*
;* receives characters via UART and stores in data memory
;* until carriage return received
;*
;* registers modified: r16, r17, ZL, ZH
;**************************************************************

UART_gets:
    lds     r17,UCSR0A          ;load UCSR0A into r17
    sbrs    r17,RXC0            ;receive complete
    rjmp    UART_gets           ;repeat loop
    lds     r16,UDR0            ;get received character
    st      Z+,r16              ;store character to buffer
    cpi     r16,0x0a            ;check if rcv'd char is CR
    breq    UART_gets_end       ;branch if CR rcv'd
    rjmp    UART_gets           ;get another character
UART_gets_end:
    ret


hello:      .db "Press a key to continue...",0x0a,0x0d,0x00
bye:        .db "bye bye, ",0x00

question:   .db "What is your name?",0x0a,0x0d,0x00



