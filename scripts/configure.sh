#!/bin/bash

set -x 

BASE_DIR=$work_dir
CONFIG_FILE=$BASE_DIR/conf/mediaserver.xml

if [ -n "$USE_HOST_NETWORK" ]; then
    LOCAL_IP=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`
    PROPERTY_network_bindAddress=$LOCAL_IP
    PROPERTY_network_network=$LOCAL_IP
    PROPERTY_network_subnet=`ifconfig eth0 | grep "inet addr:" | cut -d ':' -f 4`
    PROPERTY_controller_address=$LOCAL_IP
fi

if [ -n "${AMAZON_EC2}" ] && [ -z "${PROPERTY_externalAddress}" ]; then
    echo "Get real public ip for Amazon"
    # http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html
    PROPERTY_network_externalAddress=`curl -s -m 5 http://169.254.169.254/latest/meta-data/public-ipv4`
    if [[ "$PROPERTY_externalAddress" == *"404 Not Found"* ]]
    then
        PROPERTY_network_externalAddress=""
    fi
fi

if [ -n "$LOG_LEVEL" ]; then
    xml_file=$BASE_DIR/conf/log4j.xml
    xml ed -u "//param[@name='Threshold']/@value" -v "$LOG_LEVEL" $xml_file > $xml_file.1
    mv $xml_file.1 $xml_file
    
    xml ed -u "//priority/@value" -v "$LOG_LEVEL" $xml_file > $xml_file.1
    mv $xml_file.1 $xml_file
fi

set_xml_property () {
    local block=$1
    local property=$2
    local new_value=$3
    local xml_file=$4

    xml ed -u "//$block/$property" -v "$new_value" $xml_file > $xml_file.1
    mv $xml_file.1 $xml_file
}

set_pool_size () {
    local property=$1
    local new_value=$2
    local xml_file=$3
    xml ed -u "//$property/@poolSize" -v "$new_value" $xml_file > $xml_file.1
    mv $xml_file.1 $xml_file
}

echo "********************************"
echo "***  Configure media server  ***"
echo "********************************"

for i in $( set -o posix ; set | grep ^PROPERTY_ | sort -rn ); do
    key=$(echo ${i} | cut -d = -f1 | cut -c 10-)
    block=$(echo ${key} | cut -d _ -f1)
    prop=$(echo ${key} | cut -d _ -f2)
    val=$(echo ${i} | cut -d = -f2)

    echo "Update property: $block/$prop -> $val"

    set_xml_property $block $prop $val $CONFIG_FILE
done

for i in $( set -o posix ; set | grep ^RESOURCE_ | sort -rn ); do
    reg=$(echo ${i} | cut -d = -f1 | cut -c 10-)
    val=$(echo ${i} | cut -d = -f2)

    echo "Update resources pool size: $reg -> $val"

    set_pool_size $reg $val $CONFIG_FILE
done
