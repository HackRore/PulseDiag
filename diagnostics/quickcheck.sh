#!/bin/bash

# This script performs a quick diagnostic scan of the system.
# It gathers basic system information and checks common hardware components.
# The results are compiled into a Markdown report.

echo "Running Quick Diagnostics..."

# Create a directory for logs if it doesn't exist
mkdir -p ../logs

# Define the report file path and name
REPORT_FILE="../logs/quick_report_$(date +%Y%m%d_%H%M%S).md"

# Function to add a section to the report
# Arguments: $1 = Section Title, $@ = Command to execute
add_to_report() {
    echo -e "\n## $1\n" >> "$REPORT_FILE"
    echo '```' >> "$REPORT_FILE"
    "$@" >> "$REPORT_FILE" 2>&1
    echo '```' >> "$REPORT_FILE"
}

# --- Start of Report ---
echo "# PulseDiag OS - Quick System Diagnostics Report" > "$REPORT_FILE"
echo "**Generated on:** $(date)" >> "$REPORT_FILE"

# --- System Information ---
echo "Gathering system information..."
add_to_report "Hostname and OS" hostnamectl
add_to_report "System Overview (neofetch)" neofetch
add_to_report "System Information (inxi)" inxi -Fxz

# --- Disk Health (SMART) ---
echo "Checking primary disk SMART status..."
# Assuming /dev/sda is the primary disk. This might need to be dynamic.
add_to_report "SMART Health Status (/dev/sda)" smartctl -H /dev/sda

# --- Sensor Readings ---
echo "Reading sensor data..."
add_to_report "Hardware Sensors (lm-sensors)" sensors

# --- Memory Usage ---
echo "Checking memory usage..."
add_to_report "Memory Usage (free)" free -h

echo "✅ Quick scan complete. Report saved to $REPORT_FILE"
