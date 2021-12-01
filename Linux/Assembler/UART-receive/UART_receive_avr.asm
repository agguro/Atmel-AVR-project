
UART_receive.hex:     file format ihex


Disassembly of section .sec1:

00000000 <.sec1>:
   0:	07 e6       	ldi	r16, 0x67	; 103
   2:	10 e0       	ldi	r17, 0x00	; 0
   4:	0e 94 1b 00 	call	0x36	;  0x36
   8:	e4 e9       	ldi	r30, 0x94	; 148
   a:	f0 e0       	ldi	r31, 0x00	; 0
   c:	0e 94 2d 00 	call	0x5a	;  0x5a
  10:	0e 94 38 00 	call	0x70	;  0x70
  14:	ec eb       	ldi	r30, 0xBC	; 188
  16:	f0 e0       	ldi	r31, 0x00	; 0
  18:	0e 94 2d 00 	call	0x5a	;  0x5a
  1c:	e0 e0       	ldi	r30, 0x00	; 0
  1e:	f2 e0       	ldi	r31, 0x02	; 2
  20:	0e 94 3f 00 	call	0x7e	;  0x7e
  24:	e2 eb       	ldi	r30, 0xB2	; 178
  26:	f0 e0       	ldi	r31, 0x00	; 0
  28:	0e 94 2d 00 	call	0x5a	;  0x5a
  2c:	e0 e0       	ldi	r30, 0x00	; 0
  2e:	f2 e0       	ldi	r31, 0x02	; 2
  30:	0e 94 2d 00 	call	0x5a	;  0x5a
  34:	ff cf       	rjmp	.-2      	;  0x34
  36:	00 93 c4 00 	sts	0x00C4, r16	;  0x8000c4
  3a:	10 93 c5 00 	sts	0x00C5, r17	;  0x8000c5
  3e:	08 e1       	ldi	r16, 0x18	; 24
  40:	00 93 c1 00 	sts	0x00C1, r16	;  0x8000c1
  44:	0e e0       	ldi	r16, 0x0E	; 14
  46:	00 93 c2 00 	sts	0x00C2, r16	;  0x8000c2
  4a:	08 95       	ret
  4c:	10 91 c0 00 	lds	r17, 0x00C0	;  0x8000c0
  50:	15 ff       	sbrs	r17, 5
  52:	fc cf       	rjmp	.-8      	;  0x4c
  54:	00 93 c6 00 	sts	0x00C6, r16	;  0x8000c6
  58:	08 95       	ret
  5a:	05 91       	lpm	r16, Z+
  5c:	00 30       	cpi	r16, 0x00	; 0
  5e:	39 f0       	breq	.+14     	;  0x6e
  60:	10 91 c0 00 	lds	r17, 0x00C0	;  0x8000c0
  64:	15 ff       	sbrs	r17, 5
  66:	fc cf       	rjmp	.-8      	;  0x60
  68:	00 93 c6 00 	sts	0x00C6, r16	;  0x8000c6
  6c:	f6 cf       	rjmp	.-20     	;  0x5a
  6e:	08 95       	ret
  70:	10 91 c0 00 	lds	r17, 0x00C0	;  0x8000c0
  74:	17 ff       	sbrs	r17, 7
  76:	fc cf       	rjmp	.-8      	;  0x70
  78:	00 91 c6 00 	lds	r16, 0x00C6	;  0x8000c6
  7c:	08 95       	ret
  7e:	10 91 c0 00 	lds	r17, 0x00C0	;  0x8000c0
  82:	17 ff       	sbrs	r17, 7
  84:	fc cf       	rjmp	.-8      	;  0x7e
  86:	00 91 c6 00 	lds	r16, 0x00C6	;  0x8000c6
  8a:	01 93       	st	Z+, r16
  8c:	0a 30       	cpi	r16, 0x0A	; 10
  8e:	09 f0       	breq	.+2      	;  0x92
  90:	f6 cf       	rjmp	.-20     	;  0x7e
  92:	08 95       	ret
  94:	50 72       	andi	r21, 0x20	; 32
  96:	65 73       	andi	r22, 0x35	; 53
  98:	73 20       	and	r7, r3
  9a:	61 20       	and	r6, r1
  9c:	6b 65       	ori	r22, 0x5B	; 91
  9e:	79 20       	and	r7, r9
  a0:	74 6f       	ori	r23, 0xF4	; 244
  a2:	20 63       	ori	r18, 0x30	; 48
  a4:	6f 6e       	ori	r22, 0xEF	; 239
  a6:	74 69       	ori	r23, 0x94	; 148
  a8:	6e 75       	andi	r22, 0x5E	; 94
  aa:	65 2e       	mov	r6, r21
  ac:	2e 2e       	mov	r2, r30
  ae:	0a 0d       	add	r16, r10
  b0:	00 00       	nop
  b2:	62 79       	andi	r22, 0x92	; 146
  b4:	65 20       	and	r6, r5
  b6:	62 79       	andi	r22, 0x92	; 146
  b8:	65 2c       	mov	r6, r5
  ba:	20 00       	.word	0x0020	; ????
  bc:	57 68       	ori	r21, 0x87	; 135
  be:	61 74       	andi	r22, 0x41	; 65
  c0:	20 69       	ori	r18, 0x90	; 144
  c2:	73 20       	and	r7, r3
  c4:	79 6f       	ori	r23, 0xF9	; 249
  c6:	75 72       	andi	r23, 0x25	; 37
  c8:	20 6e       	ori	r18, 0xE0	; 224
  ca:	61 6d       	ori	r22, 0xD1	; 209
  cc:	65 3f       	cpi	r22, 0xF5	; 245
  ce:	0a 0d       	add	r16, r10
	...
