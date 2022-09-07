#!/bin/bash
# OctoPrint Installer for DarwinPrint
# lotuspar, 2022
source inc/config.sh
source inc/echorun.sh
source inc/text.sh
echo "${__header}OctoPrint Installer${__reset}"

__octoprint_env_dir=$INST_CFG_OUTPUT/Instance/environments/octoprint

test -d $__octoprint_env_dir || echorun python3 -m virtualenv -p python3 $__octoprint_env_dir --system-site-packages

echorun $__octoprint_env_dir/bin/pip install --no-binary :all: octoprint

# Create basic launch script
sudo /bin/sh -c "cat > /usr/bin/start-octoprint.sh" <<EOF
#!/bin/bash
# Start OctoPrint
OCTO_EXEC=$__octoprint_env_dir/bin/octoprint
OCTO_ARGS=""
\$OCTO_EXEC \$OCTO_ARGS serve
EOF
echo "Created octoprint launch script @ /usr/bin/start-octoprint.sh"