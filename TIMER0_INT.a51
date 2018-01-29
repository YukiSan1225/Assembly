

                     ORG     0; RESET VECTOR
                     JMP     MAIN
                     ORG     0BH; TIMER0 HANDLER VECTOR
                     JMP     TIMER0H                     
                     ORG     50H
     MAIN:
                     MOV     P2, #0; SET P2 TO OUTPUT
                     MOV     P3, #0; SET P3 TO OUTPUT
                     MOV     TMOD, #11H ;SET MODE 1 FOR TIMER0 AND TIMER1
                     SETB    EA ;ENABLE INTERUPTS
                     SETB    ET0 ;ENABLE TIMER 0 INTERRUPT
                     MOV     A, P1; READ P1
                     SETB    TR0; START TIMER 0
     FLASH:  
                     MOV     P2, A; UPDATE P2
     ART1:
                     JNB     TF1, ART1; TRAP THE OV FLOW EVENT FOR TIMER1
                     JMP     FLASH ;LOOP MAIN                     
                     ORG     80H
     TIMER0H:
                     CLR     TF1
                     MOV     C, TF1
                     MOV     P3.1, C
                     CLR     TR0; STOP TIMER0
                     MOV     TL0, #0
                     MOV     TH0, #0
                     SETB    TR1; START TIMER 1
     HERE:
                     JNB     TF1, HERE; WAIT FOR TIMER 1 TO FINISH
                     CLR     TR1
                     MOV     C, TF1
                     MOV     P3.1, C
                     INC     A
                     SETB    TR0; START TIMER 0
                     RETI
                          
                     END

