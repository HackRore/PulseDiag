#!/bin/bash

# This script serves as the main entry point for the PulseDiag OS.
# It presents a menu to the user to select a diagnostic scan to run.

# Navigate to the script's directory to ensure correct relative paths
cd "$(dirname "$0")"

# Function to read values from config.ini
get_config_value() {
    local section=$1
    local key=$2
    grep -A 100 "\[$section\]" config.ini | grep "$key =" | head -1 | cut -d '=' -f 2 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

# Read script paths from config.ini
QUICK_SCAN_SCRIPT=$(get_config_value "Diagnostics" "quick_scan_script")
DEEP_SCAN_SCRIPT=$(get_config_value "Diagnostics" "deep_scan_script")

# Activate the Python virtual environment
source venv/bin/activate

# Run the Textual TUI menu
CHOICE=$(python3 menu.py)

case "$CHOICE" in
    "quick_scan")
        gnome-terminal -- bash -c "./$QUICK_SCAN_SCRIPT; exec bash"
        ;;
    "deep_scan")
        gnome-terminal -- bash -c "./$DEEP_SCAN_SCRIPT; exec bash"
        ;;
    "quit")
        echo "Exiting PulseDiag OS. Goodbye!"
        ;;
esac

# Deactivate the virtual environment (optional, as the script exits)
deactivate
