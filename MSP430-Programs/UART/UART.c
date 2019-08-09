#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	        // stop watchdog timer
	
	char test[] = "Test UART\n";
	volatile char i = 0;

	P4SEL |= 0x30;                      // Enable Rx and Tx, P4.5 and P4.4

	UCA1CTL1 |= UCSWRST;
	UCA1CTL1 |= UCSSEL_1;               // SMCLK
	UCA1BR0 = 0x03;                     // 1MHz 9600
	UCA1BR1 = 0x00;
	UCA1MCTL = 0x06;                    // modulation
	UCA1CTL0 = 0x00;
	UCA1CTL1 &= ~UCSWRST;               // Initialize USCI state machine

	while(1)
	{
	    i = 0;
	    while(test[i] != '\0')
	    {
	        UCA1TXBUF = test[i];        // load to buffer
	        while(UCA1STAT & UCBUSY);   // wait for transmission
	        i++;
	    }

	    UCA1TXBUF = 0x0a;
	    while(UCA1STAT & UCBUSY);       // Terminate transmission
	    UCA1TXBUF = 0x0d;
	    while(UCA1STAT & UCBUSY);
	}

	return 0;
}

