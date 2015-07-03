#!/bin/bash

# auto install salt-minion
hostname=`hostname`
yum install salt-minion -y
sed -i 's/^#master: salt*/master: 172.16.6.4/' /etc/salt/minion
sed -i "s/^#id:/id: $hostname/g" /etc/salt/minion
service salt-minion start
