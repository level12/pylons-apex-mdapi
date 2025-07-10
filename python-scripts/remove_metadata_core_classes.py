#!/usr/bin/env python3
"""
Script to remove all classes from soapSforceCom200604Metadata.cls that exist in MetadataCore.cls.
This creates a dedicated purpose-driven class for Custom Objects and their dependencies.
"""

import re
import os
import sys
from typing import Set, List, Tuple


def extract_class_names_from_file(file_path: str) -> Set[str]:
    """
    Extract all inner class names from an Apex class file.

    Args:
        file_path: Path to the Apex class file

    Returns:
        Set of class names found in the file
    """
    class_names = set()

    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()

        # Pattern to match inner class declarations
        # Matches: public class ClassName {
        pattern = r'^\s*public\s+class\s+([A-Za-z_][A-Za-z0-9_]*)\s*\{'

        matches = list(re.finditer(pattern, content, re.MULTILINE))

        for i, match in enumerate(matches):
            class_name = match.group(1)
            # Skip the main outer class (first class in file)
            if i == 0:  # This is the first class found (main class)
                print(f"Skipping main class: {class_name}")
                continue
            class_names.add(class_name)
            print(f"Found inner class: {class_name}")

    except FileNotFoundError:
        print(f"Error: File {file_path} not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file {file_path}: {e}")
        sys.exit(1)

    return class_names


def find_class_boundaries(content: str, class_name: str) -> Tuple[int, int]:
    """
    Find the start and end positions of a class definition in the content.

    Args:
        content: The file content as string
        class_name: Name of the class to find

    Returns:
        Tuple of (start_pos, end_pos) or (-1, -1) if not found
    """
    # Pattern to match the class declaration with proper indentation
    pattern = rf'(\s*)public\s+class\s+{re.escape(class_name)}\s*\{{'

    match = re.search(pattern, content, re.MULTILINE)
    if not match:
        return (-1, -1)

    # Start from the beginning of the line (including indentation)
    start_pos = match.start()

    # Find the matching closing brace
    brace_count = 0
    pos = match.end() - 1  # Start from the opening brace

    while pos < len(content):
        char = content[pos]
        if char == '{':
            brace_count += 1
        elif char == '}':
            brace_count -= 1
            if brace_count == 0:
                # Found the matching closing brace
                # Include the closing brace and move to next line
                end_pos = pos + 1

                # Skip to the end of the current line
                while end_pos < len(content) and content[end_pos] not in '\r\n':
                    end_pos += 1

                # Include the newline character(s)
                if end_pos < len(content) and content[end_pos] == '\r':
                    end_pos += 1
                if end_pos < len(content) and content[end_pos] == '\n':
                    end_pos += 1

                return (start_pos, end_pos)
        pos += 1

    return (-1, -1)


def remove_classes_from_content(content: str, classes_to_remove: Set[str]) -> Tuple[str, List[str]]:
    """
    Remove specified classes from the content.
    
    Args:
        content: The original file content
        classes_to_remove: Set of class names to remove
        
    Returns:
        Modified content with classes removed
    """
    # Sort classes by their position in the file (reverse order to avoid position shifts)
    class_positions = []
    
    for class_name in classes_to_remove:
        start_pos, end_pos = find_class_boundaries(content, class_name)
        if start_pos != -1:
            class_positions.append((start_pos, end_pos, class_name))
            print(f"Found class to remove: {class_name} at positions {start_pos}-{end_pos}")
        else:
            print(f"Class not found in target file: {class_name}")
    
    # Sort by start position in reverse order
    class_positions.sort(key=lambda x: x[0], reverse=True)
    
    # Remove classes from content
    modified_content = content
    removed_classes = []
    
    for start_pos, end_pos, class_name in class_positions:
        modified_content = modified_content[:start_pos] + modified_content[end_pos:]
        removed_classes.append(class_name)
    
    return modified_content, removed_classes


def clean_formatting(content: str) -> str:
    """
    Clean up any formatting issues in the content.

    Args:
        content: The content to clean

    Returns:
        Cleaned content
    """
    # Remove any orphaned "lass" fragments that might be left from incomplete removals
    content = re.sub(r'^\s*lass\s*\{.*?\}', '', content, flags=re.MULTILINE | re.DOTALL)

    # Fix missing newlines between class closing brace and next class
    content = re.sub(r'(\}\s*)(\s*public\s+class)', r'\1\n    \2', content)

    # Ensure proper spacing before class declarations
    content = re.sub(r'(\}\s*)(public\s+class)', r'\1\n    \2', content)

    # Remove multiple consecutive empty lines (more than 2)
    content = re.sub(r'\n\s*\n\s*\n\s*\n+', '\n\n', content)

    # Fix malformed class declarations - handle various truncation patterns
    content = re.sub(r'(\}\s*)c\s+class\s+([A-Za-z_][A-Za-z0-9_]*)', r'\1\n    public class \2', content)
    content = re.sub(r'(\}\s*)ublic\s+class\s+([A-Za-z_][A-Za-z0-9_]*)', r'\1\n    public class \2', content)
    content = re.sub(r'^\s*public\s+c\s+([A-Za-z_][A-Za-z0-9_]*)', r'    public class \1', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*c\s+class\s+([A-Za-z_][A-Za-z0-9_]*)', r'    public class \1', content, flags=re.MULTILINE)
    content = re.sub(r'^\s*ublic\s+class\s+([A-Za-z_][A-Za-z0-9_]*)', r'    public class \1', content, flags=re.MULTILINE)

    # Ensure consistent indentation for class declarations
    content = re.sub(r'^(\s*)public\s+class\s+([A-Za-z_][A-Za-z0-9_]*)', r'    public class \2', content, flags=re.MULTILINE)

    return content


def replace_class_references(content: str, original_class_name: str, new_class_name: str) -> str:
    """
    Replace all references to the original class name with the new class name.

    Args:
        content: The file content
        original_class_name: The original class name to replace
        new_class_name: The new class name to use

    Returns:
        Content with class name references updated
    """
    # Replace the main class declaration
    content = re.sub(
        rf'^public class {re.escape(original_class_name)}\s*\{{',
        f'public class {new_class_name} {{',
        content,
        flags=re.MULTILINE
    )

    # Replace references in type declarations (e.g., soapSforceCom200604Metadata.ClassName)
    content = re.sub(
        rf'\b{re.escape(original_class_name)}\.([A-Za-z_][A-Za-z0-9_]*)',
        rf'{new_class_name}.\1',
        content
    )

    # Replace standalone references to the class name
    content = re.sub(
        rf'\b{re.escape(original_class_name)}\b',
        new_class_name,
        content
    )

    return content


def main():
    """Main function to execute the class removal process."""

    # Parse command line arguments
    import argparse
    parser = argparse.ArgumentParser(description='Remove MetadataCore classes from soapSforceCom200604Metadata.cls')
    parser.add_argument('--output-class-name', '-o',
                       default='soapSforceCom200604Metadata_CustomObjects',
                       help='Name for the output class (default: soapSforceCom200604Metadata_CustomObjects)')
    parser.add_argument('--output-file', '-f',
                       help='Output file path (default: based on class name)')

    args = parser.parse_args()

    # File paths
    metadata_core_path = "../apex-mdapi/src/classes/MetadataCore.cls"
    soap_metadata_path = "../soapSforceCom200604Metadata.cls"

    # Determine output file path
    if args.output_file:
        output_path = args.output_file
    else:
        output_path = f"../{args.output_class_name}.cls"
    
    # Check if files exist
    if not os.path.exists(metadata_core_path):
        print(f"Error: MetadataCore.cls not found at {metadata_core_path}")
        sys.exit(1)
        
    if not os.path.exists(soap_metadata_path):
        print(f"Error: soapSforceCom200604Metadata.cls not found at {soap_metadata_path}")
        sys.exit(1)
    
    print("Extracting class names from MetadataCore.cls...")
    metadata_core_classes = extract_class_names_from_file(metadata_core_path)
    print(f"Found {len(metadata_core_classes)} classes in MetadataCore.cls")
    
    print("Reading soapSforceCom200604Metadata.cls...")
    try:
        with open(soap_metadata_path, 'r', encoding='utf-8') as file:
            soap_content = file.read()
    except Exception as e:
        print(f"Error reading {soap_metadata_path}: {e}")
        sys.exit(1)
    
    print("Removing classes that exist in MetadataCore.cls...")
    modified_content, removed_classes = remove_classes_from_content(soap_content, metadata_core_classes)

    print("Cleaning up formatting...")
    modified_content = clean_formatting(modified_content)
    
    print(f"Removed {len(removed_classes)} classes:")
    for class_name in sorted(removed_classes):
        print(f"  - {class_name}")
    
    # Update all class name references in the modified content
    print(f"Updating class name references to {args.output_class_name}...")
    modified_content = replace_class_references(modified_content, 'soapSforceCom200604Metadata', args.output_class_name)
    
    print(f"Writing modified content to {output_path}...")
    try:
        with open(output_path, 'w', encoding='utf-8') as file:
            file.write(modified_content)
        print(f"Successfully created {output_path}")
    except Exception as e:
        print(f"Error writing to {output_path}: {e}")
        sys.exit(1)
    
    print("\nSummary:")
    print(f"- Original classes in soapSforceCom200604Metadata.cls: {len(re.findall(r'public class [A-Za-z_][A-Za-z0-9_]*', soap_content)) - 1}")
    print(f"- Classes removed: {len(removed_classes)}")
    print(f"- Remaining classes in output file: {len(re.findall(r'public class [A-Za-z_][A-Za-z0-9_]*', modified_content)) - 1}")
    print(f"- Output class name: {args.output_class_name}")
    print(f"- Output file: {output_path}")

    print("\nUsage examples:")
    print("  python remove_metadata_core_classes.py")
    print("  python remove_metadata_core_classes.py --output-class-name CustomObjectsMetadata")
    print("  python remove_metadata_core_classes.py -o MyCustomClass -f ../MyCustomClass.cls")


if __name__ == "__main__":
    main()
