#include <msp430.h> 

/*
 * main.c
 */

int init(void) 
{
    WDTCTL = WDTPW | WDTHOLD;	        // Stop watchdog timer
    P1DIR |= 0x01;
    P4DIR |= 0x80;
    P1OUT = 0x00;
    P4OUT = 0x80;
    
	/* initialize Timer0_A
     * SMCLK = 1.048576MHZ & ACLK = 32768Hz
     * Time period = DIV * (TA0CCR0 + 1) / Input clock in HZ
     * DIV is selected by IDx
     */
    TA0CTL = TASSEL_2 + ID_3 + MC_2; // configure and start timer
    
}

void main( void )
{
  init();

 /* Until TA0R reaches 0x0FFFF While loops then CCIFG will set to 1 : Working for 0.5 seconds */
  for(;;)
    {
  	  while(TA0CCTL0 == 0)
        {
		    //LOOP until TA0R reaches to 0xFFFF and CCIFG set to zero
  	    }
  	  TA0CCTL0 &= ~CCIFG;			// Reset CCIFG flag
  	  //TA0R = 0;
  	  P1OUT ^= 0x01;			    // Toggle P1.0 LED
  	  P4OUT ^= 0x80;			    // Toggle P4.7 LED
    }
}
