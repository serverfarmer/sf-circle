#!/bin/sh

if [ "$HOST" = "" ]; then
	echo "project configuration is incomplete, you need to set at least HOST variable"
	exit 1
fi

if [ "$PORT" = "" ]; then
	PORT="22"
	echo "using default port $PORT (variable PORT not set)"
fi

if [ "$USER" = "" ]; then
	USER="circle"
	echo "using default user \"$USER\" (variable USER not set)"
fi

if [ "$3" != "" ]; then
	key="$3"
else
	key="~/.ssh/id_rsa"
	echo "using $key as default repository key (not set explicitly in config.yml)"
fi

ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey -o IdentitiesOnly=yes -i ~/.ssh/id_rsa_* \
	-p $PORT $USER@$HOST \
	"/opt/farm/ext/circle/remote/pull.sh $1 $2 $key" 2>&1
