#!/bin/bash
# Klipper Installer for DarwinPrint
# lotuspar, 2022
source inc/config.sh
source inc/echorun.sh
source inc/text.sh
echo "${__header}Klipper Installer${__reset}"

__klipper_env_dir=$INST_CFG_OUTPUT/Instance/environments/klipper
__instance_dir=$INST_CFG_OUTPUT/Instance/
__config_dir=$INST_CFG_OUTPUT/Instance/sdcard
__klipper_dir=$INST_CFG_OUTPUT/Instance/klipper

# Clone klipper
echorun git -C $__instance_dir clone --depth 1 https://github.com/Klipper3d/klipper.git

# Create environment
test -d $__klipper_env_dir || echorun python3 -m virtualenv -p python3 $__klipper_env_dir --system-site-packages

# Install requirements
echorun $__klipper_env_dir/bin/pip install --no-binary :all: -r $__klipper_dir/scripts/klippy-requirements.txt

# Create basic launch script
echorun sudo /bin/sh -c "cat > /usr/bin/start-klippy.sh" <<EOF
#!/bin/bash
# Start klippy 
export CPATH=$__canutilsosx_repo/x/can
KLIPPY_EXEC=$__klipper_env_dir/bin/python
KLIPPY_ARGS="$__klipper_dir/klippy/klippy.py $__config_dir/printer.cfg -l $__instance_dir/klippy.log"
\$KLIPPY_EXEC \$KLIPPY_ARGS
EOF