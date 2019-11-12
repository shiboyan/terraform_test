#!/bin/bash
# there is a workaround sleep 10s to avoid dpkg lock. this is wired to see '&&' could not ensure the inline shell order. 
sudo apt-get -y update && sleep 10s && sudo apt-get -y install nginx && sleep 10s && sudo service nginx start