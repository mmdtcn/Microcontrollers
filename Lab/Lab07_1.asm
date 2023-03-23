;
; Lab07_1.asm
;
; Created: 3/16/2023 8:59:46 AM
; Author : shirazi
;

; Replace with your application code
.INCLUDE "M328PDEF.inc"


.ORG 0
	JMP BEFORE_MAIN
.ORG 0x02				//ISR address for the external int 0
	JMP EXINT0_ISR


BEFORE_MAIN:
LDI R20, HIGH(RAMEND)
OUT SPH, R20
LDI R20, LOW(RAMEND)
OUT SPL, R20

SBI DDRB, 5			;Set the PB5 port as output connected to the LED

CBI DDRD, 2			//Define input for PIND2 	
SBI PORTD, 2		//Set the pull up resistor for the switch



LDI R22, (1<<5)     //set R22 with 0b00100000

LDI R20,1<<INT0
OUT EIMSK, R20
SEI

HERE: JMP HERE


EXINT0_ISR:
	IN  R21, PORTB
	EOR R21, R22
	OUT PORTB, R21
	RETI
