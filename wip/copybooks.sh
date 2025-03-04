#!/bin/bash

# Set the target directory
TARGET=~/git/min/books/

# Create the target directory if it doesn't exist
mkdir -p "$TARGET"

# Define an array with source files
FILES=(
  ~/git/min/wip/aleph/aleph.epub
  ~/git/min/wip/confessions/confessions.epub
  ~/git/min/wip/l220comments/l220comments.epub
  ~/git/min/wip/l418/liber418.epub
  ~/git/min/wip/ld/ld.epub
  ~/git/min/wip/liber333/liber333.epub
  ~/git/min/wip/magick/magick.epub
  ~/git/min/wip/mwt/mwt.epub
  ~/git/min/wip/ttk/ttk.epub
  # Add additional files here, for example:
  # ~/git/min/wip/other/otherfile.epub
)

# Loop through each file and copy it to the target directory
for file in "${FILES[@]}"; do
  if [[ -f "$file" ]]; then
    cp -v "$file" "$TARGET"
  else
    echo "Warning: File not found - $file"
  fi
done
