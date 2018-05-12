#!/bin/sh

if [ "$TOKEN" = "" ]; then
	echo "project configuration is incomplete, you need to set TOKEN variable if you want to trigger nested builds"
	exit 1
fi

curl -X POST -d '{}' https://circleci.com/api/v1.1/project/$1?circle-token=$TOKEN
