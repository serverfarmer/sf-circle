#!/bin/sh

repo=$1
dir=$2
key=$3

if [ "$3" = "" ]; then
	echo "usage: $0 <repository-url> <directory> <key-name>"
	exit 1
elif [ ! -f /etc/local/.ssh/$key ]; then
	echo "git key $key not found"
	exit 1
fi

if [ -d $dir ]; then
	cd $dir
	GIT_SSH=/opt/farm/scripts/git/helper.sh GIT_KEY=/etc/local/.ssh/$key git pull
else
	mkdir -p -m 0711 `dirname $dir`
	GIT_SSH=/opt/farm/scripts/git/helper.sh GIT_KEY=/etc/local/.ssh/$key git clone $repo $dir
fi
