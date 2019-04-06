## Running Blinky


### Prerequisites:

#### Installing avr-gcc

Installing avr-gcc on MacOS w/Brew
```console
brew tap osx-cross/avr
brew install avr-gcc

# verify installation
avr-gcc --version

brew install avrdude
or
brew instlal avrdude --with-usb

# verify install
avrdude -v
```

### Compiling Blinky
```console

create new script:

avr-gcc main.c -g -Os -mmcu=atmega32 -c main.c
avr-gcc -gt -mmcu=atmega32 -o main.elf main.o
avr-objcopy -j .text -j .data -O ihex main.elf main.hex
avr-size --format=avr --mcu=atmega32 main.elf

sudo chmod 755 compile build_script
sudo ./build_script
```



#### References:
https://github.com/osx-cross/homebrew-avr

http://www.linuxandubuntu.com/home/setting-up-avr-gcc-toolchain-and-avrdude-to-program-an-avr-development-board-in-ubuntu