
5161AS-single-digit-led.hex:     file format ihex


Disassembly of section .sec1:

00000000 <.sec1>:
   0:	0f ef       	ldi	r16, 0xFF	; 255
   2:	0a b9       	out	0x0a, r16	; 10
   4:	00 27       	eor	r16, r16
   6:	08 94       	sec
   8:	00 1f       	adc	r16, r16
   a:	0b b9       	out	0x0b, r16	; 11
   c:	0e 94 09 00 	call	0x12	;  0x12
  10:	fb cf       	rjmp	.-10     	;  0x8
  12:	29 e2       	ldi	r18, 0x29	; 41
  14:	36 e9       	ldi	r19, 0x96	; 150
  16:	4e e7       	ldi	r20, 0x7E	; 126
  18:	4a 95       	dec	r20
  1a:	f1 f7       	brne	.-4      	;  0x18
  1c:	3a 95       	dec	r19
  1e:	e1 f7       	brne	.-8      	;  0x18
  20:	2a 95       	dec	r18
  22:	d1 f7       	brne	.-12     	;  0x18
  24:	08 95       	ret
