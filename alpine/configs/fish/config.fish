if status is-interactive
    # Commands to run in interactive sessions can go here
end


# Udiskctl
alias mant="doas udiskctl -b /dev/sdb1"

# git
alias g="git"
alias gs="git status"
alias gc="git commit"
alias gpsh="git push"
alias gpll="git pull"
alias lgit="lazygit"

# Docker
xhost +local:docker
alias mc="~/.local/bin/mc"
alias mcds="doc stop mc; doc rm mc"
alias ldoc="lazydocker"

# CMake
alias cmk-cmp="cmake -B build -G Ninja"
alias cmk-bld="cmake --build build"


# My
alias n="nvim"
alias auu="doas apk update; doas apk upgrade"
alias fu="flatpak update"
alias sudo="doas"
alias doc="docker"
