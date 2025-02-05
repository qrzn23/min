#!/bin/bash

# Check if an input file was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <input.txt>"
  exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${INPUT_FILE%.*}_formatted.txt"
THRESHOLD=60  # Adjust this value as needed

awk -v threshold="$THRESHOLD" '
# Function to flush the accumulated paragraph
function flush() {
  if (paragraph != "") {
    print paragraph
    paragraph = ""
  }
}
{
  if (length($0) == 0) {
    # Empty line: flush any accumulated paragraph and print a blank line
    flush()
    print ""
  } else if (length($0) >= threshold) {
    # Long line: always join
    if (paragraph == "")
      paragraph = $0
    else
      paragraph = paragraph " " $0
  } else {
    # Short line:
    # If the current paragraph ends with punctuation (., !, or ?),
    # then consider it a completed paragraph and flush it.
    if (paragraph != "" && paragraph ~ /[.?!]$/) {
      flush()
      paragraph = $0
    } else {
      # Otherwise, join the short line to the current paragraph
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
