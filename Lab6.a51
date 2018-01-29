		ORG 00
		JMP MAIN
		ORG 80H
			
		MAIN:
			MOV P1, #0FFH ; INITIALIZE PORT 1 AS INPUT AND 2 FOR OUTPUT
			MOV P2, #00H
			SETB REN ; ENABLE RECEPTION
			MOV TMOD, #21H ; CONFIGURE TIMER 0 FOR MODE 1
			MOV TL0, #0 ; SET TL0 AND TH0 W/ MAXIMUM DELAY 
			MOV TH0, #0
			MOV TH1, #-3; SETS BAUD RATE TO 9600
			SETB SM1 ; SET SERIAL 0 MODE 1 
			SETB TR1 ; START TIMER 1
			SETB TR0 ; START TIMER 0
			
			JNB RI, $ ; WAIT FOR CHARACTER
			MOV A, SBUF
			INC A ; INCREMENT A
			CLR RI ; CLEAR THE STATUS OF REGISTRAR
			
			MOV SBUF, A ; MOVE WHATS IN A TO SBUF
			JNB TI, $ ; WAIT ON CHARACTER TO BE TRANSMITTED
			CLR TI
			CLR TR1
				
			JNB TF0, $ ; WAIT UNTIL TIMER FLAG 0 IS THROWN
			MOV P1, A ; MOVE WHATS IN ACCUMLATOR TO P1
			CPL A
			MOV P2, A
			CLR TF0
			CLR TR0
				
			CLR REN ; STOP RECEPTION
			END
				