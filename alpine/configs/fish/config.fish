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
xhost +SI:localuser:root >/dev/null
alias mc="~/.local/bin/minecraft"
alias mc-del="docker stop PineconeMC >/dev/null ; docker rm PineconeMC >/dev/null"
alias ladoc="lazydocker"
alias dock-bld="docker build -t "
alias dock-bld-nch="docker build --no-cache -t "

# CMake
alias cmk-cmp="cmake -B build -G Ninja"
alias cmk-bld="cmake --build build"

# My
alias n="nvim"
alias auu="doas apk update; doas apk upgrade"
alias fu="flatpak update"
alias sudo="doas"
fish_add_path ~/.npm-global/bin
fish_add_path ~/.npm-global/bin
fish_add_path ~/.cargo/bin
