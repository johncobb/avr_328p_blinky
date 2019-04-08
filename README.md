## Running Blinky

This project walks you through the process of setting your toolchain to compile/deploy C code for AVR microcontrollers. Today there are many IDEs that magically automate this process for you. These are convenient but obscure much of what is going on behind the scenes from the developer. The key to becoming a better embedded engineer is understanding the toolchain compilation/deployment workflow. When the time comes to take your product to production these scripts will come in handy.

### Prerequisites:

### Installing avr-gcc

Installing avr-gcc on MacOS w/Brew
```console
brew tap osx-cross/avr
brew install avr-gcc

# verify installation
avr-gcc --version

brew install avrdude
or
brew install avrdude --with-usb

# verify install
avrdude -v
```

### Compiling Blinky
```console

create new file: build_script

avr-gcc main.c -g -Os -mmcu=atmega32 -c main.c
avr-gcc -g -mmcu=atmega32 -o main.elf main.o
avr-objcopy -j .text -j .data -O ihex main.elf main.hex
avr-size --format=avr --mcu=atmega32 main.elf

# set execute permissions build_script
sudo chmod 755 build_script
# run the script
sudo ./build_script
```

### Using AVRDude to deploy code to microcontroller
The script below assumes the microcontroller enumerates as device /dev/ttyUSB0.

```
create new file: load_script

avrdude -c arduino -p m32 -P /dev/ttyUSB0 -b 19200 -U flash:w:main.hex

# set execute permissions on load_script
sudo chmod 755 load_script
# run the script
sudo ./load_script
```



#### References:
https://github.com/osx-cross/homebrew-avr

http://www.linuxandubuntu.com/home/setting-up-avr-gcc-toolchain-and-avrdude-to-program-an-avr-development-board-in-ubuntu