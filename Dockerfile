FROM ubuntu

### Install dependencies
RUN apt-get update && apt-get install -y \
	build-essential \
	clang \
	clang-format \
	avr-libc \
	gcc-avr \
	binutils-avr \
	gcc-arm-none-eabi \
	binutils-arm-none-eabi \
	gcc-msp430 \
	binutils-msp430 \
	cmake \
	ninja-build \
	doxygen	\
	git \
	curl \
	wget 

### Generate a unique ssh key for this node
RUN mkdir /root/.ssh
RUN ssh-keygen -f /root/.ssh/id_rsa -N ""

### Create necessary paths
RUN mkdir /root/bin

### Run script to initialize the mark3-repo environment and download source
ADD m3_repo_config.sh /etc/m3_repo_config.sh
RUN chmod a+x /etc/m3_repo_config.sh
RUN /etc/m3_repo_config.sh

### Add script to update the repo environment on each invocation of the container
ADD m3_repo_sync.sh /etc/m3_repo_sync.sh
RUN chmod a+x /etc/m3_repo_sync.sh
CMD /etc/m3_repo_sync.sh && /bin/bash

### Add script to build + run all tests for default target
ADD m3_build_and_test.sh /etc/m3_build_and_test.sh
RUN chmod a+x /etc/m3_build_and_test.sh

