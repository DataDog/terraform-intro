#!/bin/bash
sudo yum install nginx -y
sudo chkconfig nginx on
sudo service nginx start
sudo service iptables stop
sudo chkconfig iptables off
