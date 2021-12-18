;name:        at328-1.asm
;description: When the switch is pressed, the LED comes on.
;             Port C, bit 1 - input from switch (0 = pressed, 1 = not pressed)
;             Port C, bit 0 - output to LED anode (1 = LED on, 0 = LED off)
;source:      https://ece-classes.usc.edu/ee459/library/plaintext.php?file=samples/AVR/at328-1s.S
;             https://ece-classes.usc.edu/ee459/library/plaintext.php?file=samples/AVR/at328-1.c
;             https://ece-classes.usc.edu/ee459/library/samples/AVR/Makefile-ATmega328P
;remark:      This a reversed engineered version of at328-1s.S
;             The assembly source can be generated with Makefile disasm > at328-1.disasm
;             from the original-source directory.
;             The use of interrupts isn't a necessary one.  Because of the 'reversing' nature of 
;             this project I've kept it as it was.

.device ATmega328P

.equ    PINC = 0x06
.equ    DDRC = 0x07
.equ    PORTC = 0x08
.equ    SREG = 0x3f
.equ    RAMEND = 0x08ff
.equ    SPL = 0x3d
.equ    SPH = 0x3e

.cseg
.org 0x00

start_int_vectors:
    jmp     start                   ; jmp to program start
    jmp     undefined_int_routine   ; External Interrupt Request 0           INT0_vect
    jmp     undefined_int_routine   ; External Interrupt Request 1           INT1_vect
    jmp     undefined_int_routine   ; Pin Change Interrupt Request 0         PCINT0_vect
    jmp     undefined_int_routine   ; Pin Change Interrupt Request 1         PCINT1_vect
    jmp     undefined_int_routine   ; Pin Change Interrupt Request 2         PCINT2_vect
    jmp     undefined_int_routine   ; Watchdog Time-out Interrupt            WDT_vect
    jmp     undefined_int_routine   ; Timer/Counter2 Compare Match A         TIMER2_COMPA_vect
    jmp     undefined_int_routine   ; Timer/Counter2 Compare Match B         TIMER2_COMPB_vect
    jmp     undefined_int_routine   ; Timer/Counter2 Overflow                TIMER2_OVF_vect
    jmp     undefined_int_routine   ; Timer/Counter1 Capture Event           TIMER1_CAPT_vect
    jmp     undefined_int_routine   ; Timer/Counter1 Compare Match A         TIMER1_COMPA_vect
    jmp     undefined_int_routine   ; Timer/Counter1 Compare Match B         TIMER1_COMPB_vect
    jmp     undefined_int_routine   ; Timer/Counter1 Overflow                TIMER1_OVF_vect
    jmp     undefined_int_routine   ; Timer/Counter0 Compare Match A         TIMER0_COMPA_vect
    jmp     undefined_int_routine   ; Timer/Counter0 Compare Match B         TIMER0_COMPB_vect
    jmp     undefined_int_routine   ; Timer/Counter0 Overflow                TIMER0_OVF_vect
    jmp     undefined_int_routine   ; SPI Serial Transfer Complete           SPI_STC_vect
    jmp     undefined_int_routine   ; USART Rx Complete                      USART_RX_vect
    jmp     undefined_int_routine   ; USART Data Register Empty              USART_UDRE_vect
    jmp     undefined_int_routine   ; USART Tx Complete                      USART_TX_vect
    jmp     undefined_int_routine   ; ADC Conversion Complete                ADC_vect
    jmp     undefined_int_routine   ; EEPROM Ready                           EE_READY_vect
    jmp     undefined_int_routine   ; Analog Comparator                      ANALOG_COMP_vect
    jmp     undefined_int_routine   ; Two-wire Serial Interface              TWI_vect
    jmp     undefined_int_routine   ; Store Program Memory Read              SPM_READY_vect
  
start:
    ; setup stack to end of SRAM
    eor     r1, r1
    out     SREG, r1
    ldi     r28, LOW(RAMEND)
    ldi     r29, HIGH(RAMEND)
    out     SPH, r29
    out     SPL, r28
    call    main                    ;call program
    jmp     exit

undefined_int_routine:
    jmp     start_int_vectors       ;to begin of interrupt vector table

main:
    sbi     DDRC, 0                 ;Set PC0 for output
    sbi     PORTC, 1                ;Enable PC1 pull-up resistor

loop:
    sbis    PINC, 1                 ;If PC1 = 1, skip next inst.
    rjmp    ledon                   ;Go turn on LED
    cbi     PORTC, 0                ;Turn off the LED
    rjmp    loop

ledon:
    sbi     PORTC, 0                ;Turn on the LED
    rjmp    loop

exit:
    cli

stop:
    rjmp    stop         ;
