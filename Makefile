all: led.hex led.epp led.lss

## Intel Hex file production flags
HEX_FLASH_FLAGS = -R .eeprom -O ihex

HEX_EEPROM_FLAGS = -j .eeprom
HEX_EEPROM_FLAGS += --set-section-flags=.eeprom="alloc,load"
HEX_EEPROM_FLAGS += --change-section-lma .eeprom=0 --no-change-warnings


led.o: led.c
	avr-gcc -O -Wall -mcall-prologues -mmcu=atmega32u2 led.c -o led.o

led.hex: led.o
	avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

led.epp: led.o
	avr-objcopy $(HEX_EEPROM_FLAGS) -O ihex $< $@ || exit 0

led.lss: led.o
	avr-objdump -h -S $< > $@

upload: led.hex
	dfu-programmer atmega32u2 erase
	dfu-programmer atmega32u2 flash led.hex
	dfu-programmer atmega32u2 start
