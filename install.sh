#!/bin/bash

# auto install salt-minion
hostname=`hostname`
yum install salt-minion -y
sed -i "s/^#master: salt*/master: $1/" /etc/salt/minion
sed -i "s/^#id:/id: $hostname/g" /etc/salt/minion
service salt-minion start
