# Base CentOS 7 with a few perks
# Includes epel repo

FROM centos:latest

MAINTAINER Andre Fernandes <andre@vertigo.com.br>

RUN yum update -y && \
    yum install net-tools iputils tar wget unzip epel-release -y && \
    yum -y install pwgen && \
    yum clean all

# RUN yum -y install pwgen && yum clean all

