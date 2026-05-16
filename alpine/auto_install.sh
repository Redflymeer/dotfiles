#!/bin/sh
# IS PROGRAMM DONT USES AI SLOP, ALL MADED BY ME AND https://wiki.alpinelinux.org/wiki READ IS TO EXAMPLES
# By redflymeer

# test
set -e
if [ "$(id -u)" -eq 0 ]; then
  echo "Run as user"
  exit 1
fi

# Apk
# Shell
doas apk add neovim ripgrep fd bash fish flatpak lazygit
# WM + WM Depencies
sway waybar \ 
# Extra
kitty kitty-kitten imagemagick doas udiskie udisks2 mpv nemo wofi rclone wine
# Coding
build-base cmake g++ gcc gtkmm4 gtkmm4-dev
# Sound
pipewire wireplumber pipewire-pulse pipewire-jack
# Docker
xdg-desktop-portal-wlr docker lazydocker xhost xdg-utils
# Bluetooth
bluez bluez-openrc pipewire-spa-bluez blueman
# Silent SDDM
qt6-qtsvg qt6-qtbase qt6-qtvirtualkeyboard qt6-qtmultimedia qt6-qtmultimedia-ffmpeg
# VM
virt-manager qemu qemu-img qemu-x86_64 qemu-storage-daemon qemu-ui-gtk libvirt libvirt-daemon libvirt-daemon-openrc \
  libvirt-qemu libvirt-common-drivers

# Openrc service
# Pipewire / Wirepliumber
doas rc-service -U pipewire start
doas rc-service -U wireplumber start
doas rc-update -U add pipewire gui
doas rc-update -U add wireplumber gui
# sddm
doas rc-update add sddm
# Bluetooth
doas rc-update add bluetooth
#doas rc-service bluetooth start
# Libvirt
doas rc-update add libvirtd
#doas reboot

# Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak install -y --user com.obsproject.Studio md.obsidian.Obsidian \
  org.keepassxc.KeePassXC com.valvesoftware.Steam app.zen_browser.Zen
flatpak install -y --system net.sonobux.SonoBus io.github.dimtpap.coppwr \ 
io.github.Soundux com.github.wwmm.easyeffects org.bleachbit.Bleachbit

flatpak override --filesystem=/home/ app.zen_browser.Zen
flatpak override --filesystem=/home/ com.obsproject.Studio
flatpak override --filesystem=/home/ org.bleachbit.Bleachbit
flatpak override --filesystem=/home/ md.obsidian.Obsidian
flatpak override --filesystem=/home/ com.valvesoftware.Steam

# Groups
# Docker
doas addgroup docker 2>/dev/null || true
doas addgroup "$(whoami)" docker

doas addgroup input 2>/dev/null || true
doas addgroup "$(whoami)" input

#   KVM
doas addgroup kvm || true
doas addgroup "$(whoami)" kvm
