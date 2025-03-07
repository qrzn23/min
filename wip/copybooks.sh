#!/bin/bash

# Directories for the epub copies
TARGET_EPUB1=~/git/qrzn.github.io/assets/books/epub/
TARGET_EPUB2=~/git/min/books/

# Directory for covers
TARGET_COVER=~/git/qrzn.github.io/assets/books/cover/

# Create the target directories if they don't exist
mkdir -p "$TARGET_EPUB1"
mkdir -p "$TARGET_EPUB2"
mkdir -p "$TARGET_COVER"

# Define an array with source files
FILES=(
  ~/git/min/wip/aleph/aleph.epub
  ~/git/min/wip/confessions/confessions.epub
  ~/git/min/wip/l220/liber220.epub
  ~/git/min/wip/l220comments/l220comments.epub
  ~/git/min/wip/l418/liber418.epub
  ~/git/min/wip/ld/ld.epub
  ~/git/min/wip/liber333/liber333.epub
  ~/git/min/wip/little-essays-towards-truth/essays-truth.epub
  ~/git/min/wip/magick/magick.epub
  ~/git/min/wip/mwt/mwt.epub
  ~/git/min/wip/ttk/ttk.epub
)

# Loop through each file
for file in "${FILES[@]}"; do
  # Check if the EPUB file exists
  if [[ -f "$file" ]]; then
    # Copy the EPUB to the first target directory
    cp -v "$file" "$TARGET_EPUB1"
    # Copy the EPUB to the second target directory
    cp -v "$file" "$TARGET_EPUB2"

    # Derive basename for renaming the cover
    filename=$(basename "$file")   # e.g. aleph.epub
    base="${filename%.epub}"      # e.g. aleph

    # Look for cover.jpg in the same folder as the EPUB
    cover_source="$(dirname "$file")/cover.jpg"
    if [[ -f "$cover_source" ]]; then
      # Copy cover.jpg to the cover directory, renaming it to match the EPUB name
      cp -v "$cover_source" "$TARGET_COVER/${base}.jpg"
    else
      echo "Warning: cover.jpg not found for $file"
    fi
  else
    echo "Warning: File not found - $file"
  fi
done
