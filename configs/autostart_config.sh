#!/bin/bash

# This script is intended to be run on system startup.
# It will launch the SmartDiag OS main menu.

# The path to the main script.
# This assumes the script is located in the user's home directory.
# In a real implementation, this path might need to be adjusted.
DIAG_SCRIPT_PATH="/home/user/smartdiag-os/start_diag.sh"

if [ -f "$DIAG_SCRIPT_PATH" ]; then
    # Launch the main diagnostic script
    bash "$DIAG_SCRIPT_PATH"
else
    # Fallback to a terminal if the script is not found
    gnome-terminal
fi
