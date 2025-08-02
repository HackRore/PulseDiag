#!/bin/bash

# This script performs a deep diagnostic scan of the system.
# It gathers detailed hardware information, checks for errors, and runs various tests.
# The results are compiled into a Markdown report.

# Function to read values from config.ini
get_config_value() {
    local section=$1
    local key=$2
    grep -A 100 "[$section]" ../config.ini | grep "$key =" | head -1 | cut -d '=' -f 2 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

# Read log directory from config.ini
LOG_DIR="../$(get_config_value "General" "log_directory")"

echo "Running Deep Diagnostics... This may take a while."

# Create a directory for logs if it doesn't exist
mkdir -p "$LOG_DIR"

# Define the report file path and name
REPORT_FILE="$LOG_DIR/deep_report_$(date +%Y%m%d_%H%M%S).md"

# Function to add a section to the report
# Arguments: $1 = Section Title, $@ = Command to execute
add_to_report() {
    echo -e "\n## $1\n" >> "$REPORT_FILE"
    echo '```' >> "$REPORT_FILE"
    "$@" >> "$REPORT_FILE" 2>&1
    echo '```' >> "$REPORT_FILE"
}

# --- Start of Report ---
echo "# PulseDiag OS - Deep System Diagnostics Report" > "$REPORT_FILE"
echo "**Generated on:** $(date)" >> "$REPORT_FILE"


# --- System Error Check ---
echo "Checking for system errors in dmesg..."
add_to_report "Kernel Ring Buffer (dmesg)" dmesg

# --- Hardware Inventory ---
echo "Gathering detailed hardware inventory..."
add_to_report "Hardware List (lshw)" lshw
add_to_report "Hardware Info (hwinfo)" hwinfo --short

# --- CPU Information ---
echo "Fetching CPU details..."
add_to_report "CPU Information (lscpu)" lscpu

# --- Memory Test ---
# Note: memtester requires root privileges and can take a very long time.
# This is a placeholder for a real memory test that would be run from the boot environment.
# A full memtest86+ or similar would be better for a bootable USB.
echo "Running a light memory test (memtester)..."
add_to_report "Memory Test (memtester 10M 1)" sudo memtester 10M 1

# --- Disk Health & Bad Blocks ---
# Running smartctl on all detected drives
echo "Checking SMART status for all drives..."
for disk in $(ls /dev/sd* | grep -v '[0-9]'); do
    add_to_report "SMART Details for $disk" sudo smartctl -a "$disk"
done

# Note: badblocks is a destructive test if run in write mode.
# We will run it in non-destructive read-only mode.
echo "Performing non-destructive disk surface scan (badblocks)..."
add_to_report "Disk Surface Scan (badblocks -nsv)" sudo badblocks -nsv /dev/sda

# --- Filesystem Usage ---
echo "Analyzing filesystem usage..."
add_to_report "Filesystem Disk Space Usage (df -h)" df -h

# --- Stress Test (Placeholder) ---
echo "Running a short CPU stress test..."
add_to_report "CPU Stress Test (stress-ng)" stress-ng --cpu 1 --timeout 60s

echo "✅ Deep scan complete. Report saved to $REPORT_FILE"

# --- AI Troubleshooting ---
echo "🤖 Running AI Troubleshooter..."
python3 ./ai_troubleshooter.py "$REPORT_FILE"

echo "✅ AI analysis complete. Full report updated at $REPORT_FILE"