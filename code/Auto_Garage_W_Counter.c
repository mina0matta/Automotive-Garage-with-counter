/***************************************
Project: Automotive Garage With Counter
Type : PIC16F877A
Crystal : 8 MHz
***************************************/
/*      Stop is the reset switch      */
#define Left_entry portb.f0
#define Right_entry portb.f1
#define S1_outside portb.f2
#define S2_inside portb.f3
#define Left_exit portb.f4
#define Right_exit portb.f5
#define S3_inside portb.f6
#define S4_outside portb.f7
#define M1_open portc.f0
#define M1_close portc.f1
#define M2_open portc.f2
#define M2_close portc.f3
#define red_led portc.f4
/**************************************/
void main() {
  unsigned char segment[]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
  unsigned char count=0;
  trisb=255;
  trisc=0; portc=0;
  trisd=0; portd=0;
  
  loop:
       portd=segment[count];
       
       if(S1_outside==1&&count<9)
       {
        M1_open=1;
        while(Right_entry==0);
        M1_open=0;
        while(S2_inside==0);
        M1_close=1;
        count++;
        portd=segment[count];
        while(Left_entry==0);
        M1_close=0;
       }
       
       if(S3_inside==1&&count>0)
       {
        M2_open=1;
        while(Right_exit==0);
        M2_open=0;
        while(S4_outside==0);
        M2_close=1;
        count=count-1;
        portd=segment[count];
        while(Left_exit==0);
        M2_close=0;
       }
       
       if(count==9)
       {
        red_led=1;
       }
       else red_led=0;
  goto loop;
}