# Restcomm MediaServer docker container 
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bhttps%3A%2F%2Fgithub.com%2FRestComm%2Fmediaserver-docker.svg?type=shield)](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2FRestComm%2Fmediaserver-docker?ref=badge_shield)


Restcomm mediaserver repo - https://github.com/RestComm/mediaserver

###Supported env variables

1. To modify properties in `server-beans.xml` you can use the following template `PROPERTY_<xmlresource>_<propname>`. **Example:** `PROPERTY_media_lowestPort`, `PROPERTY_media_highestPort`

2. if you run docker container with `--net=host` you should setup `USE_HOST_NETWORK=true`. in this case mediserver will be bound to `eth0` ip address

3. `LOG_LEVEL` - you can specify log4j log level

4. To modify resource pool size you can use the following template `RESOURCE_<recourcename>`. **Example:** `RESOURCE_dtmfDetector`, `RESOURCE_recorder`

### Run command example 

```shell
docker run --net host -d \
  --name restcomm-mediaserver \
  -e PROPERTY_media_lowestPort=64000 \
  -e PROPERTY_media_highestPort=65500 \
  -e USE_HOST_NETWORK=true \
  -it restcomm-mediaserver 
```
### Log4j configuration

To override log4j config you can mount own `log4j.xml` file.

```shell
-v $PWD/conf/log4j.xml:/opt/restcomm-media-server/conf/log4j.xml
```

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bhttps%3A%2F%2Fgithub.com%2FRestComm%2Fmediaserver-docker.svg?type=large)](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2FRestComm%2Fmediaserver-docker?ref=badge_large)