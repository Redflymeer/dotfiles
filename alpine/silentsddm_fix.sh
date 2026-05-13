#!/usr/bi9
echo "RUN AS ROOT!"

green='\033[0;32m'
red='\033[0;31m'
bred='\033[1;31m'
cyan='\033[0;36m'
grey='\033[2;37m'
reset="\033[0m"

SHPATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
: ${THEMES_DIR:=/usr/share/sddm/themes}

install_dependencies() {
  if command -v apk &>/dev/null; then
    echo -e "${grey}Installing dependencies with 'apk'...${reset}"
    apk add sddm qt6-base qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia-ffmpeg qt6-qtmultimedia
  else
    echo -e "\n${red}Could not install dependencies!\nDo it manually: ${cyan}https://github.com/uiriansan/SilentSDDM/wiki#dependencies${reset}\n"
    return 1
  fi
}

copy_files() {
  echo -e "${grey}Copying files from '${SHPATH}/' to '${THEMES_DIR}/silent/'...${reset}"
  mkdir -p ${THEMES_DIR}/silent
  cp -rf "$SHPATH"/. ${THEMES_DIR}/silent/
}

copy_fonts() {
  echo -e "${grey}Copying fonts to '/usr/share/fonts/'...${reset}"
  cp -r ${THEMES_DIR}/silent/fonts/{redhat,redhat-vf} /usr/share/fonts/
}

apply_theme() {
  echo -e "${grey}Editing '/etc/sddm.conf'...${reset}"
  if [[ -f /etc/sddm.conf ]]; then
    cp -f /etc/sddm.conf /etc/sddm.conf.bkp
    echo -e "${green}Backup for SDDM config saved in '/etc/sddm.conf.bkp'${reset}"

    if grep -Pzq '\[Theme\]\nCurrent=' /etc/sddm.conf; then
      sed -i '/^\[Theme\]$/{N;s/\(Current=\).*/\1silent/;}' /etc/sddm.conf
    else
      echo -e "\n[Theme]\nCurrent=silent" | tee -a /etc/sddm.conf
    fi

    if ! grep -Pzq 'InputMethod=qtvirtualkeyboard' /etc/sddm.conf; then
      echo -e "\n[General]\nInputMethod=qtvirtualkeyboard" | tee -a /etc/sddm.conf
    fi

    # "InputMethod" was supposed to automatically set "QT_IM_MODULE", but it doesn't, so we manually export it.
    if ! grep -Pzq 'GreeterEnvironment=QML2_IMPORT_PATH=${THEMES_DIR}/silent/components/,QT_IM_MODULE=qtvirtualkeyboard' /etc/sddm.conf; then
      echo -e "\n[General]\nGreeterEnvironment=QML2_IMPORT_PATH=${THEMES_DIR}/silent/components/,QT_IM_MODULE=qtvirtualkeyboard" | tee -a /etc/sddm.conf
    fi
  else
    echo -e "[Theme]\nCurrent=silent" | tee -a /etc/sddm.conf
    echo -e "\n[General]\nInputMethod=qtvirtualkeyboard" | tee -a /etc/sddm.conf
    echo -e "GreeterEnvironment=QML2_IMPORT_PATH=${THEMES_DIR}/silent/components/,QT_IM_MODULE=qtvirtualkeyboard" | tee -a /etc/sddm.conf
  fi
}

install_dependencies
copy_files &&
  copy_fonts
apply_theme &&
  echo -e "\n${green} Theme successfully installed!${reset}"
