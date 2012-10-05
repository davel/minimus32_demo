/*	Sample program for Olimex AVR-USB-162 with AT90USB162 processor
 *	Blinks the led using a simple delay loop.
 *	Compile with AVRStudio+WinAVR (gcc version 3.4.6)
 */

#include "avr/io.h"

void PORT_Init()
{
	PORTB = 0b00000000;
	DDRB = 0b00000000;

	PORTC = 0b00000000;
	DDRC = 0b00000000;

	PORTD = 0b00000000;
	DDRD = 0b00010000;		//set led as output
}

int i;

int main(void)
{	
	PORT_Init();
	asm("WDR");						//Watchdog Timer Reset
	MCUSR= ~(1<<WDRF);
	WDTCSR = (1<<WDCE) | (1<<WDE);
	WDTCSR = 0x00;
	WDTCKD = 0x00;

	while (1)
	{
		PORTD = PORTD | 0b00010000;
		for (i = 5000; i; i--);
		
		PORTD = PORTD & 0b11101111;
		for (i = 5000; i; i--);
	}
	return 0;
}

