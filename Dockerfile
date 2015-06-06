# Base CentOS 7 with a few perks
# Includes epel repo

FROM centos:latest

MAINTAINER Andre Fernandes <andre@vertigo.com.br>

ADD src/* /opt/

RUN chmod +x /opt/*.sh && \
    /opt/setbaserepo.sh && \
    yum update -y && \
    yum install net-tools iputils tar wget unzip epel-release -y && \
    /opt/setepelrepo.sh && \
    yum -y install pwgen && \
    yum clean all

# RUN yum -y install pwgen && yum clean all
