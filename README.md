# Mark3-Repo Docker Environment

This project contains Docker scripts to create a clean mark3-repo build environment in an Ubuntu container.

## Prerequisites

- Docker running on a node capable of hosting an Ubuntu container
- Access to the open internet to download and configure the container

## Building The Container

With this project checked out, the environment can be built by running the following command:

```
$ docker build -t m3-docker .
```

Once the container has been successfully built, the container can be run interactively using the following command:

```
$ docker run -ti m3-docker
```

## Building Mark3

The mark3-repo project is instantiated at /opt/m3-repo.  From here, the regular instructions from mark3-repo can be used to build mark3 for any of the targets supported from the container's interactive session. 

As an example, the following command sequence will build all projects and documentation in mark3-repo for an Atmel atmega1284p MCU:

```
$ cd /opt/m3-repo
$ . ./build/set_target.sh avr atmega1284p gcc
$ cd ./out/avr_atmega1284p_gcc
$ ninja
```

## Running Unit Tests

From within the contain, run `/etc/m3_build_and_test.sh` to build Mark3 against the default atmega1284p target.  This also builds and installs the flAVR AVR simulator if necessary (also included as a source repo within mark3-repo), which it then uses to run the unit tests.  Test ouputs are written to the terminal.


