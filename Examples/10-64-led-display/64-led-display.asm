;name:          64-led-display.asm
;assemble:      avra 64-led-display.asm
;flash:         avrdude -c arduino -p m328p -P /dev/ttyACM0 -b 115200 -U flash:w:64-led-display.hex
;description:   demonstration on how you can deal with a 64 (8x8) led display.
;remark:        The program include some demos, just to get someone starting somewhere.
;dec 9, 2021 - agguro - no-license license

;This program uses r16 as the row register and r17 as the column register to indicate the leds that
;must put on/off.  A 0-bit indicates to switch a led off for that row/column while a 1-bit indicates to switch a led on for that row/column.
;
;This is a 8x8 led display which means that one should define all the leds that must be put on or off and call the ledMatrix8x8 routine
;for each row or column seperately. (ex. an emoticon will call ledMatrix8x8 8 times (for each row once) in a loop.

.device ATmega328P

.equ	PORTB	= 0x05
.equ	DDRB	= 0x04
.equ    PORTC   = 0x08
.equ    DDRC    = 0x07
.equ    PORTD   = 0x0b
.equ    DDRD    = 0x0a

.cseg
.org 0x00

start:
    call    ledMatrix8x8Init    ;initialize PORT B,C and D
    
demos:


    call    demo0               ;blink display
    call    delay

    call    demo1               ;led cycle
    call    delay
    
    call    demo2               ;row cycle
    call    delay

    call    demo3               ;column cycle
    call    delay
    
    call    demo4               ;display a pattern

    call    demo0               ;blink display
    call    delay
    
end:
    rjmp demos

ledMatrix8x8Init:
;Initialize Port B,C and D used gates as output.
    ldi     r16,0b11111111  ;r16 = 0xFF all ports as output
    out     DDRD,r16        ;r16 to DDRD (0x0a) controls PORTD's in/out state.
    ldi     r16,0b00111111  ;r16 = 0xFF all ports as output
    out     DDRC,r16        ;r16 to DDRC (0x07) controls PORTD's in/out state.
    ldi     r16,0b00000011  ;r16 = 0xFF all ports as output
    out     DDRB,r16        ;r16 to DDRB (0x04) controls PORTD's in/out state.
    ret

;ledMatrixRow
;takes the row to light in r16.
;All leds in the columns on the same row will be ligth up.
ledMatrix8x8Row:
    out     PORTD,r16       ;r16 to PORTD (0x0b)
    ldi     r17,0b00000000  ;r17 = column 2..7 LOW
    out     PORTC,r17       ;r17 to PORTC (0x08)
    out     PORTB,r17       ;r16 to PORTB (0x05)
    ret

;ledMatrix8x8Column
;takes the columnl to ligth in r16.
;All leds in the row on the same column will be ligth up.
ledMatrix8x8Column:
    ldi     r17,0b11111111  ;all rows 0..7 HIGH
    out     PORTD,r17       ;r17 to PORTD (0x0b)
    ;split register 16 in 6 most significant bit in r18 and
    ;2 least significant bits in r19
    mov     r18,r16         ;columns in r18
    com     r18             ;invert bits
    mov     r19,r18         ;r19 = r18
    lsr     r18             ;shift out right lsbit
    lsr     r18             ;shift out right lsbit
    ldi     r26,0b00000011  ;mask for two least significant bits in r19
    and     r19,r26         ;mask all bits except bit 0 and 1
    out     PORTC,r18       ;r18 to PORTC (0x08)
    out     PORTB,r19       ;r16 to PORTB (0x05)
    ret
    
;this routine takes r16 as row register and r17 as column register for
;the 8x8 LED matrix.
;a 0-bit value means disable row/column, while a 1-bit value means:
;activate the row/column. All the LED at the intersection of a row/column = 1
;will light up while the others are extinguished.
;in a scheme it will be more clear (i hope)
;  r16 = rows:     r7  r6  r5  r4  r3  r2  r1  r0
;  r17 = columns:  c7  c6  c5  c4  c3  c2  c1  c0
;
;  The 8x8 led display:
;
;    c0  c1  c2  c3  c4  c5  c6  c7
; r7
; r6
; r5             x
; r4
; r3
; r2
; r1                      
; r0
;
; if we want to lit the led at r5,c3 we have to initialize
; r16 = 00100000 and r17 = 00001000 and call this routine.
; We cannot, however lit up the leds at r5/c3, r3/c5 (as an example) only
; because this will lit up the leds at r5/c5 and r3/c3 as well.  To avoid this
; we should call this routine for each row/column seperately and put it in a loop.

ledMatrix8x8Led:
    mov     r18,r17
    com     r18                 ;invert bits
    mov     r19,r18             ;r19 = r18
    lsr     r18
    lsr     r18
    ldi     r26,0b00000011
    and     r19,r26
    out     PORTD,r16           
    out     PORTC,r18           ;write r18 to PORTC
    out     PORTB,r19           ;write r19 to PORTB
    ret                         ;r17 returns unchanged


;Assembly code auto-generated by utility from Bret Mulvey
;Delay 12 cycles : 750 ns at 16.0 MHz
;http://darcy.rsgc.on.ca/ACES/TEI4M/AVRdelay.html
ledMatrix8x8Delay:
    ;next values are chosen to make the impression that the leds
    ;are ligth all together.
    ldi     r25, 255
    ldi     r26, 62
L2:
    dec     r25
    brne    L2
    dec     r26
    brne    L2
    ret
    
;Assembly code auto-generated by utility from Bret Mulvey
;Delay 7 999 996 cycles : 499ms 999us 750 ns at 16.0 MHz
;http://darcy.rsgc.on.ca/ACES/TEI4M/AVRdelay.html

delay:
    ldi     r22, 41
    ldi     r23, 150
    ldi     r24, 126
L1: dec     r24
    brne    L1
    dec     r23
    brne    L1
    dec     r22
    brne    L1
    ret
    
displayOn:
    ;light up all leds
    ldi     r16,0b11111111
    mov     r17,r16
    call    ledMatrix8x8Led
    ret
    
displayOff:
    ;distinguish all leds
    ldi     r16,0b00000000
    mov     r17,r16
    call    ledMatrix8x8Led
    ret

;demo0 : blink entire led matrix
demo0:
    ldi     r31,2
demo0loop:
    call    displayOn
    call    delay
    call    displayOff
    call    delay
    dec     r31
    brne    demo0loop
    ret
    
;demo1 : loops through all leds and put them on and off
demo1:
    ldi     r17,0b00000001  ;r17 has columns
    ldi     r25,0b00000000  ;r25 column counter = 0
columnLoop1:    
    ldi     r16,0b00000001  ;r16 has rows
    ldi     r20,0b00000000  ;r20 row counter = 0    
rowLoop1:
    ;light up led at r16/r17
    call    ledMatrix8x8Led
    ;wait a while, otherwise the display seems to light up all the leds at once
    call    delay
    lsl     r16             ;shift left r16 to next row
    cpi     r16,0           ;all rows done?
    brne    rowLoop1        ;still rows left
    lsl     r17             ;shift left columns
    cpi     r17,0           ;all columns done
    brne    columnLoop1     ;still columns left
    ret

;demo2 : loops through all rows and put them on and off
demo2:
    ldi     r16,0b00000001  ;r16 has rows
    ldi     r20,0b00000000  ;r20 row counter = 0    
rowLoop2:
    ;light up row r16
    call    ledMatrix8x8Row
    ;wait a while, otherwise the display seems to light up all the leds at once
    call    delay
    lsl     r16             ;shift left r16 to next row
    cpi     r16,0           ;all rows done?
    brne    rowLoop2        ;still rows left
    ret

;demo3 : loops through all columns and put them on and off
demo3:
    ldi     r16,0b00000001
columnLoop2:
    ;light up column r16
    call    ledMatrix8x8Column
    ;wait a while, otherwise the display seems to light up all the leds at once
    call    delay
    lsl     r16             ;shift left r16 to next row
    cpi     r16,0           ;all columns done?
    brne    columnLoop2     ;still rows left
    ret

;demo 4 : display a pattern
; . . x . . . x .
; x x x x x x x x
; . . x . . . x .
; . . x . . . x .
; x x x x x x x x
; . . x . . . x .
; . . x . x . x x
; . . x . . . x .
demo4:
    ldi     r31, 125
    ldi     r30, 4
    ;the demo4code itself takes some time too so very accurate measuring
    ;is not done for now.  The pattern stays for about 8 seconds.
    
demo4loop:
    call    demo4code
    dec     r31
    brne    demo4loop
    dec     r30
    brne    demo4loop
    ret
    
demo4code:   
    ldi     r16,0b01001000      ;light 4the row
    call    ledMatrix8x8Row
    call    ledMatrix8x8Delay
    ldi     r16,0b01000100      ;light 3th and 6th column
    call    ledMatrix8x8Column
    call    ledMatrix8x8Delay
    ldi     r16,0b00000010
    ldi     r17,0b00010000
    call    ledMatrix8x8Led
    call    ledMatrix8x8Delay
    ldi     r16,0b01000010
    ldi     r17,0b10010000
    call    ledMatrix8x8Led
    call    ledMatrix8x8Delay
    ldi     r16,0b00000000
    ldi     r17,0b00000000
    
    ret
