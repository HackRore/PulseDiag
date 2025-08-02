#!/bin/bash

# Navigate to the script's directory
cd "$(dirname "$0")"

CHOICE=$(zenity --info --title="SmartDiag OS" \
    --text="Welcome to SmartDiag OS. Please choose a diagnostic scan to run." \
    --ok-label="Quit" \
    --extra-button="Quick Scan" \
    --extra-button="Deep Scan")

case "$CHOICE" in
    "Quick Scan")
        gnome-terminal -- bash -c "./diagnostics/quickcheck.sh; exec bash"
        ;;
    "Deep Scan")
        gnome-terminal -- bash -c "./diagnostics/deepcheck.sh; exec bash"
        ;;
esac

