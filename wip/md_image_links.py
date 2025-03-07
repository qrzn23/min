import os
import re

def natural_sort_key(text):
    """
    Split the string into alphanumeric chunks for proper natural sorting.
    e.g., "10.jpg" will come after "9.jpg".
    """
    return [int(chunk) if chunk.isdigit() else chunk for chunk in re.split(r'(\d+)', text)]

def generate_image_links(folder_path, output_file):
    # Get all .jpg files from the folder
    jpg_files = [f for f in os.listdir(folder_path) if f.lower().endswith('.jpg')]
    
    # Sort them with a 'natural' sort order
    jpg_files.sort(key=natural_sort_key)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        for filename in jpg_files:
            f.write(f"![]({filename})\n")

if __name__ == "__main__":
    # Update the folder path where your .jpg images reside
    folder_path = '.'
    
    # Update the output file name as needed
    output_file = 'image_links.md'
    
    generate_image_links(folder_path, output_file)
    print(f"Markdown links for .jpg images have been written to '{output_file}'.")
