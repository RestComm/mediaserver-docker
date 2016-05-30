export work_dir=$PWD/tests/restcomm-media-server

mkdir -p $work_dir/conf
wget -O $work_dir/conf/mediaserver.xml https://raw.githubusercontent.com/RestComm/mediaserver/issue70/bootstrap/src/main/config/mediaserver.xml
wget -O $work_dir/conf/log4j.xml https://raw.githubusercontent.com/RestComm/mediaserver/master/bootstrap/src/main/config/log4j.xml

export USE_HOST_NETWORK=true

export LOG_LEVEL=SUPER_INFO

export PROPERTY_network_externalAddress=111.111.222.222
export PROPERTY_media_lowPort=64000
export PROPERTY_media_highPort=65500

export RESOURCE_localConnection=100
export RESOURCE_dtmfDetector=0
export RESOURCE_dtmfGenerator=0
export RESOURCE_recorder=0
export RESOURCE_remoteConnection=200
export RESOURCE_localConnection=200

./scripts/configure.sh
