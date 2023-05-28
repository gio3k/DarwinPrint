#!/bin/bash
# Dependency Package Installer for DarwinPrint
# Procursus version
# lotuspar, 2022
source inc/echorun.sh
source inc/text.sh
echo "${__header}Dependency Installer for Procursus${__reset}"
echo "${__subheader}Installing packages${__reset}"

echo "Please enter the password for the mobile user if required. 🔐"
echo "If you haven't changed the password (which you should) it should be ${__bold}alpine${__rctxt}."
sudo echo "Ready 🔓"

# Update packages
# (really just making sure we have APT installed)
echorun sudo apt update --allow-insecure-repositories
if [ $? -ne 0 ]; then
    echo "Failed to update packages. Are you sure you're running Procursus?"
    exit 1
fi

# Upgrade packages
echorun sudo apt upgrade

# Install some basic necessity packages
echorun sudo apt --yes install git curl xz tar ldid clang bash make gzip wget libusb-1.0-0 libusb-1.0-0-dev usbutils
if [ $? -ne 0 ]; then
    echo "(1) Failed to install Group 1 of packages. Are you sure you're running Procursus?"
    exit 1
fi

# Install required packages
echorun sudo apt --yes install pkg-config clang dsymutil odcctools text-cmds python3.9 libpython3.9 libpython3.9-dev python3-psutil python3-yaml libffi-dev
if [ $? -ne 0 ]; then
    echo "(2) Failed to install Group 2 of packages. Are you sure you're running Procursus?"
    exit 1
fi

echo "${__subheader}Post-installation${__reset}"

# Symlinks for clang
echorun sudo ln -s /usr/bin/clang /usr/bin/gcc
echorun sudo ln -s /usr/bin/clang++ /usr/bin/g++

# Set up pip
echo "${__subheader}Install pip${__reset}"
echorun python3 -m ensurepip

echo "${__subheader}Install macOS SDK${__reset}"
echorun source sdk_installer.sh
