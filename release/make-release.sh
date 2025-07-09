#! /bin/bash

THEME_DIR=$(cd $(dirname $0) && pwd)

THEME_NAME=Tela

_THEME_VARIANTS=('' '-dracula' '-purple' '-blue' '-black' '-manjaro' '-ubuntu' '-nord' '-red' '-grey' '-green')

if [ ! -z "${THEME_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _THEME_VARIANTS <<< "${THEME_VARIANTS:-}"
fi

Tar_themes() {
for theme in "${_THEME_VARIANTS[@]}"; do
  rm -rf "${THEME_NAME}${theme}.tar.xz"
done

rm -rf "01-${THEME_NAME}.tar.xz"

for theme in "${_THEME_VARIANTS[@]}"; do
  tar -Jcvf "${THEME_NAME}${theme}.tar.xz" "${THEME_NAME}${theme}"{'','-light','-dark'}
done

mv "${THEME_NAME}.tar.xz" "01-${THEME_NAME}.tar.xz"
}

Clear_theme() {
for theme in "" "-black" "-blue" "-brown" "-green" "-grey" "-orange" "-pink" "-purple" "-red" "-yellow" "-manjaro" "-ubuntu" "-dracula" "-nord"; do
  rm -rf "${THEME_NAME}${theme}"{'','-light','-dark'}
done
}

cd .. && ./install.sh -d $THEME_DIR -a

cd $THEME_DIR && Tar_themes && Clear_theme

