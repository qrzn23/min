#!/usr/bin/env python3
import argparse
import re
import sys
from spellchecker import SpellChecker

def correct_spelling_line_by_line(input_file, output_file):
    spell = SpellChecker()

    with open(input_file, 'r', encoding='utf-8') as infile, open(output_file, 'w', encoding='utf-8') as outfile:
        total_lines = sum(1 for _ in open(input_file, 'r', encoding='utf-8'))  # Count total lines
        infile.seek(0)  # Reset file pointer to start

        for i, line in enumerate(infile):
            words = re.findall(r'\b\w+\b', line)
            misspelled = spell.unknown(words)

            corrections = {word: spell.correction(word) for word in misspelled if spell.correction(word)}
            
            for wrong, right in corrections.items():
                line = re.sub(rf'\b{re.escape(wrong)}\b', right, line)

            outfile.write(line)

            if i % 100 == 0:  # Print progress every 100 lines
                sys.stdout.write(f"\rProcessing line {i}/{total_lines}...")
                sys.stdout.flush()

    print(f"\nSpell check complete! Corrected file saved as: {output_file}")

def main():
    parser = argparse.ArgumentParser(description="Fast spell-checker for large files.")
    parser.add_argument("input_file", help="Path to input text file")
    parser.add_argument("output_file", help="Path to output corrected text file")
    args = parser.parse_args()

    correct_spelling_line_by_line(args.input_file, args.output_file)

if __name__ == "__main__":
    main()
