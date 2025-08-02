#!/bin/bash

# This script serves as the main entry point for the PulseDiag OS.
# It presents a menu to the user to select a diagnostic scan to run.

# Navigate to the script's directory to ensure correct relative paths
cd "$(dirname "$0")"

CHOICE=$(zenity --info --title="PulseDiag OS"     --text="Welcome to PulseDiag OS. Please choose a diagnostic scan to run."     --ok-label="Quit"     --extra-button="Quick Scan"     --extra-button="Deep Scan")

case "$CHOICE" in
    "Quick Scan")
        gnome-terminal -- bash -c "./diagnostics/quickcheck.sh; exec bash"
        ;;
    "Deep Scan")
        gnome-terminal -- bash -c "./diagnostics/deepcheck.sh; exec bash"
        ;;
esac

