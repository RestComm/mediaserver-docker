FROM java:7-jdk
MAINTAINER gdubina@dataart.com

RUN apt-get update
RUN apt-get install net-tools

ADD https://mobicents.ci.cloudbees.com/view/MediaServer/job/RestComm-MediaServer-4.x/lastSuccessfulBuild/artifact/bootstrap/target/restcomm-media-server.zip /tmp/restcomm-media-server.zip

ADD https://mobicents.ci.cloudbees.com/view/MediaServer/job/RestComm-MediaServer-4.x/lastSuccessfulBuild/artifact/media-version.txt /tmp/media-version.txt

ENV work_dir /opt/restcomm-media-server

RUN mkdir -p $work_dir/recordings && \
    unzip /tmp/restcomm-media-server.zip -d /opt && \
    chmod +x $work_dir/bin/run.sh && \
    rm /tmp/restcomm-media-server.zip && \
    mv /tmp/media-version.txt $work_dir

ADD scripts/configure.sh $work_dir
ADD scripts/run.sh $work_dir

WORKDIR $work_dir
CMD ./run.sh

