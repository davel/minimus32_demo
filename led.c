/* Demo for Minimus 32k. */

#include "avr/io.h"

void PORT_Init()
{
	PORTB = 0b00000000;
	DDRB = 0b00000000;

	PORTC = 0b00000000;
	DDRC = 0b00000000;

	PORTD = 0b00000000;
	DDRD  = 0b01100000;		//set LEDs as output
}

int main(void)
{
	PORT_Init();
	asm("WDR");						//Watchdog Timer Reset
	WDTCSR = 0x00;                  // Disable the watchdog
	WDTCKD = 0x00;                  // No early warnings either

	while (1)
	{
        if (PIND &  0b10000000) {
            PORTD = 0b00100000;
        }
        else {
            PORTD = 0b01000000;
        }
    }
	return 0;
}

