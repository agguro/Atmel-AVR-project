	.file	"blink_led.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(3999)
	ldi r25,hi8(3999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	ldi r25,lo8(5)
1:	dec r25
	brne 1b
	nop
	sbi 0x4,5
.L2:
	sbi 0x5,5
	ldi r18,lo8(9599999)
	ldi r24,hi8(9599999)
	ldi r25,hlo8(9599999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	cbi 0x5,5
	ldi r18,lo8(9599999)
	ldi r24,hi8(9599999)
	ldi r25,hlo8(9599999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rjmp .L2
	.size	main, .-main
	.ident	"GCC: (GNU) 5.4.0"
