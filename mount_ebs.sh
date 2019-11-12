#!/bin/bash
sudo mkfs -t ext4 /dev/xvdg
sudo mkdir /opt/mount1
sudo mount /dev/xvdg /opt/mount1
echo "/dev/xvdg  /opt/mount1 ext4 defaults,nofail 0 2"|sudo tee -a /etc/fstab