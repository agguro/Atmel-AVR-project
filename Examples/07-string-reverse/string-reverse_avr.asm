
string-reverse.hex:     file format ihex


Disassembly of section .sec1:

00000000 <.sec1>:
   0:	0e 94 15 00 	call	0x2a	;  0x2a
   4:	3a e0       	ldi	r19, 0x0A	; 10
   6:	3f 93       	push	r19
   8:	3e e3       	ldi	r19, 0x3E	; 62
   a:	0e 94 21 00 	call	0x42	;  0x42
   e:	0e 94 28 00 	call	0x50	;  0x50
  12:	0e 94 21 00 	call	0x42	;  0x42
  16:	3a 30       	cpi	r19, 0x0A	; 10
  18:	11 f0       	breq	.+4      	;  0x1e
  1a:	3f 93       	push	r19
  1c:	f8 cf       	rjmp	.-16     	;  0xe
  1e:	3f 91       	pop	r19
  20:	0e 94 21 00 	call	0x42	;  0x42
  24:	3a 30       	cpi	r19, 0x0A	; 10
  26:	71 f3       	breq	.-36     	;  0x4
  28:	fa cf       	rjmp	.-12     	;  0x1e
  2a:	07 e6       	ldi	r16, 0x67	; 103
  2c:	11 27       	eor	r17, r17
  2e:	10 93 c5 00 	sts	0x00C5, r17	;  0x8000c5
  32:	00 93 c4 00 	sts	0x00C4, r16	;  0x8000c4
  36:	08 e1       	ldi	r16, 0x18	; 24
  38:	00 93 c1 00 	sts	0x00C1, r16	;  0x8000c1
  3c:	0e e0       	ldi	r16, 0x0E	; 14
  3e:	00 93 c2 00 	sts	0x00C2, r16	;  0x8000c2
  42:	00 91 c0 00 	lds	r16, 0x00C0	;  0x8000c0
  46:	05 ff       	sbrs	r16, 5
  48:	fc cf       	rjmp	.-8      	;  0x42
  4a:	30 93 c6 00 	sts	0x00C6, r19	;  0x8000c6
  4e:	08 95       	ret
  50:	00 91 c0 00 	lds	r16, 0x00C0	;  0x8000c0
  54:	07 ff       	sbrs	r16, 7
  56:	fc cf       	rjmp	.-8      	;  0x50
  58:	30 91 c6 00 	lds	r19, 0x00C6	;  0x8000c6
  5c:	08 95       	ret
