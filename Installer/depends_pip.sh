#!/bin/bash
# Pip Dependency Installer for DarwinPrint
# lotuspar, 2022
source inc/config.sh
source inc/echorun.sh
source inc/text.sh
echo "${__header}Pip Dependency Installer${__reset}"

echorun export CPPFLAGS=${INST_SYS_CPPFLAGS}

echorun python3 -m pip install --user virtualenv
echorun python3 -m pip install --user wheel
echorun python3 -m pip install --user pytz
echorun python3 -m pip install --user libusb1
echorun python3 -m pip install --user --no-binary :all: cython
if [ $? -ne 0 ]; then
    echo "🚫 Failed to compile Cython. Please try to rerun the installer."
    exit 1
fi

echo "Installed prerequisites!"