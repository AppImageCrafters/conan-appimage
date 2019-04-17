#!/usr/bin/env bash

set -xe

SOURCES_DIR=${PWD}

rm build -rf
mkdir build && cd build

wget -nc https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
wget -nc https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-conda/master/linuxdeploy-plugin-conda.sh

chmod +x linuxdeploy-*

rm AppDir -rf

mkdir -p AppDir/usr/share/applications
cp ${SOURCES_DIR}/res/io.conan.desktop AppDir/usr/share/applications/

mkdir -p AppDir/usr/share/icons/hicolor/192x192/apps
cp ${SOURCES_DIR}/res/conan.png AppDir/usr/share/icons/hicolor/192x192/apps/

cp ${SOURCES_DIR}/AppRun AppDir

export CONDA_PACKAGES=conan
./linuxdeploy-x86_64.AppImage --appdir=AppDir --plugin conda --output appimage
