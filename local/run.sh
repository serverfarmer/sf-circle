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
	USER="circleci"
	echo "using default user \"$USER\" (variable USER not set)"
fi

ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey -o IdentitiesOnly=yes -i ~/.ssh/id_rsa_* \
	-p $PORT $USER@$HOST \
	"$@" 2>&1
