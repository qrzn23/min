#!/bin/bash

# Check if an input file was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <input.txt>"
  exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${INPUT_FILE%.*}_formatted.txt"
THRESHOLD=60  # Adjust as needed

awk -v threshold="$THRESHOLD" '
# Function to flush accumulated paragraph buffer
function flush() {
  if (paragraph != "") {
    print paragraph
    paragraph = ""
  }
}

{
  # Trim leading and trailing spaces
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0)

  # Skip standalone numbers (likely page numbers)
  if ($0 ~ /^[0-9]+$/) {
    next
  }

  # Handle hyphenated words that are split across lines
  if ($0 ~ /-$/) {
    sub(/-$/, "", $0)  # Remove trailing hyphen

    if (getline next_line) {
      gsub(/^[[:space:]]+/, "", next_line)  # Remove leading spaces from next line
      $0 = $0 next_line
    }
  }

  # Handle paragraph merging
  if (length($0) == 0) {
    # Blank line: flush paragraph buffer
    flush()
    print ""
  } else if (length($0) >= threshold) {
    # Long line: merge into the current paragraph buffer
    if (paragraph == "")
      paragraph = $0
    else
      paragraph = paragraph " " $0
  } else {
    # Short line handling
    if (paragraph != "" && paragraph ~ /[.?!]$/) {
      flush()
      paragraph = $0
    } else {
      if (paragraph == "")
        paragraph = $0
      else
        paragraph = paragraph " " $0
    }
  }
}
END {
  flush()
}
' "$INPUT_FILE" > "$OUTPUT_FILE"

echo "Conversion complete: $OUTPUT_FILE"
