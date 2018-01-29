		ORG             00			;Instructions starting at 00
		JMP             MAIN		;Go to Main
		
BLOCK1  MACRO;		*START OF BLOCK 1*
		CLR             A;			;clear accA
		MOVC    		A, @A+DPTR;	;accA = accA + DPTR
		MOV             B, A;	 	;copy to accB what is in accA
		ENDM						;return command
						 
BLOCK2  MACRO;		*START OF BLOCK 2*
		CLR             A;			;clear accA
		MOVC    		A, @A+DPTR;	;move to accA
		MOV             C, 00;		;copy to C what is in 00
		ADDC    		A, B;		;accA = accA + carry + accB
		MOV             00, C;		;copy to 00 what is in C
		ENDM						;return command
		 
		ORG             30H			;Main begins at 20Hex
		MAIN:					
		MOV    	        P0, #0;		 ;copy #0 to port 0
		MOV             P1, #0;		 ;copy #0 to port 1
		MOV             P2, #0;		 ;copy #0 to port 2
		MOV             P3, #0;		 ;copy #0 to port 3
		CLR             00			 ;Clear origin
		 
		MOV             DPTR, #100H; ;copy 100H to DPTR
		BLOCK1						 ;go to BLOCK 1
		MOV             DPTR, #105H; ;copy 105H to DPTR
		BLOCK2						 ;go to BLOCK 2
		MOV             40H, A;		 ;copy accA to 40H
		MOV             P0, A;		 ;copy accA to port0
						 
		MOV             DPTR, #101H; ;copy 101H to DPTR
		BLOCK1						 ;go to BLOCK 1
		MOV             DPTR, #106H; ;copy 106H to DPTR
		BLOCK2						 ;go to BLOCK 2
		MOV             41H, A;		 ;copy accA to 41H
		MOV             P1, A;		 ;copy accA to port1
		 
		MOV             DPTR, #102H; ;copy 102H to DPTR
		BLOCK1						 ;go to BLOCK 1
		MOV             DPTR, #107H; ;copy 107H to DPTR	
		BLOCK2  					 ;go to BLOCK 2
		MOV             42H, A;		 ;copy accA to 42H
		MOV             P2, A; 		 ;copy accA to port2
				 
		JNB             OV, NOOV;	 ;branches to NOOV if OV=0(no overflow)
		MOV             A, #1;		 ;copy #1 to accA
		MOV             43H, A;		 ;copy accA to 43H
		MOV             P3, A;		 ;copy accA to port3
		JMP             WAIT
		NOOV:						 ;No overflow block
		MOV             A, #0;		 ;copy 0 to accA
		MOV             P3, A;		 ;copy to port3 what is in accA
		WAIT:   		JMP	$		 
						 
		ORG             100H
		DB              5AH, 7FH, 79H
		ORG             105H
		DB              88H, 0BCH, 44H
		END