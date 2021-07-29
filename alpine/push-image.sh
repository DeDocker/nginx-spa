#!/bin/bash

if [ "$1" = "" ]; then
  echo "Usages:
    $0 [main_tag|dir] [additional_tag]
    $0 1.19 1.19-alpine
    $0 1.21 latest
  "
  exit 0
fi

cd $1
BASEIMAGE="desmart/nginx-spa:"

if [ ! "$2" = "" ]; then
  LATEST="-t ${BASEIMAGE}${2}"
fi

docker build . -f Dockerfile -t ${BASEIMAGE}${1} $LATEST

if [ "$3" = "buildonly" ]; then
  cd ../
  exit 0
fi

docker push ${BASEIMAGE}${1}

if [ ! "$2" = "" ]; then
  docker push ${BASEIMAGE}${2}
fi

cd ../