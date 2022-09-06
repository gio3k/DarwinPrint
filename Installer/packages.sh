#!/bin/bash
# System Prep for DarwinPrint
# lotuspar, 2022
source inc/echorun.sh
source inc/text.sh
echo "${__header}System Prep${__reset}"

run_installer_bootstrap_specific() {
    echo "Determining correct package install method..."

    if [ -f "/.procursus_strapped" ]; then
        echo "Procursus device found!"
        echorun source bootstrap_specific/procursus.sh
        return
    fi

    echo "No known package installer found for your device."
    echo "Falling back to Procursus package installer."
    echorun source bootstrap_specific/dummy.sh
}

run_installer_bootstrap_specific
