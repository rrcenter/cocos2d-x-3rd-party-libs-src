#!/bin/bash

set -e
# set -x


NDK_PLAT=linux
## sudo apt-get install autoconf automake cmake libtool git
sudo apt-get install libncurses5 gcc-multilib g++-multilib --fix-missing -y

sudo apt-get install python3
# sudo ln -sn /usr/bin/python3 /usr/bin/python

mkdir -p buildsrc
wget -q -O ndk.zip https://dl.google.com/android/repository/android-ndk-r16b-${NDK_PLAT}-x86_64.zip
unzip -q ndk.zip -d buildsrc/

export ANDROID_NDK=`pwd`/buildsrc/android-ndk-r16b
export ANDROID_NDK_HOME=$ANDROID_NDK
export ANDROID_NDK_ROOT=$ANDROID_NDK
export PATH=$ANDROID_NDK/toolchains/llvm/prebuilt/${NDK_PLAT}-x86_64/bin:$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/${NDK_PLAT}-x86_64/bin:$PATH

source ./build.sh -p=android --libs=luajit --mode=release