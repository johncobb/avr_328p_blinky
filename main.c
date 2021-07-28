/*
 * main.c
 *
 *  Created on: Sep 11, 2014
 *      Author: jcobb
 */

#define F_CPU	8000000

#include <avr/interrupt.h>
#include <avr/io.h>
#include <util/delay.h>


int main()
{
	DDRB |= _BV(PB5);

	while (1)
	{
		// toggle led
		PORTB ^= _BV(PB5);
		/* _delay_ms(1000); */
		_delay_ms(100);

	}
}
