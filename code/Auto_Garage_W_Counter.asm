
_main:

;Auto_Garage_W_Counter.c,21 :: 		void main() {
;Auto_Garage_W_Counter.c,22 :: 		unsigned char segment[]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
	MOVLW      63
	MOVWF      main_segment_L0+0
	MOVLW      6
	MOVWF      main_segment_L0+1
	MOVLW      91
	MOVWF      main_segment_L0+2
	MOVLW      79
	MOVWF      main_segment_L0+3
	MOVLW      102
	MOVWF      main_segment_L0+4
	MOVLW      109
	MOVWF      main_segment_L0+5
	MOVLW      125
	MOVWF      main_segment_L0+6
	MOVLW      7
	MOVWF      main_segment_L0+7
	MOVLW      127
	MOVWF      main_segment_L0+8
	MOVLW      111
	MOVWF      main_segment_L0+9
	CLRF       main_count_L0+0
;Auto_Garage_W_Counter.c,24 :: 		trisb=255;
	MOVLW      255
	MOVWF      TRISB+0
;Auto_Garage_W_Counter.c,25 :: 		trisc=0; portc=0;
	CLRF       TRISC+0
	CLRF       PORTC+0
;Auto_Garage_W_Counter.c,26 :: 		trisd=0; portd=0;
	CLRF       TRISD+0
	CLRF       PORTD+0
;Auto_Garage_W_Counter.c,28 :: 		loop:
___main_loop:
;Auto_Garage_W_Counter.c,29 :: 		portd=segment[count];
	MOVF       main_count_L0+0, 0
	ADDLW      main_segment_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Auto_Garage_W_Counter.c,31 :: 		if(S1_outside==1&&count<9)
	BTFSS      PORTB+0, 2
	GOTO       L_main2
	MOVLW      9
	SUBWF      main_count_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main2
L__main21:
;Auto_Garage_W_Counter.c,33 :: 		M1_open=1;
	BSF        PORTC+0, 0
;Auto_Garage_W_Counter.c,34 :: 		while(Right_entry==0);
L_main3:
	BTFSC      PORTB+0, 1
	GOTO       L_main4
	GOTO       L_main3
L_main4:
;Auto_Garage_W_Counter.c,35 :: 		M1_open=0;
	BCF        PORTC+0, 0
;Auto_Garage_W_Counter.c,36 :: 		while(S2_inside==0);
L_main5:
	BTFSC      PORTB+0, 3
	GOTO       L_main6
	GOTO       L_main5
L_main6:
;Auto_Garage_W_Counter.c,37 :: 		M1_close=1;
	BSF        PORTC+0, 1
;Auto_Garage_W_Counter.c,38 :: 		count++;
	INCF       main_count_L0+0, 1
;Auto_Garage_W_Counter.c,39 :: 		portd=segment[count];
	MOVF       main_count_L0+0, 0
	ADDLW      main_segment_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Auto_Garage_W_Counter.c,40 :: 		while(Left_entry==0);
L_main7:
	BTFSC      PORTB+0, 0
	GOTO       L_main8
	GOTO       L_main7
L_main8:
;Auto_Garage_W_Counter.c,41 :: 		M1_close=0;
	BCF        PORTC+0, 1
;Auto_Garage_W_Counter.c,42 :: 		}
L_main2:
;Auto_Garage_W_Counter.c,44 :: 		if(S3_inside==1&&count>0)
	BTFSS      PORTB+0, 6
	GOTO       L_main11
	MOVF       main_count_L0+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main11
L__main20:
;Auto_Garage_W_Counter.c,46 :: 		M2_open=1;
	BSF        PORTC+0, 2
;Auto_Garage_W_Counter.c,47 :: 		while(Right_exit==0);
L_main12:
	BTFSC      PORTB+0, 5
	GOTO       L_main13
	GOTO       L_main12
L_main13:
;Auto_Garage_W_Counter.c,48 :: 		M2_open=0;
	BCF        PORTC+0, 2
;Auto_Garage_W_Counter.c,49 :: 		while(S4_outside==0);
L_main14:
	BTFSC      PORTB+0, 7
	GOTO       L_main15
	GOTO       L_main14
L_main15:
;Auto_Garage_W_Counter.c,50 :: 		M2_close=1;
	BSF        PORTC+0, 3
;Auto_Garage_W_Counter.c,51 :: 		count=count-1;
	DECF       main_count_L0+0, 1
;Auto_Garage_W_Counter.c,52 :: 		portd=segment[count];
	MOVF       main_count_L0+0, 0
	ADDLW      main_segment_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;Auto_Garage_W_Counter.c,53 :: 		while(Left_exit==0);
L_main16:
	BTFSC      PORTB+0, 4
	GOTO       L_main17
	GOTO       L_main16
L_main17:
;Auto_Garage_W_Counter.c,54 :: 		M2_close=0;
	BCF        PORTC+0, 3
;Auto_Garage_W_Counter.c,55 :: 		}
L_main11:
;Auto_Garage_W_Counter.c,57 :: 		if(count==9)
	MOVF       main_count_L0+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;Auto_Garage_W_Counter.c,59 :: 		red_led=1;
	BSF        PORTC+0, 4
;Auto_Garage_W_Counter.c,60 :: 		}
	GOTO       L_main19
L_main18:
;Auto_Garage_W_Counter.c,61 :: 		else red_led=0;
	BCF        PORTC+0, 4
L_main19:
;Auto_Garage_W_Counter.c,62 :: 		goto loop;
	GOTO       ___main_loop
;Auto_Garage_W_Counter.c,63 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
