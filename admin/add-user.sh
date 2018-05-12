#!/bin/bash

if [ "$1" = "" ]; then
	user="circleci"
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
mkdir -m 0700 $path/.ssh
ssh-keygen -f $path/.ssh/id_rsa -C "$user-upstream" -N ""
cat $path/.ssh/id_rsa.pub >>$path/.ssh/authorized_keys
chown -R $user $path/.ssh

echo
echo "Now paste this key into Circle CI, project configuration, SSH Permissions page:"
cat $path/.ssh/id_rsa

echo
echo "Then paste this key into Bitbucket Access keys page for your repository:"
cat $path/.ssh/id_rsa.pub
