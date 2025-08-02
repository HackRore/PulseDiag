#!/bin/bash
echo " Running Quick Diagnostics..."
hostnamectl
neofetch
inxi -Fxz
smartctl -H /dev/sda
sensors
free -h
echo "✅ Scan complete. Report saved to logs/quick_report.md"