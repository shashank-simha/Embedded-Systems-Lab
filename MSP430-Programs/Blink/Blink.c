#include <msp430.h> 

/*
 * main.c
 */

int main(void) 
{
    WDTCTL = WDTPW | WDTHOLD;	        // Stop watchdog timer
  
    /* We do that by writing a 1 on the PIN7 bit of the P4DIR register 
     P4DIR = <PIN7><PIN6><PIN5><PIN4><PIN3><PIN2><PIN1><PIN0>
     P4DIR to 1000 0000  that is
     P4DIR = 0x80 <-- this is the hexadecimal conversion of 0000 0001
     */
   
   P4DIR |= 0x80;			            // Set P4.7 to output direction
    					

   for(;;) 
   {
    		volatile unsigned int i;	// volatile to prevent optimization

    		P4OUT ^= 0x80;		        // Toggle P4.7 using exclusive-OR 

    		i = 10000;					// SW Delay
    		do i--;
    		while(i != 0);
    }
	
    return 0;
}
