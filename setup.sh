#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "Linux detected."
  sudo apt install gcc-avr avr-libc avrdude

elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "MacOS detected."
  echo "Installing osx-cross/avr..."
  brew tap osx-cross/avr
  brew install avr-gcc

  echo "Installing avrdude..."
  #brew install avrdude --with-usb
  brew install avrdude

  echo "Install complete."
fi



