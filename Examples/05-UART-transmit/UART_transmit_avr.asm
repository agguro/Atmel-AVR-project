
UART_transmit.hex:     file format ihex


Disassembly of section .sec1:

00000000 <.sec1>:
   0:	07 e6       	ldi	r16, 0x67	; 103
   2:	10 e0       	ldi	r17, 0x00	; 0
   4:	0e 94 15 00 	call	0x2a	;  0x2a
   8:	e4 e6       	ldi	r30, 0x64	; 100
   a:	f0 e0       	ldi	r31, 0x00	; 0
   c:	0e 94 27 00 	call	0x4e	;  0x4e
  10:	06 e3       	ldi	r16, 0x36	; 54
  12:	0e 94 20 00 	call	0x40	;  0x40
  16:	07 e3       	ldi	r16, 0x37	; 55
  18:	0e 94 20 00 	call	0x40	;  0x40
  1c:	0a e0       	ldi	r16, 0x0A	; 10
  1e:	0e 94 20 00 	call	0x40	;  0x40
  22:	e2 e7       	ldi	r30, 0x72	; 114
  24:	f0 e0       	ldi	r31, 0x00	; 0
  26:	13 d0       	rcall	.+38     	;  0x4e
  28:	fc cf       	rjmp	.-8      	;  0x22
  2a:	00 93 c4 00 	sts	0x00C4, r16	;  0x8000c4
  2e:	10 93 c5 00 	sts	0x00C5, r17	;  0x8000c5
  32:	08 e1       	ldi	r16, 0x18	; 24
  34:	00 93 c1 00 	sts	0x00C1, r16	;  0x8000c1
  38:	0e e0       	ldi	r16, 0x0E	; 14
  3a:	00 93 c2 00 	sts	0x00C2, r16	;  0x8000c2
  3e:	08 95       	ret
  40:	10 91 c0 00 	lds	r17, 0x00C0	;  0x8000c0
  44:	15 ff       	sbrs	r17, 5
  46:	fc cf       	rjmp	.-8      	;  0x40
  48:	00 93 c6 00 	sts	0x00C6, r16	;  0x8000c6
  4c:	08 95       	ret
  4e:	05 91       	lpm	r16, Z+
  50:	00 30       	cpi	r16, 0x00	; 0
  52:	39 f0       	breq	.+14     	;  0x62
  54:	10 91 c0 00 	lds	r17, 0x00C0	;  0x8000c0
  58:	15 ff       	sbrs	r17, 5
  5a:	fc cf       	rjmp	.-8      	;  0x54
  5c:	00 93 c6 00 	sts	0x00C6, r16	;  0x8000c6
  60:	f6 cf       	rjmp	.-20     	;  0x4e
  62:	08 95       	ret
  64:	48 65       	ori	r20, 0x58	; 88
  66:	6c 6c       	ori	r22, 0xCC	; 204
  68:	6f 20       	and	r6, r15
  6a:	77 6f       	ori	r23, 0xF7	; 247
  6c:	72 6c       	ori	r23, 0xC2	; 194
  6e:	64 2e       	mov	r6, r20
  70:	0a 00       	.word	0x000a	; ????
  72:	31 30       	cpi	r19, 0x01	; 1
  74:	30 20       	and	r3, r0
  76:	32 30       	cpi	r19, 0x02	; 2
  78:	30 20       	and	r3, r0
  7a:	33 30       	cpi	r19, 0x03	; 3
  7c:	30 20       	and	r3, r0
  7e:	34 30       	cpi	r19, 0x04	; 4
  80:	30 20       	and	r3, r0
  82:	35 30       	cpi	r19, 0x05	; 5
  84:	30 0a       	sbc	r3, r16
	...
