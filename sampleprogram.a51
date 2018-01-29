		ORG 00
		
		JMP MAIN
		
		ORG 40H
			MAIN:
			MOV TMOD, #01100000B
			MOV TH1, #0
			MOV TL1, #0
			SETB P3.5
			
			AGAIN: SETB TR1
			BACK:
				MOV A, TL1
				MOV P2, A
				INC TL1
				JNB TF1, BACK
				CLR TR1
				CLR TF1
				SJMP AGAIN
				
			END