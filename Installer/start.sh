#!/bin/bash
# Starting point for DarwinPrint installer
# lotuspar, 2022
if ! [ -d "./Installer" ]; then
    echo "Please run this installer in the root of the DarwinPrint folder."
    exit 1
fi
cd ./Installer
INST_CFG_OUTPUT="$(dirname "$PWD")"

source inc/config.sh
source inc/echorun.sh
source inc/text.sh

echo "${__bold}Welcome to the DarwinPrint installer!${__reset} ⚙️"
echo "⚠ Please note: this installer only supports devices bootstrapped with Procursus right now."
echo "  This script will attempt to install Klipper and/or OctoPrint to your device."

read -r -p "➡ Proceed? (y/N) " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo
else
    echo "🚫 Exiting!"
    exit 0
fi

echorun source packages.sh
echorun source depends_pip.sh
echorun source depends_dp.sh
echorun source klipper_installer.sh
echorun source octoprint_installer.sh

echo "Completed experimental install!"
echo "No launch daemon was configured, so:"
echo "-> to launch OctoPrint use start-octoprint.sh"
echo "-> to launch Klippy use start-klippy.sh"
echo
echo "To start a serial port to your printer:"
echo "-> sudo uss_loader -v (VENDOR_ID) -p (PRODUCT_ID) -d ch34x -o /tmp/uss0 -r 250000"
echo "or sudo uss_loader -v (VENDOR_ID) -p (PRODUCT_ID) -d cdcacm -o /tmp/uss0 -r 250000"
echo
echo "Make sure to use the right baudrate for your printer though:"
echo "-> for Marlin (probably) use -r 115200"
echo "-> for Klipper (probably) use -r 250000"