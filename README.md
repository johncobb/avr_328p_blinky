

![Micro](https://www.elprocus.com/wp-content/uploads/2014/06/410.jpg)

## Building an AVR toolchain from the command line
This project walks you through the process of setting your toolchain to compile/deploy C code for AVR microcontrollers. Today there are many IDEs that magically automate this process for you. These are convenient but obscure much of what is going on behind the scenes from the developer. The key to becoming a better embedded engineer is understanding the toolchain compilation/deployment workflow. When the time comes to take your product to production these scripts will come in handy.


### I'm going to write a great novel
Here is my novel


### Prerequisites:

### Installing avr-gcc

Installing avr-gcc on MacOS w/Brew
```console
brew tap osx-cross/avr
brew install avr-gcc
```
verify installation
```console
avr-gcc --version
```

### Installing Avrdude on MacOS w/Brew
```console
brew install avrdude
or
brew install avrdude --with-usb
```
verify installation
```console
avrdude -v
```

### The code
The code below sets the data direction bit 5 on PORTB to an output. The while loop toggles PORTB bit 5 every 1000 milliseconds indefinitely.
```c++
DDRB |= _BV(PB5);

while (1)
{
    // toggle led
    PORTB ^= _BV(PB5);
    _delay_ms(1000);

}
```
### Compiling Blinky
To compile our source code we want to create a build script to autmoate the process. This script also converts the object files to avr compatible hex format. This hex file is then used to update the code on the microcontroller.

create file: build_script

```console
avr-gcc main.c -g -Os -mmcu=atmega32 -c main.c
avr-gcc -g -mmcu=atmega32 -o main.elf main.o
avr-objcopy -j .text -j .data -O ihex main.elf main.hex
avr-size --format=avr --mcu=atmega32 main.elf
```

set execuite permissions on build_script
```console
sudo chmod 755 build_script
```
 run build_script to compile the code
```console
sudo ./build_script
```

### Using AVRDude to deploy code to microcontroller
The script below assumes the microcontroller enumerates as device /dev/ttyUSB0.

create file: load_script
```console
avrdude -c arduino -p m32 -P /dev/ttyUSB0 -b 19200 -U flash:w:main.hex
```

set execute permissions on load_script
```console
sudo chmod 755 load_script
```
run load_script to upload the code
```console
sudo ./load_script
```

### Moving forward
Ok, we built the toolchain and deployment scripts now its time to use what we will use for production. Makefiles allow us to place all build/clean/flash commands into one simple to use file. Each microcontroller has a unique set of parameters prior to compiling and deploying. These commands are listed a the top of the Make file and are easily changed.

Below is a snippet of Makefile parametes that would be changed to target your project
```console
# parameters (make changes accordingly)
# project name
PRJ = main
# avr mcu
MCU = atmega328p
# mcu clock frequency
CLK = 16000000
# avr programmer (and port if necessary)
# e.g. PRG = usbtiny -or- PRG = arduino -P /dev/tty.usbmodem411
PRG = usbtiny
```

Putting makefile to use::
```console
make clean #cleans up the build folder
make flash #builds the project and programs device
```


#### References:
https://github.com/osx-cross/homebrew-avr

http://www.linuxandubuntu.com/home/setting-up-avr-gcc-toolchain-and-avrdude-to-program-an-avr-development-board-in-ubuntu
