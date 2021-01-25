############################################################
# Dockerfile to build ubunto ssh container images
# Based on Ubuntu
############################################################

FROM ubuntu:16.04

MAINTAINER liuby

ENV TZ Asia/Shanghai
ENV LANG zh_CN.UTF-8

RUN sed -i 's#http://archive.ubuntu.com/#http://cn.archive.ubuntu.com/#' /etc/apt/sources.list

RUN apt-get update && \
apt-get -y install vim && \
apt-get -y install openssh-server && \
apt-get clean && \
rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /var/run/sshd

EXPOSE 22

#Start ssh Service
CMD ["/usr/sbin/sshd", "-D"]
