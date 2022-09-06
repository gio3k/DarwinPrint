#!/bin/bash
# Dependency Package Installer for DarwinPrint
# Dummy version
# lotuspar, 2022
source inc/echorun.sh
source inc/text.sh
echo "${__header}Dependency Installer for None${__reset}"
echo "${__subheader}Installing packages${__reset}"

echo "Please enter the password for the mobile user if required. 🔐"
echo "If you haven't changed the password (which you should) it should be ${__bold}alpine${__rctxt}."
sudo echo "Ready 🔓"

# Set up pip
echo "${__subheader}Install pip${__reset}"
echorun python3 -m ensurepip

echo "${__subheader}Install macOS SDK${__reset}"
echorun source sdk_installer.sh