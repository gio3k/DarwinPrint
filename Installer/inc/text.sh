#!/bin/bash
# Text includes for DarwinPrint installers
# exports {__reset, __bold, __underline, __blink, __standout}

__reset=$(tput sgr0)
__bold=$(tput bold)
__underline=$(tput smul)
__blink=$(tput blink)
__standout=$(tput smso)

__header=">>> ${__standout}${__underline}"
__subheader=">> ${__underline}" 