#!/bin/bash

cd /opt/m3-repo

## In order to run virtualized tests for AVR targets, we need to have flAVR installed.
## The source for flAVR is part of the mark3-repo project, but is not built since it's a
## host-side utility.  Build and install it explicitly here.
HAS_FLAVR=$(which flavr)
if [ "${HAS_FLAVR}" == "" ]; then
	cd ./tools/flavr
	make emulator
	cp ./flavr /usr/sbin
	cd ../..
fi

## Configure the build for atmega1284p (the Mark3 reference platform)
. ./build/set_target.sh avr atmega1284p gcc
if [ ! -d "/opt/m3-repo/out/avr_atmega1284p_gcc" ]; then
	echo "Configuration failed -- bailing"
	exit -1
fi

## Build all targets for atmega1284p (mark3 + bsp + libs + examples + unit tests + documentation)
cd /opt/m3-repo/out/avr_atmega1284p_gcc
ninja

## Unit tests all start with "ut_" -- find and run all unit tests using flAVR
find -name "ut_*.elf" -exec flavr --exitreset --variant atmega1284p --silent --elffile {} \;

