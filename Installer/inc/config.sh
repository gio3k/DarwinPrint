#!/bin/bash
# Klipper / OctoPrint installer for iOS
# Configuration / variables
# exports {INST_CFG_OUTPUT, INST_CFG_OSXSDK, INST_SYS_SDKFOLDER, INST_SYS_CPPFLAGS}

# INST_CFG_OUTPUT
# Location to install to
# default "$HOME/DarwinPrint"
INST_CFG_OUTPUT=${INST_CFG_OUTPUT:="$HOME/DarwinPrint"}

# INST_SYS_OSXSDK
# Location (remote) of macOS SDK
# default "https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX11.0.sdk.tar.xz"
INST_CFG_OSXSDK=${INST_CFG_OSXSDK:="https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX11.0.sdk.tar.xz"}

# INST_SYS_SDKFOLDER
# Location of iOS / macOS / etc.. SDKs
# default "/usr/share/SDKs"
INST_SYS_SDKFOLDER=${INST_SYS_SDKFOLDER:="/usr/share/SDKs"}

# INST_SYS_CPPFLAGS
# Flags to use when compiling
# default "-target arm64-apple-ios14.0 -isysroot ${INST_SYS_SDKFOLDER}/iPhoneOS.sdk"
INST_SYS_CPPFLAGS=${INST_SYS_CPPFLAGS:="-target arm64-apple-ios14.0 -isysroot ${INST_SYS_SDKFOLDER}/iPhoneOS.sdk"}

# INST_CFG_WHEELFOLDER
# Location to put compiled wheels
# default "$INST_CFG_OUTPUT/Instance/wheels"
INST_CFG_WHEELFOLDER=${INST_CFG_WHEELFOLDER:="$INST_CFG_OUTPUT/Instance/wheels"}