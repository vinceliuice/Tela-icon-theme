#!/bin/bash

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.local/share/icons"
fi

SRC_DIR=$(cd $(dirname $0) && pwd)

THEME_NAME=Tela
COLOR_VARIANTS=('' '-red' '-pink' '-purple' '-blue' '-green' '-yellow' '-orange' '-brown' '-grey' '-black' '-manjaro' '-ubuntu')
BRIGHT_VARIANTS=('' '-Dark')

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-d, --dest DIR" "Specify theme destination directory (Default: ${DEST_DIR})"
  printf "  %-25s%s\n" "-n, --name NAME" "Specify theme name (Default: ${THEME_NAME})"
  printf "  %-25s%s\n" "-all" "install all color folder versions"
  printf "  %-25s%s\n" "-manjaro" "Manjaro default color folder version"
  printf "  %-25s%s\n" "-ubuntu" "Ubuntu default color folder version"
  printf "  %-25s%s\n" "-red" "Red color folder version"
  printf "  %-25s%s\n" "-pink" "Pink color folder version"
  printf "  %-25s%s\n" "-purple" "Purple color folder version"
  printf "  %-25s%s\n" "-blue" "Blue color folder version"
  printf "  %-25s%s\n" "-green" "Green color folder version"
  printf "  %-25s%s\n" "-yellow" "Yellow color folder version"
  printf "  %-25s%s\n" "-orange" "Orange color folder version"
  printf "  %-25s%s\n" "-brown" "Brown color folder version"
  printf "  %-25s%s\n" "-black" "Black color folder version"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
}

install() {
  local dest=${1}
  local name=${2}
  local bright=${3}

  local THEME_DIR=${dest}/${name}${color}${bright}

  [[ -d ${THEME_DIR} ]] && rm -rf ${THEME_DIR}

  echo "Installing '${THEME_DIR}'..."

  mkdir -p                                                                             ${THEME_DIR}
  cp -ur ${SRC_DIR}/COPYING                                                            ${THEME_DIR}
  cp -ur ${SRC_DIR}/AUTHORS                                                            ${THEME_DIR}
  cp -ur ${SRC_DIR}/src/index.theme                                                    ${THEME_DIR}

  cd ${THEME_DIR}
  sed -i "s/Tela/Tela${color}${bright}/g" index.theme

  if [[ ${bright} != '-Dark' ]]; then
    cp -ur ${SRC_DIR}/src/{16,22,24,32,scalable,symbolic}                              ${THEME_DIR}
    cp -r ${SRC_DIR}/links/{16,22,24,32,scalable,symbolic}                             ${THEME_DIR}
    [[ ${color} != '' ]] && \
    cp -r ${SRC_DIR}/src/colors/color${color}/scalable/*.svg                           ${THEME_DIR}/scalable/places
  fi

  if [[ ${bright} == '-Dark' ]]; then
    mkdir -p                                                                           ${THEME_DIR}/16
    mkdir -p                                                                           ${THEME_DIR}/22
    mkdir -p                                                                           ${THEME_DIR}/24
    mkdir -p                                                                           ${THEME_DIR}/32

    cp -ur ${SRC_DIR}/src/16/{actions,devices,places}                                  ${THEME_DIR}/16
    cp -ur ${SRC_DIR}/src/22/actions                                                   ${THEME_DIR}/22
    cp -ur ${SRC_DIR}/src/24/actions                                                   ${THEME_DIR}/24

    cd ${THEME_DIR}/16/actions && sed -i "s/565656/aaaaaa/g" `ls`
    cd ${THEME_DIR}/16/devices && sed -i "s/565656/aaaaaa/g" `ls`
    cd ${THEME_DIR}/16/places && sed -i "s/727272/aaaaaa/g" `ls`
    cd ${THEME_DIR}/22/actions && sed -i "s/565656/aaaaaa/g" `ls`
    cd ${THEME_DIR}/24/actions && sed -i "s/565656/aaaaaa/g" `ls`

    cp -r ${SRC_DIR}/links/16/actions                                                  ${THEME_DIR}/16
    cp -r ${SRC_DIR}/links/16/devices                                                  ${THEME_DIR}/16
    cp -r ${SRC_DIR}/links/16/places                                                   ${THEME_DIR}/16
    cp -r ${SRC_DIR}/links/22/actions                                                  ${THEME_DIR}/22
    cp -r ${SRC_DIR}/links/24/actions                                                  ${THEME_DIR}/24

    cd ${dest}
    ln -s ../${name}${color}/scalable ${name}${color}-Dark/scalable
    ln -s ../${name}${color}/symbolic ${name}${color}-Dark/symbolic
    ln -s ../../${name}${color}/16/apps ${name}${color}-Dark/16/apps
    ln -s ../../${name}${color}/16/mimetypes ${name}${color}-Dark/16/mimetypes
    ln -s ../../${name}${color}/16/panel ${name}${color}-Dark/16/panel
    ln -s ../../${name}${color}/16/status ${name}${color}-Dark/16/status
    ln -s ../../${name}${color}/22/emblems ${name}${color}-Dark/22/emblems
    ln -s ../../${name}${color}/22/panel ${name}${color}-Dark/22/panel
    ln -s ../../${name}${color}/24/animations ${name}${color}-Dark/24/animations
    ln -s ../../${name}${color}/24/panel ${name}${color}-Dark/24/panel
    ln -s ../../${name}${color}/32/devices ${name}${color}-Dark/32/devices
  fi

  [[ ${color} != '' ]] && \
  cp -r ${SRC_DIR}/src/colors/color${color}/16/*.svg                                 ${THEME_DIR}/16/places/

  cd ${dest}
  gtk-update-icon-cache ${name}${color}${bright}
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -d|--dest)
      dest="${2}"
      if [[ ! -d "${dest}" ]]; then
        echo "ERROR: Destination directory does not exist."
        exit 1
      fi
      shift 2
      ;;
    -n|--name)
      name="${2}"
      shift 2
      ;;
    -all)
      all="true"
      ;;
    -black)
      color="-black"
      ;;
    -blue)
      color="-blue"
      ;;
    -brown)
      color="-brown"
      ;;
    -green)
      color="-green"
      ;;
    -grey)
      color="-grey"
      ;;
    -orange)
      color="-orange"
      ;;
    -pink)
      color="-pink"
      ;;
    -red)
      color="-red"
      ;;
    -yellow)
      color="-yellow"
      ;;
    -manjaro)
      color="-manjaro"
      ;;
    -ubuntu)
      color="-ubuntu"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
  shift
done

install_theme() {
for bright in "${brights[@]-${BRIGHT_VARIANTS[@]}}"; do
  install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${bright}"
done
}

install_all() {
for color in "${colors[@]-${COLOR_VARIANTS[@]}}"; do
  for bright in "${brights[@]-${BRIGHT_VARIANTS[@]}}"; do
    install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${bright}"
  done
done
}

if [[ "${all}" == 'true' ]]; then
  install_all
  else
  install_theme
fi
