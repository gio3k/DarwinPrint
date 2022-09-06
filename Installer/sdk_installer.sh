#!/bin/bash
# SDK Installer for DarwinPrint
# lotuspar, 2022
source inc/config.sh
source inc/echorun.sh
source inc/text.sh
echo "${__header}SDK Installer${__reset}"

# Check if we already have an SDK
if [ -d ${INST_SYS_SDKFOLDER}/MacOSX.sdk ]; then
    echo "The macOS SDK already exists on your device."
    echo "You can skip installing the macOS 11.0 SDK if you'd like."
    echo "If you have building problems after, please remove the SDK (/usr/share/SDKs/MacOSX.sdk) and use this installer again."

    read -r -p "➡ Skip installing SDK? (y/N) " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo "Using existing SDK!"
        return
    else
        echo "Removing existing SDK!"
        echorun sudo rm -rf ${INST_SYS_SDKFOLDER}/MacOSX.sdk
    fi
fi

echo "Installing new SDK from ${INST_CFG_OSXSDK}"

echo "${__subheader}Download SDK${__reset}"
# Make temporary storage for SDK
echorun mkdir /tmp/darwin_print_tmp_sdk 2>/dev/null
echorun mkdir /tmp/darwin_print_tmp_sdk/dir 2>/dev/null

# Download new SDK
echorun wget -q --show-progress ${INST_CFG_OSXSDK} -O /tmp/darwin_print_tmp_sdk/sdk.tar.xz

echo "${__subheader}Install SDK${__reset}"
# Extract new SDK
echorun tar -xf /tmp/darwin_print_tmp_sdk/sdk.tar.xz -C /tmp/darwin_print_tmp_sdk/dir
if [ $? -ne 0 ]; then
    echo "Failed to extract SDK. Exiting..."
    exit 1
fi

# Move extracted SDK to final output
echo "Moving SDK to ${INST_SYS_SDKFOLDER}..."
echorun sudo mv /tmp/darwin_print_tmp_sdk/dir/MacOSX* ${INST_SYS_SDKFOLDER}/MacOSX.sdk

echo "Finished installing SDK."