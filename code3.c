#Include <18F4550.h>
#Fuses HS,NOPROTECT, NOWDT, CPUDIV1, PLL1
#Use Delay(Clock=8M)

#use rs232(rcv=pin_C7, xmit=pin_C6, baud=9600, bits=8, parity=n, stream = BTH)

//Registros del puerto D.
#BYTE TRISD = 0xF95
#BYTE PORTD = 0xF83

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
//Int Espacio[5]={0B00000000, 0B00000000, 0B00000000, 0B00000000, 0B00000000};

//Declaramos una variable para el tiempo.
Int8 Tiempo = 2;

int8 i=0, j = 0,k=0;
char letter;
char option;
int flag = 0;
int flagOption = 0;

void print();
void limpieza();

#Int_ext
void Texto()
{
   PORTD=0x00;
   output_high(pin_B7);
   Print();
   PORTD=0x00;
   output_low(pin_B7);
}
#int_rda
void isr_rda()
{
   //if(kbhit(BTH))
   //{
        // limpieza();
        
         flag = 1;
         letter = fgetc(BTH);
         output_high(pin_B6);
        // limpieza();
         //limpieza();
         //delay_ms(50);
 //  }

}

Void main()
{
   TRISD=0x00;
   Enable_interrupts(GLOBAL);
   Enable_interrupts(int_ext);
   enable_interrupts(int_rda);
   PORTD=0x00;
   //Delay_ms(200);
   //reinicio:
   delay_ms(100);
   while(TRUE)
   {
      if(flag == 1)
      {
         output_low(pin_B6);
         //option = letter;
         if(letter == 'A')
         {
            flagOption = 1;
         }
         else if(letter == 'B')
         {
            flagOption = 2;
         }
         else if(letter == 'C')
         {
            flagOption = 3;
         }
      }
     
    }  
 }
     

Void Print()
{
      if(flagOption == 1)
      {
         for(j=0;j<7;j++)
        {
          PORTD = Letra_C[j];
          delay_ms(Tiempo);
         }
         for(j=0;j<7;j++)
        {
          PORTD = Letra_O[j];
          delay_ms(Tiempo);
         }
         for(j=0;j<7;j++)
        {
          PORTD = Letra_M[j];
          delay_ms(Tiempo);
         }
      
      }
      else if(flagOption == 2)
      {
         for(j=0;j<7;j++)
        {
          PORTD = Letra_S[j];
          delay_ms(Tiempo);
         }
         for(j=0;j<7;j++)
        {
          PORTD = Letra_E[j];
          delay_ms(Tiempo);
         }
         for(j=0;j<7;j++)
        {
          PORTD = Letra_R[j];
          delay_ms(Tiempo);
         }
          for(j=0;j<7;j++)
        {
          PORTD = Letra_I[j];
          delay_ms(Tiempo);
         }
          for(j=0;j<7;j++)
        {
          PORTD = Letra_A[j];
          delay_ms(Tiempo);
         }
         for(j=0;j<7;j++)
        {
          PORTD = Letra_L[j];
          delay_ms(Tiempo);
         }
      }
      
      else if(flagOption == 3)
      {
         for(j=0;j<7;j++)
        {
          PORTD = Letra_M[j];
          delay_ms(Tiempo);
         }
         for(j=0;j<7;j++)
        {
          PORTD = Letra_G[j];
          delay_ms(Tiempo);
         }
         for(j=0;j<7;j++)
        {
          PORTD = Letra_X[j];
          delay_ms(Tiempo);
         }
          for(j=0;j<7;j++)
        {
          PORTD = Letra_M[j];
          delay_ms(Tiempo);
         }
          for(j=0;j<7;j++)
        {
          PORTD = Letra_V[j];
          delay_ms(Tiempo);
         }
      }
      
         
} //Aquí se cierra la función.
