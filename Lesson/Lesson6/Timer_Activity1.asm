;
; Timer_Activity1.asm
;
; Created: 4/9/2023 12:00:22 PM
; Author : Shirazi
;


.MACRO INITSTACK    ;setup stack
LDI R20, HIGH(RAMEND)
OUT SPH, R20
LDI R20, LOW(RAMEND)
OUT SPL, R20
.ENDMACRO 
INITSTACK
LDI R16,(1<<5)
SBI DDRB,5
LDI R17,0
OUT PORTB, R17
BEGIN: 
RCALL DELAY
EOR R17,R16
OUT PORTB, R17 
RJMP BEGIN
DELAY:
LDI R20,0x3E
OUT TCNT0, R20
LDI R20, 0x00
OUT TCCR0A, R20
LDI R20, 0x01
OUT TCCR0B, R20
AGAIN:
SBIS TIFR0, TOV0
RJMP AGAIN
LDI R20, 0x00
OUT TCCR0B, R20
LDI R20, (1<<TOV0)
OUT TIFR0, R20
RET 