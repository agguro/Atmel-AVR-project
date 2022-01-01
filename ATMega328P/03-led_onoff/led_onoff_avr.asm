
led_onoff.hex:     file format ihex


Disassembly of section .sec1:

00000000 <.sec1>:
   0:	00 e2       	ldi	r16, 0x20	; 32
   2:	04 b9       	out	0x04, r16	; 4
   4:	05 b9       	out	0x05, r16	; 5
   6:	0e 94 09 00 	call	0x12	;  0x12
   a:	00 e0       	ldi	r16, 0x00	; 0
   c:	05 b9       	out	0x05, r16	; 5
   e:	0c 94 07 00 	jmp	0xe	;  0xe
  12:	22 e5       	ldi	r18, 0x52	; 82
  14:	3b e2       	ldi	r19, 0x2B	; 43
  16:	4e ef       	ldi	r20, 0xFE	; 254
  18:	4a 95       	dec	r20
  1a:	f1 f7       	brne	.-4      	;  0x18
  1c:	3a 95       	dec	r19
  1e:	e1 f7       	brne	.-8      	;  0x18
  20:	2a 95       	dec	r18
  22:	d1 f7       	brne	.-12     	;  0x18
  24:	00 00       	nop
  26:	08 95       	ret
