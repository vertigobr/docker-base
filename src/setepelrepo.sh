#!/bin/bash
#
# uncomment these lines to use a local mirror
# this sample uses a mirror at "registry.vtg/repos"
# 
# the sed commands below comment out the "mirrorlist" entry,
# uncomments the first "baseurl" entry and replaces
# the first "mirror.centos.org" by "registry.vtg/repos"
#
# this script assumes that the "epel" repo is the first
# entry at "/etc/yum.repos.d/epel.repo"
#
echo "changing yum epel repo..."
sed "s/^mirrorlist/#mirrorlist/g" -i /etc/yum.repos.d/epel.repo
# using sed to replace first ocurrence only
sed "0,/^#baseurl/s//baseurl/" -i /etc/yum.repos.d/epel.repo
sed "0,/download\.fedoraproject\.org\/pub\/epel\/7\/$basearch/s//registry\.vtg\/repos\/epel\/7\//" -i /etc/yum.repos.d/epel.repo
