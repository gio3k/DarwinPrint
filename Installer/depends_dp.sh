#!/bin/bash
# Submodule Dependency Installer for DarwinPrint
# lotuspar, 2022
source inc/config.sh
source inc/echorun.sh
source inc/text.sh
echo "${__header}Submodule Dependency Installer${__reset}"
__pre_install_pwd=$PWD

echorun export CPPFLAGS="$INST_SYS_CPPFLAGS"

echo "${__subheader}Patching submodules${__reset}"
__argparse_src="https://raw.githubusercontent.com/p-ranav/argparse/master/include/argparse/argparse.hpp"
__argparse_out=$INST_CFG_OUTPUT/Dependencies/usbselfserial/argparse.hpp
__netifaces_patch_0001=$INST_CFG_OUTPUT/Dependencies/Patches/netifaces-0001.patch
__netifaces_repo=$INST_CFG_OUTPUT/Dependencies/netifaces
__babel_patch_0001=$INST_CFG_OUTPUT/Dependencies/Patches/babel-0001.patch
__babel_repo=$INST_CFG_OUTPUT/Dependencies/babel
__pyserial_patch_0001=$INST_CFG_OUTPUT/Dependencies/Patches/pyserial-0001.patch
__pyserial_repo=$INST_CFG_OUTPUT/Dependencies/pyserial
__canutilsosx_repo=$INST_CFG_OUTPUT/Dependencies/can-utils-osx
__usbselfserial_repo=$INST_CFG_OUTPUT/Dependencies/usbselfserial

# Install argparse to usbselfserial folder
echorun curl -L https://raw.githubusercontent.com/p-ranav/argparse/master/include/argparse/argparse.hpp -o $__usbselfserial_repo/argparse.hpp
if [ $? -ne 0 ]; then
    echo "Failed to install argparse. Please try to rerun the installer."
    exit 1
fi

echorun export EMAIL=root@localhost

echorun cd $__netifaces_repo
echorun git am $__netifaces_patch_0001
if [ $? -ne 0 ]; then
    echo "Failed to patch netifaces. The installer might not finish."
fi

echorun cd $__babel_repo
echorun git am $__babel_patch_0001
if [ $? -ne 0 ]; then
    echo "Failed to patch babel. The installer might not finish."
fi

echorun cd $__pyserial_repo
echorun git am $__pyserial_patch_0001
if [ $? -ne 0 ]; then
    echo "Failed to patch pyserial. The installer might not finish."
fi

echo "Patched submodules."

echo "${__subheader}Compiling submodules${__reset}"

# Compile netifaces
echorun python3 -m pip wheel $__netifaces_repo -w $INST_CFG_WHEELFOLDER
if [ $? -ne 0 ]; then
    echo "Failed to compile netifaces. Please try to rerun the installer."
    exit 1
fi

# Compile pyserial
echorun python3 -m pip wheel $__pyserial_repo -w $INST_CFG_WHEELFOLDER
if [ $? -ne 0 ]; then
    echo "Failed to compile netifaces. Please try to rerun the installer."
    exit 1
fi

# Prepare & compile babel
cd $__babel_repo
echorun python3 setup.py import_cldr
echorun python3 -m pip wheel $__babel_repo -w $INST_CFG_WHEELFOLDER
if [ $? -ne 0 ]; then
    echo "Failed to compile babel. Please try to rerun the installer."
    exit 1
fi
cd ${__pre_install_pwd}

# Rename folder in can-utils-osx for easier compiling later
echorun mv $__canutilsosx_repo/x/can/lib $__canutilsosx_repo/x/can/linux

# Compile usbselfserial loader
echorun g++ $__usbselfserial_repo/loader.cpp -O2 `pkg-config --libs --cflags libusb-1.0` -std=c++17 -o /tmp/uss_loader
if [ $? -ne 0 ]; then
    echo "Failed to compile usbselfserial."
    exit 1
fi
echorun curl -L https://raw.githubusercontent.com/ProcursusTeam/Procursus/main/build_misc/entitlements/usb.xml -o /tmp/uss_loader_ent.xml
echorun ldid -S/tmp/uss_loader_ent.xml /tmp/uss_loader
echorun sudo mv /tmp/uss_loader /usr/bin/uss_loader

# Install newly compiled wheels
echo "Installing wheels..."
echorun python3 -m pip install $INST_CFG_WHEELFOLDER/*
if [ $? -ne 0 ]; then
    echo "Failed to install newly compiled wheels."
    exit 1
fi