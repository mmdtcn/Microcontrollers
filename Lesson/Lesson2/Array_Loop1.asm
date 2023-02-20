;
; slide03_array_while_example.asm
;
; Created: 1/5/2021 9:32:40 PM
; Author : Mohammad S. Shirazi
;

.include <M328PDEF.inc>
	.def	lpCnt	= r20
	.def	cnt	= r21
	.equ	NN	= 40
	.equ	LO	= 25
	.equ	HI	= 110
	.cseg	
	.org	0x0000
	ldi	ZL,low(array << 1)
	ldi	ZH,high(array << 1)
	ldi	lpCnt, 0
	ldi	cnt, 0
loop: 	
	cpi	lpCnt,NN
	breq	done
	lpm	r16, Z+
	cpi	r16, LO
	brlo	yes
	cpi	r16, HI+1
	brsh	yes
	rjmp	next
yes:	inc	cnt
next:	inc	lpCnt
	jmp	loop
done: 	jmp	done
.org	0x200
array:
	.db 11,23,10,14,15,16,19,30,24,31
	.db	32,39,45,36,20,25,38,41,42,43
	.db	70,111,112,113,114,115,118,119,120,121
	.db	1,2,3,4,5,6,7,8,9,10
