volatile unsigned int * const UART0DR = (unsigned int *) 0x10009000;
/*for versatilepb 0x101f1000 for vexpress 0x10009000*/

void print_uart0(const char *s)
{
	while(*s!='\0')
	{
		*UART0DR = (unsigned int) (*s);
		s++;
	}
}


void c_entry()
{
	print_uart0("Hello world!!!\n");
}
