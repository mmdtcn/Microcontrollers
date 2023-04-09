;
; Timer_Activity2.asm
;
; Created: 4/9/2023 12:11:11 PM
; Author : Shirazi
;

.MACRO INITSTACK    ;setup stack
LDI R20, HIGH(RAMEND)
OUT SPH, R20
LDI R20, LOW(RAMEND)
OUT SPL, R20
.ENDMACRO 
INITSTACK
LDI R16,(1<<3)
SBI DDRB,3
LDI R17,0
OUT PORTB, R17
BEGIN: 
  RCALL DELAY
  EOR R17,R16
  OUT PORTB, R17 
RJMP BEGIN
DELAY:
//TODO: Generate 640 us time delay with timer 0, use CTC mode
//TODO: Use Appropriate prescaler 
AGAIN:
//TODO: Skip next line if OCF0A flag is set inside TIFR0A register
RJMP AGAIN
LDI R20, 0x00
OUT TCCR0B, R20
LDI R20, (1<<OCF0A)
OUT TIFR0, R20
RET 
