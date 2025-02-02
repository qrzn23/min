#!/bin/bash

# Define file paths
CONTENT_FILE="content.md"
OUTPUT_FILE="output.epub"
METADATA_FILE="metadata.yaml"
COVER_IMAGE="cover.jpg"

# Check if the necessary files exist
if [ ! -f "$CONTENT_FILE" ]; then
  echo "Error: $CONTENT_FILE not found!"
  exit 1
fi

if [ ! -f "$METADATA_FILE" ]; then
  echo "Error: $METADATA_FILE not found!"
  exit 1
fi

if [ ! -f "$COVER_IMAGE" ]; then
  echo "Error: $COVER_IMAGE not found!"
  exit 1
fi

# Run pandoc command to generate EPUB
pandoc "$CONTENT_FILE" -o "$OUTPUT_FILE" --metadata-file="$METADATA_FILE" --epub-cover-image="$COVER_IMAGE" --epub-embed-font=rosecaps.TTF --toc --split-level=3

# Check if pandoc command was successful
if [ $? -eq 0 ]; then
  echo "EPUB generated successfully: $OUTPUT_FILE"
else
  echo "Error generating EPUB!"
  exit 1
fi
