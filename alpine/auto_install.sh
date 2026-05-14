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
# Base
doas apk add neovim ripgrep fd bash fish flatpak docker lazygit lazydocker
# Term + WM + WM Depencies
doas sway waybar kitty wofi kitty-kitten imagemagick waybar
# Coding/extra
build-base cmake g++ gcc mpv gtkmm4 gtkmm4-dev rofi udiskie udisks2
# Sound
pipewire wireplumber pipewire-pulse pipewire-jack pipewire-alsa pavucontrol pulseaudio
# Docker
xdg-desktop-portal-wlr
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
flatpak install -y --user com.obsproject.Studio dev.vencord.Vesktop md.obsidian.Obsidian \
  org.keepassxc.KeePassXC com.valvesoftware.Steam
flatpak install -y --system app.zen_browser.Zen \
  net.sonobux.SonoBus io.github.dimtpap.coppwr io.github.Soundux com.github.wwmm.easyeffects

# Groups
#   Docker
doas addgroup docker 2>/dev/null || true
doas addgroup "$(whoami)" docker

doas addgroup input 2>/dev/null || true
doas addgroup "$(whoami)" input

#   KVM
doas addgroup kvm || true
doas addgroup "$(whoami)" kvm
