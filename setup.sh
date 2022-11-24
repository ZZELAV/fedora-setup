#!/bin/bash

# DNF Configuration
sudo cp dnf.conf /etc/dnf/dnf.conf

# Update system
sudo dnf update

# RPM Fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core

# Enable flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Change hostname
echo "Choose hostname"
read hostname
sudo hostnamectl set-hostname $hostname

# Audio codecs
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# Change display environment
sudo dnf groupinstall "Cinnamon Desktop"

# Software pre-installation
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf check-update

# Software installation
sudo dnf install vim brave-browser zsh neofetch htop tldr ulauncher docker-ce docker-ce-cli containerd.io docker-compose-plugin discord ranger virt-manager code
sudo flatpak install flathub com.spotify.Client

# Software configuration
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo cp .zshrc ~/

sudo cp -r ulauncher ~/.config

# Custom commands
sudo cp terminal /usr/bin/
sudo chmod +x /usr/bin/terminal

sudo cp shut /usr/bin/
sudo chmod +x /usr/bin/shut

sudo cp logoff /usr/bin/
sudo chmod +x /usr/bin/logoff

sudo cp lock /usr/bin/
sudo chmod +x /usr/bin/lock

sudo cp idle /usr/bin/
sudo chmod +x /usr/bin/idle

# Finalize setup
echo "### Finalize setup ###"
echo "# Cinnamon setup
> Taskbar to top
> Install theme CBlack (System settings)
> Window borders: CBlack
> Icons: Paper-Mono-Dark
> Controls: CBlack
> Mouse pointer: Adwaita
> Desktop: CBlack
> Change background to Blobs
> Disable Desktop icons
> Change taskbar order: Keyboard, Bluetooth, Notifications, Printer, Removable Devices, Battery, Network, Sound, Time
> Configure menu: custom icon > media-record-symbolic (no text)
> Panel height: 22
> Taskbar icon size: 16px
> Terminal: Solarized dark schema"
