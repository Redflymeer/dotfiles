#!/bin/sh
# IS PROGRAMM DONT USES AI SLOP, ALL MADED BY ME AND https://wiki.alpinelinux.org/wiki READ IS TO EXAMPLES
# By redflymeer

# test
set -e
if [ "$(id -u)" -eq 0 ]; then
  echo "Run as user"
  exit 1
fi

# apk
doas apk add neovim ripgrep fd bash fish flatpak docker lazygit lazydocker \
  doas sway waybar kitty wofi kitty-kitten imagemagick \
  build-base cmake g++ gcc mpv gtkmm4 gtkmm4-dev rofi udiskie udisks2 \
  pipewire wireplumber pipewire-pulse pipewire-jack pipewire-alsa pavucontrol pulseaudio \
  xdg-desktop-portal-wlr \
  bluez bluez-openrc pipewire-spa-bluez blueman

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

# Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak install -y --user com.obsproject.Studio dev.vencord.Vesktop md.obsidian.Obsidian \
  org.keepassxc.KeePassXC com.valvesoftware.Steam
flatpak install -y --system app.zen_browser.Zen

# Docker service
doas addgroup docker 2>/dev/null || true
doas adduser "$(whoami)" docker

doas addgroup input 2>/dev/null || true
doas adduser "$(whoami)" input
