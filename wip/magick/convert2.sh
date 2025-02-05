#!/bin/bash

# Check if an input file was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <input.epub>"
  exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${INPUT_FILE%.*}.txt"

# Step 1. Convert the EPUB to plain text and join all lines into one long line.
# The "tr" command replaces newlines with spaces.
# The "sed" command collapses multiple spaces into one.
joined=$(pandoc "$INPUT_FILE" -t plain | tr '\n' ' ' | sed 's/  */ /g')

# Step 2. Use sed to insert paragraph breaks after sentence-ending punctuation.
# This regex looks for punctuation (a period, question mark, or exclamation mark)
# possibly followed by a quote or apostrophe, then some spaces, and then an uppercase letter.
# It replaces that space sequence with two newlines so that a new paragraph starts.
echo "$joined" | sed -E 's/([.?!]["'\''’”]?)[[:space:]]+([A-Z])/\1\n\n\2/g' > "$OUTPUT_FILE"

echo "Conversion complete: $OUTPUT_FILE"
