#!/bin/bash
sudo apt -y install linux-headers-$(uname -r) build-essential libglvnd-dev pkg-config
sudo rm /etc/modprobe.d/blacklist-nouveau.conf
sudo bash -c "echo 'blacklist nouveau' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo bash -c "echo 'options nouveau modeset=0' >> /etc/modprobe.d/blacklist-nouveau.conf"
sudo update-initramfs -u
sudo systemctl set-default multi-user.target
sudo reboot
