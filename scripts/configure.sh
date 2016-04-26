#!/bin/bash

BASE_DIR=$work_dir
CONFIG_FILE=$BASE_DIR/deploy/server-beans.xml

if [ -n "$USE_HOST_NETWORK" ]; then
    LOCAL_IP=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`
    PROPERTY_bindAddress=$LOCAL_IP
    PROPERTY_localBindAddress=$LOCAL_IP
fi

if [ -n "$LOG_LEVEL" ]; then
    sed -i  "s|<param name=\"Threshold\" value=\"INFO\" />|<param name=\"Threshold\" value=\"`echo $LOG_LEVEL`\" />|" $BASE_DIR/conf/log4j.xml
    sed -i  "s|<priority value=\"INFO\"/>|<priority value=\"${LOG_LEVEL}\"/>|" $BASE_DIR/conf/log4j.xml
fi

set_xml_property () {
    local property=$1
    local new_value=$2
    local xml_file=$3
    sed -i "s|<property name=\"$property\">.*</property>|<property name=\"$property\">$new_value</property>|" $xml_file
}

echo "********************************"
echo "***  Configure media server  ***"
echo "********************************"

for i in $( set -o posix ; set | grep ^PROPERTY_ | sort -rn ); do
    reg=$(echo ${i} | cut -d = -f1 | cut -c 10-)
    val=$(echo ${i} | cut -d = -f2)

    echo "Update property: $reg -> $val"

    set_xml_property $reg $val $CONFIG_FILE
done
