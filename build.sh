#!/bin/bash

docker build -t restcomm-mediaserver .

VERSION=`curl -s https://mobicents.ci.cloudbees.com/view/MediaServer/job/RestComm-MediaServer-4.x/lastSuccessfulBuild/artifact/media-version.txt`
echo "MediaServer build version: $VERSION"

docker tag -f restcomm-mediaserver:latest restcomm-mediaserver:$VERSION

