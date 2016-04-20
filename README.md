# Restcomm MediaServer docker container 

Restcomm mediaserver repo - https://github.com/RestComm/mediaserver

###Supported env variables

1. To modify properties in `server-beans.xml` you can use the following template `PROPERTY_xmlpropname`. **Example:** PROPERTY_lowestPort, PROPERTY_highestPort

2. if you run docker container with `--net=host` you should setup `USE_HOST_NETWORK=true`. in this case mediserver will be bound to `eth0` ip address

3. `LOG_LEVEL` - you can specify log4j log level

### Run command example 

```shell
docker run --net host -d \
  --name restcomm-mediaserver \
  -e PROPERTY_lowestPort=64000 \
  -e PROPERTY_highestPort=65500 \
  -e USE_HOST_NETWORK=true \
  -it restcomm-mediaserver 
```
### Log4j configuration

To override log4j config you can mount own `log4j.xml` file.

```shell
-v $PWD/conf/log4j.xml:/opt/restcomm-media-server/conf/log4j.xml
```