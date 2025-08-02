#!/bin/bash

# This script serves as the main entry point for the PulseDiag OS.
# It presents a menu to the user to select a diagnostic scan to run.

# Navigate to the script's directory to ensure correct relative paths
cd "$(dirname "$0")"

# Activate the Python virtual environment
source venv/bin/activate

# Run the Textual TUI menu
CHOICE=$(python3 menu.py)

case "$CHOICE" in
    "quick_scan")
        gnome-terminal -- bash -c "./diagnostics/quickcheck.sh; exec bash"
        ;;
    "deep_scan")
        gnome-terminal -- bash -c "./diagnostics/deepcheck.sh; exec bash"
        ;;
    "quit")
        echo "Exiting PulseDiag OS. Goodbye!"
        ;;
esac

# Deactivate the virtual environment (optional, as the script exits)
deactivate