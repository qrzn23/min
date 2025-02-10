import re
import sys

def check_html_tags(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        lines = file.readlines()
    
    tag_stack = []
    unmatched_tags = []
    unclosed_tags = []
    tag_pattern = re.compile(r"<(/?)(\w+)[^>]*>")
    
    for line_number, line in enumerate(lines, start=1):
        matches = tag_pattern.findall(line)
        
        for is_closing, tag in matches:
            if is_closing:  # Closing tag
                if tag_stack and tag_stack[-1][1] == tag:
                    tag_stack.pop()
                else:
                    unmatched_tags.append((line_number, tag))
            else:  # Opening tag
                tag_stack.append((line_number, tag))
    
    # Any remaining tags in the stack are unclosed
    while tag_stack:
        line_num, tag = tag_stack.pop()
        unclosed_tags.append((line_num, tag))
    
    print("Unmatched Closing Tags:")
    for line_num, tag in unmatched_tags:
        print(f"Line {line_num}: Unmatched closing </{tag}> tag")
    
    print("\nUnclosed Opening Tags:")
    for line_num, tag in unclosed_tags:
        print(f"Line {line_num}: Unclosed opening <{tag}> tag")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python check_html_tags.py <file_path>")
    else:
        check_html_tags(sys.argv[1])

