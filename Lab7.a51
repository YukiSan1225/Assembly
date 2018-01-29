		ORG 00			
		JMP MAIN
		ORG 0BH; TIMER0 HANDLER VECTOR
		LJMP	TIMER0H
		ORG	23H
		LJMP	SERIALH
		ORG 30H
		MAIN: 
			ACALL CONFIG ; CALL BCODE USING INTERRUPT
			ACALL BCODE ; CALL CONFIG USING LCALL INTERRUPT
			ACALL SDISPLAY
		;DISPLAY WHAT BAUD RATE IS SUPPOSED TO BE
		MSG0:
			DB "BAUD RATE IS 1200 BPS",0
		MSG1:
			DB "BAUD RATE IS 2400 BPS",0
		MSG2:
			DB "BAUD RATE IS 4800 BPS",0
		MSG3:
			DB "BAUD RATE IS 9600 BPS",0			
	
		BCODE:
		JB P1.1, BC1; JMP TO BC1 IF SW1 IS 1
		JB P1.2, MV1; JMP TO MV1 IF SW2 IS 1
		JMP MV0
			
		BC1:
		JB P1.2, BC2; JMP BC2 TO SW3 IF SW3 IS 1 
		JMP MV2
			
		BC2: 
		JMP MV3
		MV0:
			MOV B, #0 ; SETS S0 TO 1200
			MOV TH1, #0F8H ; SETS BAUD TO 1200
			JMP BCEND
			
		MV1:
			MOV B, #1; SETS S0 TO 2400
			MOV TH1, #0F4H ; BAUD SET TO 2400
			JMP BCEND
			
		MV2:
			MOV B, #2 ; SETS S0 TO 4800
			MOV TH1, #0FAH ; BAUD SET TO 4800
			JMP BCEND
			
	
		MV3:
			MOV B, #3 ; SET S0 TO 9600
			MOV TH1, #0FDH ; SETS BAUD TO 9600
			JMP BCEND
		
		BCEND:	RET
		
		CONFIG: 
			MOV TMOD, #21H
			SETB EA; ENABLES INTERRUPT
			SETB ET0 ; ENABLE INTERRUPT TIMER 0 & 1
			MOV	P3,#0
			MOV P2,#0
			SETB TR0 ; START TIMER 0 & 1
			SETB TR1 
			MOV SCON, #40H ; DISABLE S0 RECEPTION
			RET
		
		ORG 100H
		SDISPLAY:
			MOV R2, B ; MOVES VALUE IN B INTO R2
			CJNE R2, #0, M2
			MOV DPTR, #MSG0
		MS1: 
			CLR A
			MOVC A, @A+DPTR
			JZ FINISH
			MOV SBUF, A
			JNB TI, $ ; WAIT UNTIL TRANSMITTED
			CLR TI
			INC DPTR
			JMP MS1	
		M2:
			CJNE R2, #1, M3
			MOV DPTR, #MSG1
		MS2:
			CLR A
			MOVC A, @A+DPTR
			JZ FINISH
			MOV SBUF, A
			JNB TI, $ ; WAIT UNTIL TRANSMITTED
			CLR TI
			INC DPTR
			JMP MS2
		M3:
			CJNE R2, #2, M4
			MOV DPTR, #MSG2
		MS3:
			CLR A
			MOVC A, @A+DPTR
			JZ FINISH
			MOV SBUF, A
			JNB TI, $
			CLR TI
			INC DPTR
			JMP MS3
		M4:
			MOV DPTR, #MSG3
		MS4:
			CLR A
			MOVC A, @A+DPTR
			JZ FINISH
			MOV SBUF, A
			JNB TI, $
			CLR TI
			INC DPTR
			JMP MS4
		FINISH:
				RET
		
		ORG 150H
		TIMER0H:
			MOV TH0, #00H ; CONFIGURING TIMER FOR MAXIMUM DELAY
			MOV TL0, #00H
			MOV R1, P2 ; READ WHATS IN P2
			MOV P3, R1 ; DISPLAY P3
			CLR	TF0
			RETI
			
		ORG 170H
		SERIALH:
			JB TI, TRANS
			MOV A, SBUF
			MOV P2, A
			CLR	TI	
			RETI
		TRANS:
			CLR TI
			RETI
		END
			