;name:        at328-0.asm
;description: Program loops turning PC0 on and off as fast as possible.
;source:      https://ece-classes.usc.edu/ee459/library/plaintext.php?file=samples/AVR/at328-0s.S
;             https://ece-classes.usc.edu/ee459/library/plaintext.php?file=samples/AVR/at328-0.c
;             https://ece-classes.usc.edu/ee459/library/samples/AVR/Makefile-ATmega328P
;remark:      This a cracked version of at328-0s.S
;             The assembly source can be generated with Makefile disasm > at328-o.disasm
;             from the original-source directory.
;             The use of interrupts isn't a necessary one.  Because of the 'reversing' nature of 
;             this project I've kept it as it was.

.device ATmega328P

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

loop:
    sbi     PORTC, 0                ;PC0=1      
    cbi     PORTC, 0                ;PC0=0
    rjmp    loop

exit:
    cli                             ;disable global interrupt flag
    
stop:
    rjmp    stop                    ;stop program
