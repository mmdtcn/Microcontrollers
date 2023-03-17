;
; Lab07_5.asm
;
; Created: 3/17/2023 3:52:06 PM
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

SBI DDRB, 5			;Set the PB5 port as output connected to the LED

CBI DDRB, 0			//Define input for PINB0 	
SBI PORTB, 0		//Set the pull up resistor for the switch



LDI R22, (1<<5)     //set R22 with 0b00100000

LDI R20,0b00000001
STS PCMSK0, R20   //Enable PB0 in PCMSK0

LDI R20, (1<<PCIE0) 
STS PCICR, R20  //Enable portB change interrupt

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
