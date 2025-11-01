#!/usr/bin/env bash
set -e

echo ">>> Building and installing yay from AUR"
mkdir -p /tmp/funtux && cd /tmp/funtux
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm

echo ">>> yay installation is done!"
