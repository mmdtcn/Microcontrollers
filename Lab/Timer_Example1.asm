; Updated: 4/7/2026 10:09:14 AM
; Author : Mohammad S. Shirazi
;


; Replace with your application code
.include "m328pdef.inc"

.def temp = R16
.def timer = R17

.org 0x00
	jmp MAIN
.org 0x1C
	jmp T0_CM_ISR


Main:
	ldi temp, HIGH(RAMEND)
	out SPH, temp
	ldi temp, LOW(RAMEND)
	out SPL, temp		

	
	ldi temp, 32
	out OCR0A, temp

	ldi temp, (1<<WGM01) 
	out TCCR0A, temp

	ldi temp, 0x01 
	out TCCR0B, temp

	ldi temp, (1<<OCIE0A) 
	sts TIMSK0, temp

	sei


Here:
	cpi timer, 0x01
	breq Main
jmp Here



T0_CM_ISR:
	inc timer
	ldi temp, 32
	out OCR0A, temp
	RETI
