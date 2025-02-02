#!/bin/bash
user=$(whoami)

# add check for user already exisiting
echo "Adding $user to sudoers"
command="echo '$user	ALL=(ALL:ALL) ALL' >> /etc/sudoers"
su -c "$command" root
echo "Testing sudo for $user"
sudo apt update
sudo apt upgrade

