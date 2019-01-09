#!/bin/bash

export PATH=$PATH:/root/bin

if [ ! -x "/root/bin/repo" ]; then
	curl https://storage.googleapis.com/git-repo-downloads/repo > /root/bin/repo
	chmod a+x /root/bin/repo
fi

if [ ! -d "/opt/m3-repo" ]; then
	mkdir /opt/m3-repo
fi

cd /opt/m3-repo

git config --global user.name "mark3-docker"
git config --global user.email "no-reply@mark3os.com"
git config color.ui false

repo init -u https://www.github.com/moslevin/mark3-repo --no-clone-bundle
repo sync --no-clone-bundle
