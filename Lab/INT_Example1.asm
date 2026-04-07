; Updated: 4/7/2026 3:41:37 PM
; Author : shira
;


; Replace with your application code
.INCLUDE "M328PDEF.inc"
.def delay_count = r18


.ORG 0
	JMP BEFORE_MAIN
.ORG 0x02				
	JMP EXINT0_ISR
.ORG 0x04				//Photo Interruptor 1
	JMP EXINT1_ISR


BEFORE_MAIN:
LDI R20, HIGH(RAMEND)
OUT SPH, R20
LDI R20, LOW(RAMEND)
OUT SPL, R20

SBI DDRB, 5			

CBI DDRD, 2			
SBI PORTD, 2		



LDI R22, (1<<5)    

LDI R20,0b00000011
OUT EIMSK, R20
SEI

HERE: JMP HERE


EXINT0_ISR:
	LDI delay_count,10
	CALL Delay
    IN  R21, PORTB
	EOR R21, R22
	OUT PORTB, R21
	RETI

EXINT1_ISR:
	LDI delay_count,10
	CALL Delay
    IN  R21, PORTB
	EOR R21, R22
	OUT PORTB, R21
	RETI

Delay:	//Atleast 10 ms delay (100*100 *1MHZ)
	Loop1: 
		LDI r16,100
	Loop2:
		LDI r17,100
	Loop3:
		DEC r17
		BRNE Loop3	
		DEC r16
		BRNE Loop2
		DEC delay_count
		BRNE Loop1 
		RET