//Code working perfect.
#Include <18F4550.h>
#Fuses INTRC,NOPROTECT, NOWDT, CPUDIV1, PLL1
#Use Delay(Clock=8M)
#Include <string.h>
#Use RS232(RCV=PIN_C7, XMIT=PIN_C6, Baud=9600, Bits=8, Stream = BTH)
#Use RS232(RCV=PIN_B5, XMIT=PIN_B4, Baud=9600, Bits=8, Stream = TTL)

//Registros del puerto D.
#BYTE TRISD = 0xF95
#BYTE PORTD = 0xF83

#BIT OERR = 0XFAB.1
#BIT FERR = 0XFAB.2
#BIT CREN = 0XFAB.4
#BYTE TRISC = 0XF94
#BYTE RCSTA = 0XFAB

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
char real;
char carac;
char word[100];
char wordreal[100];

int flag = 0;

Void Limpiar_palabra();
void print();
void motorGiro();
void limpieza();

#Int_ext
Void Texto()
{
   
   PORTD=0x00;
   Print();
   PORTD=0x00;
}
#int_rda
void isr_rda()
{
   //if(kbhit(BTH))
   //{
         limpieza();
         flag = 1;
         letter = fgetc(BTH);
         limpieza();
         output_high(pin_a1);
         delay_us(10);
         real = letter;
         limpieza();
         delay_ms(50);
         output_low(pin_a1);
 //  }

}

Void main()
{
   TRISD=0x00;
   Fprintf(TTL, "READY TO GO\r\n");
   //letter = fgetc(BTH);
   Limpiar_palabra();
   Enable_interrupts(GLOBAL);
   Enable_interrupts(int_ext);
   enable_interrupts(int_rda);
   PORTD=0x00;
   //Delay_ms(200);
   //reinicio:
   delay_ms(100);
   while(TRUE)
   {
      //while(motor == 'e' && flag==1);
      //Solo hacer el cambio de palabra en caso de que el motor este apagado y en caso de que la interrupcion haya guardado
      //una palabra nueva dentro de la variable word.
      //delay_ms(5000);
      if(flag == 1 && real == 'A')
      {
         //Cambio de palabra aqui
         //delay_ms(2000);
         delay_ms(1000);
         wordreal[0] = 'C';
         wordreal[1] = 'O';
         wordreal[2] = 'M';
         delay_ms(50);
         limpiar_palabra();
         fprintf(TTL, "[A] La palabra que se mostrara en el propeller es: \r\n");
         for(int u=0;u<3;u++)
         {
            fprintf(TTL, "%c", wordreal[u]);
         }
         delay_ms(1000);
         flag = 0;   
      }
      else if(flag == 1 && real == 'B')
      {
         //Cambio de palabra aqui
         //delay_ms(2000);
         delay_ms(1000);
         wordreal[0] = 'S';
         wordreal[1] = 'E';
         wordreal[2] = 'R';
         wordreal[3] = 'I';
         wordreal[4] = 'A';
         wordreal[5] = 'L';
         delay_ms(50);
         limpiar_palabra();
         fprintf(TTL, "[B] La palabra que se mostrara en el propeller es: \r\n");
         for(int u=0;u<6;u++)
         {
            fprintf(TTL, "%c", wordreal[u]);
         }
         delay_ms(1000);
         flag = 0;   
      }
      else if(flag == 1 && real == 'C')
      {
         //Cambio de palabra aqui
         //delay_ms(2000);
         delay_ms(1000);
         wordreal[0] = 'M';
         wordreal[1] = 'G';
         wordreal[2] = 'X';
         wordreal[3] = 'M';
         wordreal[4] = 'V';
         delay_ms(50);
         limpiar_palabra();
         fprintf(TTL, "[C] La palabra que se mostrara en el propeller es: \r\n");
         for(int u=0;u<5;u++)
         {
            fprintf(TTL, "%c", wordreal[u]);
         }
         delay_ms(1000);
         flag = 0;   
      }
      
      
   }
    
     
} //Main.

Void Limpiar_palabra()
{
   letter = 0;
}


Void Print()
{
   For(i=0; i<7; i++)
   {
      carac = wordreal[i];
      Switch(carac)
      {
         Case 'A': Case 'a':
         {
            fprintf(TTL, "[A] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_A[j];
               delay_ms(Tiempo);
            }
            //Delay_ms(5);
            Break;
         }
         Case 'B': Case 'b':
         {
            fprintf(TTL, "[B] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_B[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'C': Case 'c':
         {
            fprintf(TTL, "[C] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_C[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'D': Case 'd':
         {
            fprintf(TTL, "[D] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_D[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'E': Case 'e':
         {
            fprintf(TTL, "[E] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_E[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'F': Case 'f':
         {
            fprintf(TTL, "[F] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_F[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'G': Case 'g':
         {
            fprintf(TTL, "[G] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_G[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'H': Case 'h':
         {
            fprintf(TTL, "[H] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_H[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'I': Case 'i':
         {
            fprintf(TTL, "[I] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_I[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'J': Case 'j':
         {
            fprintf(TTL, "[J] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_J[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'K': Case 'k':
         {
            fprintf(TTL, "[K] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_K[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'L': Case 'l':
         {
            fprintf(TTL, "[L] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_L[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'M': Case 'm':
         {
            fprintf(TTL, "[M] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_M[j];
               delay_ms(Tiempo);
            }
            //Delay_ms(5);
            Break;
         }
         Case 'N': Case 'n':
         {
            fprintf(TTL, "[N] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_N[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'O': Case 'o':
         {
            fprintf(TTL, "[O] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_O[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'P': Case 'p':
         {
            fprintf(TTL, "[P] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_P[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'Q': Case 'q':
         {
            fprintf(TTL, "[Q] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_Q[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'R': Case 'r':
         {
            fprintf(TTL, "[R] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_R[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'S': Case 's':
         {
            fprintf(TTL, "[S] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_S[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'T': Case 't':
         {
            fprintf(TTL, "[T] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_T[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'U': Case 'u':
         {
            fprintf(TTL, "[U] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_U[j];
               delay_ms(Tiempo);
            }
            //Delay_ms(5);
            Break;
         }
         Case 'V': Case 'v':
         {
            fprintf(TTL, "[V] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_V[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'W': Case 'w':
         {
            fprintf(TTL, "[W] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_W[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'X': Case 'x':
         {
            fprintf(TTL, "[X] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_X[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'Y': Case 'y':
         {
            fprintf(TTL, "[Y] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_Y[j];
               delay_ms(Tiempo);
            }
            Break;
         }
         Case 'Z': Case 'z':
         {
            fprintf(TTL, "[Z] \r\n");
            for(j=0;j<7;j++)
            {
               PORTD = Letra_Z[j];
               delay_ms(Tiempo);
            }
            Break;
         }
      }//Aquí se cierra el Switch.
      
   } //Aquí se cierra el For.
} //Aquí se cierra la función.


void limpieza(){
   CREN = 0;
   CREN = 1;   

}
