; Updated: 4/7/2026 10:32:06 AM
; Author : Shirazi
;

; Replace with your application code
.INCLUDE "M328PDEF.inc"
.def delay_count = r18


.ORG 0
	JMP BEFORE_MAIN
.ORG 0x06				//Switch 1
	JMP PCINT0_ISR

BEFORE_MAIN:
LDI R20, HIGH(RAMEND)
OUT SPH, R20
LDI R20, LOW(RAMEND)
OUT SPL, R20

SBI DDRB, 5			

CBI DDRB, 0			//Define input for PINB0 	
SBI PORTB, 0		//Set the pull up resistor for the switch



LDI R22, (1<<5)    

LDI R20,0b00000001
STS PCMSK0, R20   

LDI R20, (1<<PCIE0) 
STS PCICR, R20 

SEI

HERE: JMP HERE


PCINT0_ISR:
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
