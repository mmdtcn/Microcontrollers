;
; Lab04.asm
;
; Created: 2/15/2023 10:22:46 AM
; Author : Mohammad S. Shirazi
;

.INCLUDE "M328PDEF.inc"
.def delay_count = r22

.ORG 0
LDI R16,0x20 ;R16 = 00100000 
OUT DDRC,R16 
SBI PORTC, 5
LDI R17, 0x20 
LDI R16, 0x20
OUT PORTD,R16
L2: 
	LDI delay_count, 1					
	CALL Delay				
	EOR R16,R17
	OUT PORTC,R16
	RJMP L2 

//Delay around ... us (... ms)
Delay:	
Loop1: 
	LDI r24,0xFF
Loop2:
	NOP
	NOP
	DEC r24
	BRNE Loop2
	DEC delay_count
	BRNE Loop1 
	RET

