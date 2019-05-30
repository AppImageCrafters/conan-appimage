#!/usr/bin/env bash

set -xe

SOURCES_DIR=${PWD}

rm build/AppDir -rf
mkdir -p build
pushd build

wget -qnc https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x linuxdeploy-*
./linuxdeploy-x86_64.AppImage --appimage-extract

wget -qnc https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-conda/master/linuxdeploy-plugin-conda.sh \
    -O squashfs-root/usr/bin/linuxdeploy-plugin-conda.sh
chmod +x squashfs-root/usr/bin/linuxdeploy-plugin-conda.sh

rm AppDir -rf

mkdir -p AppDir/usr/share/applications
cp ${SOURCES_DIR}/res/io.conan.desktop AppDir/usr/share/applications/

mkdir -p AppDir/usr/share/icons/hicolor/192x192/apps
cp ${SOURCES_DIR}/res/conan.png AppDir/usr/share/icons/hicolor/192x192/apps/

cp ${SOURCES_DIR}/AppRun AppDir

export CONDA_PACKAGES=conan
export UPDATE_INFORMATION="gh-releases-zsync|azubieta|conan-appimage|continuous|conan*$ARCH*.AppImage.zsync"
export SIGN=1
export VERBOSE=1

squashfs-root/AppRun --appdir=AppDir --plugin conda
squashfs-root/AppRun --appdir=AppDir --output appimage
popd
