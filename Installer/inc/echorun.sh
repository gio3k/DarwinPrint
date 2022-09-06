#!/bin/bash
# Echorun function for DarwinPrint installers
# exports {echorun}

function echorun {
  echo ">" "$@"
  eval $(printf '%q ' "$@") < /dev/tty
}