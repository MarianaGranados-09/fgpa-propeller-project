#include <18F4550.h>
#fuses INTRC, NOPROTECT, NOWDT, NOLVP, CPUDIV1, PLL1        
#use delay (clock = 8M)

#use rs232(rcv=pin_B7, xmit=pin_B6, baud=9600, bits=8, parity=n, stream = BTH)
#use rs232(rcv=pin_B5, xmit=pin_B4, baud=9600, bits=8, parity=n, stream = TTL)

#BYTE TRISD = 0xF95
#BYTE PORTD = 0xF83

//int8 i = 0;
char option;
int8 tiempo = 2;
int j;
//char word[8];


//Declaracion de los vectores de cada letra.
Int Letra_A[7]={0B00111111, 0B01001000, 0B10001000, 0B01001000, 0B00111111, 0B00000000, 0B00000000};
Int Letra_B[7]={0B11111111, 0B10010001, 0B10010001, 0B10101001, 0B01000110, 0B00000000, 0B00000000};
Int Letra_C[7]={0B11111111, 0B10000001, 0B10000001, 0B10000001, 0B11000011, 0B00000000, 0B00000000};
Int Letra_D[7]={0B11111111, 0B10000001, 0B10000001, 0B01000010, 0B00111100, 0B00000000, 0B00000000};
Int Letra_E[7]={0B11111111, 0B10010001, 0B10010001, 0B10010001, 0B10000001, 0B00000000, 0B00000000};
Int Letra_F[7]={0B11111111, 0B10010000, 0B10010000, 0B10000000, 0B10000000, 0B00000000, 0B00000000};
Int Letra_G[7]={0B11111111, 0B10010001, 0B10010001, 0B10010001, 0B10011111, 0B00000000, 0B00000000};
Int Letra_H[7]={0B11111111, 0B00010000, 0B00010000, 0B00010000, 0B11111111, 0B00000000, 0B00000000};
Int Letra_I[7]={0B10000001, 0B10000001, 0B11111111, 0B10000001, 0B10000001, 0B00000000, 0B00000000};
Int Letra_J[7]={0B10000111, 0B10000001, 0B10000001, 0B10000001, 0B11111111, 0B00000000, 0B00000000};
Int Letra_K[7]={0B11111111, 0B00010000, 0B00101000, 0B01000100, 0B10000011, 0B00000000, 0B00000000};
Int Letra_L[7]={0B11111111, 0B00000001, 0B00000001, 0B00000001, 0B00000001, 0B00000000, 0B00000000};
Int Letra_M[7]={0B11111111, 0B01000000, 0B00100000, 0B01000000, 0B11111111, 0B00000000, 0B00000000};
Int Letra_N[7]={0B11111111, 0B00110000, 0B00011000, 0B00001100, 0B11111111, 0B00000000, 0B00000000};
Int Letra_O[7]={0B01111110, 0B10000001, 0B10000001, 0B10000001, 0B01111110, 0B00000000, 0B00000000};
Int Letra_P[7]={0B11111111, 0B10001000, 0B10001000, 0B10001000, 0B01110000, 0B00000000, 0B00000000};
Int Letra_Q[7]={0B01111110, 0B10001001, 0B10000101, 0B10000011, 0B01111110, 0B00000000, 0B00000000};
Int Letra_R[7]={0B11111111, 0B10001000, 0B10001100, 0B10001010, 0B01110001, 0B00000000, 0B00000000};
Int Letra_S[7]={0B11110011, 0B10001001, 0B10001001, 0B10001001, 0B11000111, 0B00000000, 0B00000000};
Int Letra_T[7]={0B10000000, 0B10000000, 0B11111111, 0B10000000, 0B10000000, 0B00000000, 0B00000000};
Int Letra_U[7]={0B11111110, 0B00000001, 0B00000001, 0B00000001, 0B11111110, 0B00000000, 0B00000000};
Int Letra_V[7]={0B11111100, 0B00000010, 0B00000001, 0B00000010, 0B11111100, 0B00000000, 0B00000000};
Int Letra_W[7]={0B11111111, 0B00000010, 0B00000100, 0B00000010, 0B11111111, 0B00000000, 0B00000000};
Int Letra_X[7]={0B11000111, 0B00101000, 0B00010000, 0B00101000, 0B11000111, 0B00000000, 0B00000000};
Int Letra_Y[7]={0B11000000, 0B00100000, 0B00011111, 0B00100000, 0B11000000, 0B00000000, 0B00000000};
Int Letra_Z[7]={0B11000111, 0B10001001, 0B10010001, 0B10100001, 0B11000011, 0B00000000, 0B00000000};

void ImprimirA();
void ImprimirB();
void ImprimirC();
void Margin();


void main()
{
   //letter = fgetc(BTH);
   fprintf(TTL, "READY TO GO!\r\n");
   while(true)
   {
      
      option = fgetc(BTH);
      
      if(option == 'A')
      {
         //mensaje de switch 1: Hola
         fprintf(TTL, "[A] La palabra que se mostrara en el propeller es COM \r\n"); 
         delay_ms(50);
         ImprimirA();
      }
      else if(option == 'B')
      {
         //mensaje de switch 2: Mundo
         fprintf(TTL, "[B] La palabra que se mostrara en el propeller es SERIAL \r\n");
         delay_ms(50);
         ImprimirB();
      }
      else if(option == 'C')
      {
         //mensaje de switch 3: Digit
         fprintf(TTL, "[C] La palabra que se mostrara en el propeller es MGXVC \r\n");
         delay_ms(50);
         ImprimirC();
      }
      else if(option == 'D')
      {
         //mensaje de switch 3: Digit
         fprintf(TTL, "[D] INICIO MOTOR \r\n");
         delay_ms(50);
         //ImprimirDigit();
      }
      else if(option == 'E')
      {
         //mensaje de switch 3: Digit
         fprintf(TTL, "[E] PARO MOTOR \r\n");
         delay_ms(50);
         //ImprimirDigit();
      }
  
    }
    option = 0;
   
   }
   
   
void Margin(){
   output_high(pin_C7);
   output_high(pin_C6);
}
   
void ImprimirA()
{
    //margen
    Margin();
   //impresion de C
   for(j=0;j<7;j++)
      {
         PORTD = Letra_C[j];
         delay_ms(Tiempo);
      }
   //impresion de O
   for(j=0;j<7;j++)
      {
        PORTD = Letra_O[j];
        delay_ms(Tiempo);
      }
   //impresion de M
   for(j=0;j<7;j++)
      {
        PORTD = Letra_M[j];
        delay_ms(Tiempo);
      }
}

void ImprimirB()
{
   //margen
   Margin();
   //impresion de S
    for(j=0;j<7;j++)
      {
        PORTD = Letra_S[j];
        delay_ms(Tiempo);
      }
    //impresion de E
    for(j=0;j<7;j++)
      {
        PORTD = Letra_E[j];
        delay_ms(Tiempo);
      }
    //impresion de R
    for(j=0;j<7;j++)
      {
        PORTD = Letra_R[j];
        delay_ms(Tiempo);
      }
    //impresion de I
    for(j=0;j<7;j++)
      {
        PORTD = Letra_I[j];
        delay_ms(Tiempo);
      }
    //impresion de A
    for(j=0;j<7;j++)
      {
        PORTD = Letra_A[j];
        delay_ms(Tiempo);
      }
     //impresion de L
    for(j=0;j<7;j++)
      {
        PORTD = Letra_L[j];
        delay_ms(Tiempo);
      }

}

void ImprimirC()
{
   //margen
   Margin();
   //impresion de M
    for(j=0;j<7;j++)
      {
        PORTD = Letra_M[j];
        delay_ms(Tiempo);
      }
    //impresion de G
    for(j=0;j<7;j++)
      {
        PORTD = Letra_G[j];
        delay_ms(Tiempo);
      }
    //impresion de X
    for(j=0;j<7;j++)
      {
        PORTD = Letra_X[j];
        delay_ms(Tiempo);
      }
    //impresion de M
    for(j=0;j<7;j++)
      {
        PORTD = Letra_M[j];
        delay_ms(Tiempo);
      }
    //impresion de V
    for(j=0;j<7;j++)
      {
        PORTD = Letra_V[j];
        delay_ms(Tiempo);
      }
}
