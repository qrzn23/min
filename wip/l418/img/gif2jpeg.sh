#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed."
    exit 1
fi

# Check if at least one GIF file exists
shopt -s nullglob
gifs=(*.gif)
if [ ${#gifs[@]} -eq 0 ]; then
    echo "No GIF files found in the current directory."
    exit 1
fi

# Loop through all GIF files
for gif in "${gifs[@]}"; do
    base_name="${gif%.*}"  # Remove file extension
    echo "Converting $gif..."
    convert "$gif" -quality 90 "${base_name}-%03d.jpg"
done

echo "Conversion complete."

