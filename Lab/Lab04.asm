;
; Lab4.asm (Seven Segment Counter with Push Button)
;
; Created: 3/1/2023 10:29:57 AM
; Updated: 3/18/2025 4:56 PM
; Author : Mohammad Shirazi
;

.def loop_cnt = r19
.def delay_count = r22

.INCLUDE "M328PDEF.inc"

.ORG 0
LDI r17, 0xFF  //PortD is used for the display of actual number
OUT DDRD, R17
LDI r17, 0xFF  //PortC is used for driving each Digit out of 4 available digits of seven segment
OUT DDRC, R17

;Turn on the right most digit (D1)
LDI r17,0x10    ;Select D1: 0xEF
COM r17
OUT PORTC, r17



//PB0 has push button
CBI DDRB, 0		;Pin B0 (Number 14) as an inputPin 
SBI PORTB, 0	;make the pull-up resistors of C active


Start:
LDI zh, HIGH(NUMBERS<<1)
LDI zl, LOW(NUMBERS<<1)

LDI loop_cnt, 10
L1:
	SBIC PINB,0
	RJMP L1
	//TODO: Load delay_count with 10					;Delay for debounce
	//TODO: Call Delay function 			
	//TODO: Load the digit into the register r18   
	INC zl
	//TODO: Write the register r18 to PORTD
	DEC loop_cnt
	BRNE L1
	rjmp Start

//At least 10 ms delay (100*100 *1/16MHZ)
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

//TODO: Write the seven other digits in the program memory
.ORG 0x100
NUMBERS: .DB 0x3F, 0x06, 0x5B
