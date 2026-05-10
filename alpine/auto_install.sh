#!/bin/sh
# test
set -e
if [ "$(id -u)" -eq 0 ]; then
  echo "Run as user"
  exit 1
fi

# apk
doas apk add neovim ripgrep zsh bash fish flatpak docker lazygit lazydocker \
  doas sway waybar pulseaudio pipewire kitty kitty-kitten imagemagick \
  build-base cmake g++ gcc mpv gtkmm4 gtkmm4-dev rofi udiskie udisks2

# Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak install -y --user app.zen_browser.zen com.obsproject.Studio dev.vencord.Vesktop md.obsidian.Obsidian \
  org.keepassxc.KeePassXC

doas addgroup docker 2>/dev/null || true
doas adduser "$(whoami)" docker

doas addgroup input 2>/dev/null || true
doas adduser "$(whoami)" input
