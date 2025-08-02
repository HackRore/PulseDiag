#!/bin/bash

# --- Configuration ---
LOGO_PATH="../assets/logo.png"
REPORT_THEME="../assets/report_theme.css" # Optional: For custom styling
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

# --- Generate PDF ---
BASE_NAME=$(basename "$MARKDOWN_FILE" .md)
PDF_OUTPUT="$OUTPUT_DIR/${BASE_NAME}.pdf"

echo "Generating PDF report for $MARKDOWN_FILE..."

pandoc "$MARKDOWN_FILE" \
    -o "$PDF_OUTPUT" \
    --from=markdown \
    --to=pdf \
    --pdf-engine=xelatex \
    -V geometry:"top=1in, bottom=1in, left=1in, right=1in" \
    -V mainfont="Arial" \
    --variable=logo:"$LOGO_PATH" \
    --variable=title:"SmartDiag OS Report" \
    --template=../assets/report_template.tex # A simple LaTeX template

if [ $? -eq 0 ]; then
    echo "✅ PDF report successfully generated at $PDF_OUTPUT"
else
    echo "❌ Error generating PDF report. Make sure pandoc and a LaTeX engine are installed."
fi
