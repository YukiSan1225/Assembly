	ORG	00
	JMP MAIN

	ORG		30H
		MAIN: 
			MOV P0, #0 ; Initialize Port 0-3 to output
			MOV P1, #0 
			MOV P2, #0
			MOV P3, #0
			CLR 00 ; Clear origin
				
			MOV DPTR, #100H ; copy value in 100H to DPTR
			CLR A ; clear the accumulator 
			MOVC A, @A+DPTR ; accA = accA + DPTR
			MOV B, A ; copy the value that is in A into B
			
			MOV DPTR, #105H ; copy value in 105H to DPTR
			CLR A ; clear the accumulator 
			MOVC A, @A+DPTR ; accA = accA + DPTR
			MOV C, 00 ; copy whats in C into 00
			ADDC A, B ; accA = accA + carry + accB
			MOV 00, C ; copy to 00 what is C
			MOV 40H, A ; copy accA to 40H
			MOV P0, A ; copy accA to port0
			
			MOV DPTR, #101H ; copy value in 101H to DPTR
			CLR A ; clear the accumulator 
			MOVC A, @A+DPTR ; accA = accA + DPTR
			MOV B, A ; copy the value that is in A into B
			
			MOV DPTR, #106H ; copy value in 106H to DPTR
			CLR A ; clear the accumulator
			MOVC A, @A+DPTR ; move this value to accA
			MOV C, 00 ; copy whats in C into 00
			ADDC A, B ; accA = accA + carry + accB
			MOV 00, C  ; copy to 00 what is C
			MOV 41H, A ; copy accA to 41H
			MOV P1, A ; copy accA to port1
			
			MOV DPTR, #102H ; copy value in 102H to DPTR
			CLR A ; clear the accumulator
			MOVC A, @A+DPTR ; move this value to accA
			MOV B, A ; copy the value that is in A into B
			
			MOV DPTR, #107H
			CLR A ; clear the accumulator
			MOVC A, @A+DPTR ; move this value to accA
			MOV C, 00 ; copy whats in C into 00
			ADDC A, B ; accA = accA + carry + accB
			MOV 00, C ; copy to 00 what is C
			MOV 42H, A ; copy accA to 42H 
			MOV P2, A ; copy accA to port2
			
			JNB OV, NOOV
			MOV A, #3
			MOV 43H, A
			MOV P3, A
			JMP WAIT
			
			NOOV:
				MOV A, #0 ; copy 0 to accA
				MOV P3, A ; copy to port3 whats in accA
			WAIT: JMP $ //WAIT HERE
			
			ORG	 100H
			DB	 45H, 33H, 22H
			ORG  105H
			DB  30H, 45H, 22H
			END