all: avr-usb-162_Led.hex avr-usb-162_Led.epp avr-usb-162_Led.lss



## Intel Hex file production flags
HEX_FLASH_FLAGS = -R .eeprom -O ihex

HEX_EEPROM_FLAGS = -j .eeprom
HEX_EEPROM_FLAGS += --set-section-flags=.eeprom="alloc,load"
HEX_EEPROM_FLAGS += --change-section-lma .eeprom=0 --no-change-warnings


avr-usb-162_Led.o: avr-usb-162_Led.c
	avr-gcc -O -Wall -mcall-prologues -mmcu=atmega32u2 avr-usb-162_Led.c -o avr-usb-162_Led.o

avr-usb-162_Led.hex: avr-usb-162_Led.o
	avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

avr-usb-162_Led.epp: avr-usb-162_Led.o
	avr-objcopy $(HEX_EEPROM_FLAGS) -O ihex $< $@ || exit 0

avr-usb-162_Led.lss: avr-usb-162_Led.o
	avr-objdump -h -S $< > $@

upload: avr-usb-162_Led.hex
	dfu-programmer atmega32u2 erase
	dfu-programmer atmega32u2 flash avr-usb-162_Led.hex
	dfu-programmer atmega32u2 start
