#include <18F4550.h>
#fuses INTRC, NOPROTECT, NOWDT, NOLVP, CPUDIV1, PLL1        
#use delay (clock = 8M)

#use rs232(rcv=pin_C7, xmit=pin_C6, baud=9600, bits=8, parity=n, stream = BTH)
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

void ImprimirHola();
void ImprimirMundo();
void ImprimirDigit();


void main()
{
   //letter = fgetc(BTH);
   fprintf(TTL, "READY TO GO!\r\n");
   while(true)
   {
      
      option = fgetc(BTH);
      
      if(option == '1')
      {
         //mensaje de switch 1: Hola
         fprintf(TTL, "[1] La palabra que se mostrara en el propeller es Hola \r\n"); 
         delay_ms(50);
         ImprimirHola();
      }
      else if(option == '2')
      {
         //mensaje de switch 2: Mundo
         fprintf(TTL, "[2] La palabra que se mostrara en el propeller es Mundo \r\n");
         delay_ms(50);
         ImprimirMundo();
      }
      else if(option == '3')
      {
         //mensaje de switch 3: Digit
         fprintf(TTL, "[3] La palabra que se mostrara en el propeller es Digit \r\n");
         delay_ms(50);
         ImprimirDigit();
      }
  
    }
    option = 0;
   
   }
   
void ImprimirHola()
{
   //impresion de H
   for(j=0;j<7;j++)
      {
         PORTD = Letra_H[j];
         delay_ms(Tiempo);
      }
   //impresion de O
   for(j=0;j<7;j++)
      {
        PORTD = Letra_O[j];
        delay_ms(Tiempo);
      }
   //impresion de L
   for(j=0;j<7;j++)
      {
        PORTD = Letra_L[j];
        delay_ms(Tiempo);
      }
    //impresion de A
    for(j=0;j<7;j++)
      {
        PORTD = Letra_A[j];
        delay_ms(Tiempo);
      }

}

void ImprimirMundo()
{
   //impresion de M
    for(j=0;j<7;j++)
      {
        PORTD = Letra_M[j];
        delay_ms(Tiempo);
      }
    //impresion de U
    for(j=0;j<7;j++)
      {
        PORTD = Letra_U[j];
        delay_ms(Tiempo);
      }
    //impresion de N
    for(j=0;j<7;j++)
      {
        PORTD = Letra_N[j];
        delay_ms(Tiempo);
      }
    //impresion de D
    for(j=0;j<7;j++)
      {
        PORTD = Letra_D[j];
        delay_ms(Tiempo);
      }
    //impresion de O
    for(j=0;j<7;j++)
      {
        PORTD = Letra_O[j];
        delay_ms(Tiempo);
      }

}

void ImprimirDigit()
{
   //impresion de D
    for(j=0;j<7;j++)
      {
        PORTD = Letra_D[j];
        delay_ms(Tiempo);
      }
    //impresion de I
    for(j=0;j<7;j++)
      {
        PORTD = Letra_I[j];
        delay_ms(Tiempo);
      }
    //impresion de G
    for(j=0;j<7;j++)
      {
        PORTD = Letra_G[j];
        delay_ms(Tiempo);
      }
    //impresion de I
    for(j=0;j<7;j++)
      {
        PORTD = Letra_I[j];
        delay_ms(Tiempo);
      }
    //impresion de T
    for(j=0;j<7;j++)
      {
        PORTD = Letra_T[j];
        delay_ms(Tiempo);
      }
}
