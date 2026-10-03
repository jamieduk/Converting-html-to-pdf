#!/bin/bash
# (c) J~Net 2026
# jnetai.com
# https://github.com/jamieduk/Converting-html-to-pdf
#
#
set -e

# Usage: ./convert-html-to-pdf.sh invoice-test.html

INPUT="$1"

if [ -z "$INPUT" ]; then
    echo -n "Filename of html to convert (Example invoice-test.html): "
    read INPUT

    if [ -z "$INPUT" ]; then
        INPUT="invoice-test.html"
    fi
fi

if [ ! -f "$INPUT" ]; then
    echo "Error: HTML file not found: $INPUT"
    exit 1
fi

# Remove the input extension and replace it with .pdf
OUTPUT="${INPUT%.*}.pdf"

BROWSER=""

for BIN in google-chrome google-chrome-stable chromium chromium-browser brave-browser; do
    if command -v "$BIN" >/dev/null 2>&1; then
        BROWSER="$(command -v "$BIN")"
        break
    fi
done

if [ -z "$BROWSER" ]; then
    echo "Error: Chromium, Chrome or Brave was not found."
    echo "Install Chromium with:"
    echo "sudo apt install -y chromium"
    exit 1
fi

INPUT="$(realpath "$INPUT")"
OUTPUT="$(realpath -m "$OUTPUT")"

"$BROWSER" \
    --headless=new \
    --disable-gpu \
    --no-sandbox \
    --disable-dev-shm-usage \
    --print-to-pdf="$OUTPUT" \
    --no-pdf-header-footer \
    --run-all-compositor-stages-before-draw \
    --virtual-time-budget=3000 \
    "file://$INPUT"

if [ -f "$OUTPUT" ]; then
    echo "PDF created:"
    echo "$OUTPUT"
else
    echo "Error: PDF was not created."
    exit 1
fi
