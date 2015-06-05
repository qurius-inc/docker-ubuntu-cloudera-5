FROM ubuntu:trusty 
MAINTAINER Qurius-inc

#install and start ntp
RUN apt-get -y install ntp ntpdate ntp-doc
RUN ntpdate pool.ntp.org

#oracle java jdk8
RUN apt-get update
RUN apt-get install -y wget python
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen   true | debconf-set-selections
RUN apt-get install -y oracle-java8-installer

#setup the cloudera repo
RUN wget http://archive.cloudera.com/cm5/ubuntu/trusty/amd64/cm/cloudera.list --output-document=/etc/apt/sources.list.d/cloudera.list
RUN apt-get update
RUN apt-get -y --force-yes install cloudera-manager-agent cloudera-manager-daemons

#make the directories
RUN groupadd hadoop
RUN useradd -g hadoop hdfs 

RUN mkdir /var/cm
RUN chmod -R 764 /var/cm

ADD scripts/start.sh /root/start.sh
RUN chmod +x /root/start.sh

EXPOSE 22 2181 7180 7182 50010 50075 50020 8020 50070 50090 8032 8030 8031 8033 8088 8888 8040 8042 8041 10020 19888 41370 38319 10000 21050 25000 25010 25020 18080 18081 7077 7078 9000 9001

CMD /root/start.sh

