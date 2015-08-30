#!/bin/bash
#
# uncomment these lines to use a local mirror
# this sample uses a mirror at "registry.vtg/repos"
# 
# the sed commands below disable "fastestmirror",
# comment out the "mirrorlist" entry,
# uncomments the "baseurl" entry and replaces
# "mirror.centos.org" by "registry.vtg/repos"
#
echo "changing yum repos..."
sed "s/^enabled.*/enabled=0/" -i /etc/yum/pluginconf.d/fastestmirror.conf 
sed "s/^mirrorlist/#mirrorlist/g" -i /etc/yum.repos.d/CentOS-Base.repo
sed "s/^#baseurl/baseurl/g" -i /etc/yum.repos.d/CentOS-Base.repo
sed "s/mirror\.centos\.org/registry\.vtg\/repos/g" -i /etc/yum.repos.d/CentOS-Base.repo
