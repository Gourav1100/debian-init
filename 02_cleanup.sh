#!/bin/bash

sudo apt remove -y --purge firefox-*
sudo apt remove -y --purge gnome-games gnome-maps gnome-music gnome-weather gnome-contacts
sudo apt remove -y --purge libreoffice-*
sudo apt remove -y --purge evolution

sudo apt autoremove -y
sudo apt autoclean
