;
; TestAssemblerApp.asm
;
; Created: 31/10/2021 15:42:17
; Author : aguas
;

init:
call serial_init
start:
ldi r19,0x0a      ;push newline onto the stack
push r19
ldi r19,0x3e      ;print ">"
call serial_transmit
loop:
call serial_receive     ;receive a character
call serial_transmit    ;print character
cpi r19,0x0a
breq input_finished     ;if it's a newline jump to input_finished
push r19                ;otherwise push it to the stack
rjmp loop
input_finished:
pop r19                ;remove char from top of stack
call serial_transmit   ;transmit it
cpi r19,0x0a
breq start      ;if it's a newline, full string has been sent so go back to start
rjmp input_finished

;initialize serial connection
serial_init:
ldi r16,103
clr r17
sts 0xc5,r17	;set baud rate to 9600
sts 0xc4,r16
ldi r16,(1<<4)|(1<<3)  ;enable receiver and transmitter
sts 0xc1, r16
ldi r16,0b00001110  ;set frame format to async, no parity, 8 data bits and 1 stop bit
sts 0xc2,r16

;transmit byte stored in r19 over serial
serial_transmit:
lds r16,0xc0    ;wait for transmit buffer to empty
sbrs r16,5
rjmp serial_transmit
sts 0xc6, r19    ;put data to buffer
ret

;wait for byte to be send, store it in r19 and return
serial_receive:
lds r16, 0xc0    ;get value in USART Control and Status Register A
sbrs r16,7       ;if receive is complete skip next instruction
rjmp serial_receive
lds r19, 0xc6    ;load value in USART I/O data register into r19
ret


