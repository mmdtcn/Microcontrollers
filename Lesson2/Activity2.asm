.include "m328pdef.inc"

.cseg
.org     0x00
ldi    	r16,(1<<PINB0)   	 ; load 00000001 into register 16
out 	DDRB,r16   	 
out 	PORTB,r16   	 
ldi    	r17,(1<<PINC0)    ; load 00000001 into register 17
out 	DDRC,r17   	 
out 	PORTC,r17   
loop:jmp    loop			; stay in infinite loop
