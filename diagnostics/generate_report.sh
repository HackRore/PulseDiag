#!/bin/bash

# This script generates an HTML report from a Markdown diagnostic report.
# It uses pandoc to convert the Markdown file into a professional-looking HTML file.

# --- Configuration ---
LOGO_PATH="../assets/logo.png"
REPORT_THEME="../assets/report_theme.css" # For custom styling
OUTPUT_DIR="../reports"
mkdir -p "$OUTPUT_DIR"

# --- Check for input file ---
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_markdown_report.md>"
    exit 1
fi
MARKDOWN_FILE="$1"
if [ ! -f "$MARKDOWN_FILE" ]; then
    echo "Error: Report file not found at $MARKDOWN_FILE"
    exit 1
fi

# --- Generate HTML ---
BASE_NAME=$(basename "$MARKDOWN_FILE" .md)
HTML_OUTPUT="$OUTPUT_DIR/${BASE_NAME}.html"

echo "Generating HTML report for $MARKDOWN_FILE..."

pandoc "$MARKDOWN_FILE" \
    -o "$HTML_OUTPUT" \
    --from=markdown \
    --to=html5 \
    --css="$REPORT_THEME" \
    --self-contained \
    --variable=logo:"$LOGO_PATH" \
    --variable=title:"PulseDiag OS Report"

if [ $? -eq 0 ]; then
    echo "✅ HTML report successfully generated at $HTML_OUTPUT"
else
    echo "❌ Error generating HTML report. Make sure pandoc is installed."
fi