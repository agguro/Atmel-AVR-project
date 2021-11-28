
led_blink.hex:     file format ihex


Disassembly of section .sec1:

00000000 <.sec1>:
   0:	00 e2       	ldi	r16, 0x20	; 32
   2:	04 b9       	out	0x04, r16	; 4
   4:	60 e2       	ldi	r22, 0x20	; 32
   6:	05 b9       	out	0x05, r16	; 5
   8:	0e 94 08 00 	call	0x10	;  0x10
   c:	06 27       	eor	r16, r22
   e:	fb cf       	rjmp	.-10     	;  0x6
  10:	22 e5       	ldi	r18, 0x52	; 82
  12:	3b e2       	ldi	r19, 0x2B	; 43
  14:	4e ef       	ldi	r20, 0xFE	; 254
  16:	4a 95       	dec	r20
  18:	f1 f7       	brne	.-4      	;  0x16
  1a:	3a 95       	dec	r19
  1c:	e1 f7       	brne	.-8      	;  0x16
  1e:	2a 95       	dec	r18
  20:	d1 f7       	brne	.-12     	;  0x16
  22:	00 00       	nop
  24:	08 95       	ret
