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
```
avrdude -c arduino -p m32 -P /dev/ttyUSB0 -b 19200 -U flash:w:main.hex
```


set execute permissions on load_script
```
sudo chmod 755 load_script

```
run load_script to upload the code
```
sudo ./load_script
```



#### References:
https://github.com/osx-cross/homebrew-avr

http://www.linuxandubuntu.com/home/setting-up-avr-gcc-toolchain-and-avrdude-to-program-an-avr-development-board-in-ubuntu