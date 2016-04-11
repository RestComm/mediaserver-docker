#!/bin/bash

docker rm -f restcomm-mediaserver

docker run --net host -d \
  --name restcomm-mediaserver \
  -e PROPERTY_lowestPort=64000 \
  -e PROPERTY_highestPort=65500 \
  -e USE_HOST_NETWORK=true \
  -it restcomm-mediaserver 
