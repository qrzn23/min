#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define file paths with optional arguments
CONTENT_FILE="${1:-content.md}"
OUTPUT_FILE="${2:-output.epub}"
METADATA_FILE="${3:-metadata.yaml}"
COVER_IMAGE="${4:-cover.png}"
RESOURCE_PATH="img:."

# Function to check if a file exists
check_file() {
  if [ ! -f "$1" ]; then
    echo "Error: Required file '$1' not found!" >&2
    exit 1
  fi
}

# Ensure required tools are installed
if ! command -v pandoc &> /dev/null; then
  echo "Error: pandoc is not installed. Install it and try again." >&2
  exit 1
fi

# Check for necessary files
check_file "$CONTENT_FILE"
check_file "$METADATA_FILE"
check_file "$COVER_IMAGE"

# Run pandoc to generate EPUB
echo "Generating EPUB..."
pandoc "$CONTENT_FILE" -o "$OUTPUT_FILE" \
  --metadata-file="$METADATA_FILE" \
  --epub-cover-image="$COVER_IMAGE" \
  --resource-path="$RESOURCE_PATH" \
  --toc --split-level=3

# Confirm success
echo "✅ EPUB successfully generated: $OUTPUT_FILE"
