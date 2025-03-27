;
; Read from switch and toggle LED
;
; Created: 1/27/2021 3:03:52 PM
; Author : Mohammad S. Shirazi
;


; Replace with your application code
.INCLUDE "M328PDEF.inc"
.def delay_count = r22

.ORG 0
LDI R16,0x01 ;R16 = 00000001 (Make PD0 output, PIN 2 on chip) 
OUT DDRD,R16 ;make Port D an output port
SBI PORTD, 0
CBI DDRC, 5		;Pin C5 as an inputPin
; SBI PORTC, 5	;make the pull-up resistors of C active
LDI R17, 0x01 
LDI R16, 0x01
OUT PORTD,R16
L2: 
	SBIC PINC,5
	RJMP L2
	LDI delay_count, 13					;Delay for debaounce, atleast 130 ms
	CALL Delay				
	EOR R16,R17
	OUT PORTD,R16
	RJMP L2 

//At least 10 ms delay (100*100 *1MHZ)
Delay:	
Loop1: 
	LDI r24,100
Loop2:
	LDI r23,100
Loop3:
	DEC r23
	BRNE Loop3	
	DEC r24
	BRNE Loop2
	DEC delay_count
	BRNE Loop1 
	RET