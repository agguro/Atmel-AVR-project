; replace by the correct include file for the MCU you are using
; or trust the IDE auto-include and delete this line

.include "./m328Pdef.inc"

.cseg
    rjmp start

    ; Skip interrupt vectors
    .org INT_VECTORS_SIZE

message:
    .db "Hello World!"
message_end:
    .equ message_len = 2 * (message_end - message)
    ; Translate program memory word address to memory mapped byte address
    ;.equ message_addr = MAPPED_PROGMEM_START + (2 * message)

start:
    ; Load address of the "hello World!" string in X
    ldi	xl, low(message)
    ldi	xh, high(message)
    ; Load EEPROM relative address 0 in r17:r16
    ldi	r16, 0
    ldi	r17, 0
    ; Load string lenght in r19
    ldi	r19, message_len
    ; Copy string to EEPROM
loop:
    ld	r18, X+
    rcall	EEPROM_write
    subi	r16, low(-1)
    sbci	r17, high(-1)
    dec	r19
    brne	loop
halt:
    rjmp halt

; EEPROM_write function
; On entry:
;	r17:r16 - relative address of data inside the EEPROM area
;	r18 - byte to be written to EEPROM
; Clobbers:
;	zl (r30), zh (r31)
; All other registers preserved
EEPROM_write:
    ; Wait for completion of previous write
    lds	zl, NVMCTRL_STATUS
    sbrc	zl, NVMCTRL_EEBUSY_bp
    rjmp	EEPROM_write                    ; see edit #1 note
    ; Translate relative EEPROM address from r17:r16 to mapped address in Z
    movw	Z, r17:r16
    subi	zl, low(-EEPROM_START)
    sbci	zh, high(-EEPROM_START)
    ; Store EEPROM data (r18) to write buffer
    st	Z, r18
    ; Execute NWM erase/write command
    in	zh, CPU_SREG				; preserve interrupt flag
    cli						; make sure interrupts are disabled for critical section
    ldi	zl, CPU_CCP_SPM_gc			; unlock NVM command register
    out	CPU_CCP, zl
    ldi	zl, NVMCTRL_CMD_PAGEERASEWRITE_gc	; execute NVM erase/write
    sts	NVMCTRL_CTRLA, zl
    out	CPU_SREG, zh				; restore interrupt flag
    ret
