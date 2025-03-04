#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# ----------------------------
# Configuration
# ----------------------------

# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Path to the shared stylesheet (located alongside the script)
STYLESHEET_FILE="$SCRIPT_DIR/style.css"

# Ensure the stylesheet exists
if [ ! -f "$STYLESHEET_FILE" ]; then
  echo "Error: Stylesheet '$STYLESHEET_FILE' not found!" >&2
  exit 1
fi

# Target directory where the generated EPUBs will be copied
TARGET_DIR=~/git/min/books/
mkdir -p "$TARGET_DIR"

# List of directories to process (each should contain a content.md)
INPUT_DIRS=(
  ~/git/min/wip/l418
  ~/git/min/wip/magick
  ~/git/min/wip/ld
  # Add additional directories here
)

# ----------------------------
# Ensure pandoc is installed
# ----------------------------
if ! command -v pandoc &> /dev/null; then
  echo "Error: pandoc is not installed. Install it and try again." >&2
  exit 1
fi

# ----------------------------
# Process each input directory
# ----------------------------
for dir in "${INPUT_DIRS[@]}"; do
  # Check if the directory exists
  if [ ! -d "$dir" ]; then
    echo "Warning: Directory not found - $dir"
    continue
  fi

  # Define file paths for required files in the directory
  CONTENT_FILE="$dir/content.md"
  METADATA_FILE="$dir/metadata.yaml"
  COVER_IMAGE="$dir/cover.jpg"

  # Check for required content file
  if [ ! -f "$CONTENT_FILE" ]; then
    echo "Skipping '$dir': content.md not found."
    continue
  fi

  # Optionally check for metadata and cover image
  if [ ! -f "$METADATA_FILE" ]; then
    echo "Warning: metadata.yaml not found in $dir. Skipping."
    continue
  fi
  if [ ! -f "$COVER_IMAGE" ]; then
    echo "Warning: cover.jpg not found in $dir. Skipping."
    continue
  fi

  # Determine output EPUB name based on the directory name
  FOLDER_NAME=$(basename "$dir")
  OUTPUT_FILE="$dir/${FOLDER_NAME}.epub"

  # Set local resource path:
  # Images are in the 'img' folder within the directory,
  # fonts are assumed to be one level up in a 'fonts' folder,
  # and current directory as fallback.
  LOCAL_RESOURCE_PATH="$dir/img:$dir/../fonts:."

  echo "Generating EPUB for $dir..."
  pandoc "$CONTENT_FILE" -o "$OUTPUT_FILE" \
    --metadata-file="$METADATA_FILE" \
    --epub-cover-image="$COVER_IMAGE" \
    --css "$STYLESHEET_FILE" \
    --resource-path="$LOCAL_RESOURCE_PATH" \
    --epub-embed-font="$dir/../fonts/EBGaramond-Regular.ttf" \
    --epub-embed-font="$dir/../fonts/EBGaramond-Bold.ttf" \
    --epub-embed-font="$dir/../fonts/EBGaramond-Italic.ttf" \
    --epub-embed-font="$dir/../fonts/silvus.ttf" \
    --toc --split-level=3

  echo "✅ EPUB generated: $OUTPUT_FILE"

  # Copy the generated EPUB to the target directory
  cp -v "$OUTPUT_FILE" "$TARGET_DIR"
done

echo "All done. EPUBs have been copied to: $TARGET_DIR"
