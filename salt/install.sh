#!/bin/bash

# auto install salt-minion
rpm -Uvh http://ftp.linux.ncsu.edu/pub/epel/6/i386/epel-release-6-8.noarch.rpm
hostname=`hostname`
yum install salt-minion -y
sed -i "s/^#master: salt*/ master: $1/" /etc/salt/minion
sed -i "s/^#id:/ id: $hostname/g" /etc/salt/minion
service salt-minion start
