#!/bin/bash

if ! grep -q "deb http://ftp.de.debian.org/debian buster main" /etc/apt/sources.list; then
    echo "deb http://ftp.de.debian.org/debian buster main" | sudo tee -a /etc/apt/sources.list
fi

sudo apt update
sudo apt install -y wget gpg curl build-essential python3 python3-pip python3-venv g++ gcc barrier git apt-transport-https flatpak gnome-software-plugin-flatpak
# add code repository and install vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install -y code
# install brave
curl -fsS https://dl.brave.com/install.sh | sudo bash

# install git lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt install git-lfs

# install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install flatpack packages
sudo flatpak install -y flathub org.videolan.VLC
sudo flatpak install -y flathub io.github.jonmagon.kdiskmark
sudo flatpak install -y flathub com.usebottles.bottles
sudo flatpak install -y flathub net.davidotek.pupgui2
sudo flatpak install -y flathub com.valvesoftware.Steam
sudo flatpak install -y flathub com.heroicgameslauncher.hgl
sudo flatpak install -y flathub md.obsidian.Obsidian
sudo flatpak install -y flathub com.getpostman.Postman
sudo flatpak install -y flathub com.github.tchx84.Flatseal

# Downgrade gnome terminal for transparency
mkdir gnome
cd gnome
wget https://github.com/sean0921/debian-gnome-terminal-transparency/releases/download/debian%2F3.38.3-1sean01/gnome-terminal-data_3.38.3-1sean01_all.deb
wget https://github.com/sean0921/debian-gnome-terminal-transparency/releases/download/debian%2F3.38.3-1sean01/gnome-terminal_3.38.3-1sean01_amd64.deb
wget https://github.com/sean0921/debian-gnome-terminal-transparency/releases/download/debian%2F3.38.3-1sean01/nautilus-extension-gnome-terminal_3.38.3-1sean01_amd64.deb
sudo apt install ./*.deb
sudo apt-mark hold gnome-terminal-data
sudo apt-mark hold gnome-terminal
sudo apt-mark hold nautilus-extension-gnome-terminal
cd ..
rm -rf ./gnome

# softwares
# yarn, npm and nvm
# todo: add check for nvm already existing
if [ -d ~/.nvm ]; then
    echo "nvm already installed"
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    source ~/.bashrc
    nvm install 18
    nvm alias default 18
    nvm use 18
    npm install -g yarn
fi