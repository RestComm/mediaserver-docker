#!/bin/bash

docker rm -f restcomm-mediaserver

docker run --net host -d \
  --name restcomm-mediaserver \
  -e PROPERTY_media_lowestPort=64000 \
  -e PROPERTY_media_highestPort=65500 \
  -e USE_HOST_NETWORK=true \
  -e RESOURCE_recorder=0 \
  -e RESOURCE_dtmfDetector=0 \
  -e RESOURCE_dtmfGenerator=0 \
  -e LOG_LEVEL=WARN \
  -it restcomm-mediaserver 
