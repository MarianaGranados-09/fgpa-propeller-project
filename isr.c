#Include <18F4550.h>
#Fuses INTRC,NOPROTECT, NOWDT, CPUDIV1, PLL1
#Use Delay(Clock=8M)

#use rs232(rcv=pin_C7, xmit=pin_C6, baud=9600, bits=8, parity=n, stream = BTH)

int flag_ext = 0;
int flag_rda = 0;

#int_ext
void isr_ext()
{
   flag_ext = 1;
}

#int_rda
void isr_rda()
{
  flag_rda = 1;
}

void main()
{  
   enable_interrupts(GLOBAL);
   enable_interrupts(int_ext);
   enable_interrupts(int_rda);
   delay_ms(100);
   while(TRUE)
   {
      if(flag_ext == 1)
      {
         output_high(pin_d7);
         delay_ms(500);
         flag_ext = 0;
      }
      if(flag_rda == 1)
      {
         output_high(pin_d6);
         delay_ms(500);
         flag_rda = 0;
      }
   
   }

}
