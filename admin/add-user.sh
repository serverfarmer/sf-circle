#!/bin/bash

if [ "$1" = "" ]; then
	user="circle"
elif ! [[ $1 =~ ^[a-z0-9]+$ ]]; then
	echo "invalid user name"
	exit 1
else
	user="$1"
fi

if [ "`getent passwd $user`" != "" ]; then
	echo "$user user already found, exiting"
	exit 0
fi

mkdir -p /data
path="/data/$user"

useradd -m -d $path -G www-data -s /bin/bash $user
ssh-keygen -f $path/.ssh/id_rsa_circle

echo "paste this key into Circle CI, project configuration, SSH Permissions page:"
cat $path/.ssh/id_rsa_circle
cat $path/.ssh/id_rsa_circle.pub >>$path/.ssh/authorized_keys
