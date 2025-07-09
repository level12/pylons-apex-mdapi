#!/usr/bin/env python3
"""
Script to extract type definitions and their dependencies from metadata.xml
and add them to a copy of base.xml for WSDL to Apex class generation.

This script reads the list of types to process from types.json file.

Usage: python extract_types.py [output_file]
"""

import sys
import re
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Set, Dict, List, Optional
import shutil

class TypeExtractor:
    def __init__(self, metadata_file: str, base_file: str):
        self.metadata_file = Path(metadata_file)
        self.base_file = Path(base_file)
        self.namespace = "http://soap.sforce.com/2006/04/metadata"
        self.tns_prefix = "tns:"
        
        # Parse metadata.xml
        self.metadata_tree = ET.parse(self.metadata_file)
        self.metadata_root = self.metadata_tree.getroot()
        
        # Find the schema element
        self.schema = self._find_schema_element()
        
        # Cache for found types
        self.type_definitions: Dict[str, ET.Element] = {}
        self.found_dependencies: Set[str] = set()
        
        # Build type cache
        self._build_type_cache()

    def get_types_list(self) -> List[str]:
        """Get the hardcoded list of types to process"""
        return [
            "CustomObject",
            "CustomAddressFieldSettings"
        ]
    
    def _find_schema_element(self) -> ET.Element:
        """Find the xsd:schema element in metadata.xml"""
        for elem in self.metadata_root.iter():
            if elem.tag.endswith('}schema') or elem.tag == 'schema':
                return elem
        raise ValueError("Could not find xsd:schema element in metadata.xml")
    
    def _build_type_cache(self):
        """Build a cache of all type definitions in metadata.xml"""
        for elem in self.schema.iter():
            if elem.tag.endswith('}complexType') or elem.tag.endswith('}simpleType'):
                name = elem.get('name')
                if name:
                    self.type_definitions[name] = elem
    
    def _extract_type_references(self, element: ET.Element) -> Set[str]:
        """Extract all tns: type references from an element and its children"""
        references = set()
        
        # Check all attributes for type references
        for attr_value in element.attrib.values():
            if attr_value.startswith(self.tns_prefix):
                type_name = attr_value[len(self.tns_prefix):]
                references.add(type_name)
        
        # Recursively check child elements
        for child in element:
            references.update(self._extract_type_references(child))
        
        return references
    
    def find_dependencies(self, type_name: str) -> Set[str]:
        """Find all dependencies for a given type recursively"""
        if type_name in self.found_dependencies:
            return set()
        
        if type_name not in self.type_definitions:
            print(f"Warning: Type '{type_name}' not found in metadata.xml")
            return set()
        
        self.found_dependencies.add(type_name)
        dependencies = set()
        
        # Get the type definition
        type_def = self.type_definitions[type_name]
        
        # Extract all type references from this definition
        references = self._extract_type_references(type_def)
        
        # Recursively find dependencies
        for ref in references:
            if ref not in self.found_dependencies:
                dependencies.add(ref)
                dependencies.update(self.find_dependencies(ref))
        
        return dependencies
    
    def get_type_definition_xml(self, type_name: str) -> Optional[str]:
        """Get the XML string for a type definition with proper indentation"""
        if type_name not in self.type_definitions:
            return None

        elem = self.type_definitions[type_name]

        # Convert element to string with proper formatting
        xml_str = ET.tostring(elem, encoding='unicode')

        # Clean up the XML formatting
        xml_str = xml_str.replace('><', '>\n<')

        # Add proper indentation (4 spaces for schema content)
        lines = xml_str.split('\n')
        indented_lines = []
        base_indent = '    '  # Base indentation for schema content

        for line in lines:
            stripped = line.strip()
            if not stripped:
                continue

            # Calculate additional indentation based on nesting
            if stripped.startswith('</'):
                # Closing tag - reduce indent
                indent_level = max(0, line.count('<') - line.count('</') - 1)
            elif stripped.startswith('<') and not stripped.endswith('/>') and '>' not in stripped[1:]:
                # Opening tag
                indent_level = line.count('<') - line.count('</')
            else:
                # Content or self-closing tag
                indent_level = max(0, line.count('<') - line.count('</'))

            # Apply indentation
            full_indent = base_indent + ('     ' * indent_level)
            indented_lines.append(full_indent + stripped)

        return '\n'.join(indented_lines)

    def create_output_file_from_types(self, output_file: Optional[str] = None) -> str:
        """Create output XML file with types from hardcoded list"""
        types_list = self.get_types_list()

        if output_file is None:
            output_file = "output.xml"

        output_path = Path(output_file)

        # Copy base.xml to output file
        shutil.copy2(self.base_file, output_path)

        # Find all dependencies for all types
        print(f"Processing {len(types_list)} types from hardcoded list:")
        for type_name in types_list:
            print(f"  - {type_name}")

        self.found_dependencies.clear()  # Reset for fresh search
        all_dependencies = set()

        for type_name in types_list:
            print(f"\nFinding dependencies for: {type_name}")
            dependencies = self.find_dependencies(type_name)
            dependencies.add(type_name)  # Include the main type
            all_dependencies.update(dependencies)
            print(f"  Found {len(dependencies)} dependencies for {type_name}")

        print(f"\nTotal unique types to add: {len(all_dependencies)}")
        for dep in sorted(all_dependencies):
            print(f"  - {dep}")

        # Parse the output file and add types
        self._add_types_to_file(output_path, all_dependencies)

        print(f"\nCreated output file: {output_path}")
        print(f"Added {len(all_dependencies)} type definitions")

        return str(output_path)



    def _add_types_to_file(self, output_path: Path, dependencies: Set[str]):
        """Add type definitions to the XML file"""
        # Parse the output file
        tree = ET.parse(output_path)
        root = tree.getroot()

        # Find the schema element and the closing </xsd:schema> tag location
        schema_elem = None
        for elem in root.iter():
            if elem.tag.endswith('}schema') or elem.tag == 'schema':
                schema_elem = elem
                break

        if schema_elem is None:
            raise ValueError("Could not find xsd:schema element in base.xml")

        # Read the file content to insert types before </xsd:schema>
        with open(output_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Find the position to insert new types (before </xsd:schema>)
        schema_end_pattern = r'(\s*)</xsd:schema>'
        match = re.search(schema_end_pattern, content)

        if not match:
            raise ValueError("Could not find </xsd:schema> closing tag")

        # Build the types XML to insert
        types_xml = []
        for type_name in sorted(dependencies):
            type_xml = self.get_type_definition_xml(type_name)
            if type_xml:
                types_xml.append(type_xml)

        # Insert the types before </xsd:schema>
        insert_pos = match.start(1)
        new_content = (
            content[:insert_pos] +
            '\n'.join(types_xml) + '\n' +
            content[insert_pos:]
        )

        # Write the updated content
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(new_content)

def main():
    # Handle special commands
    if len(sys.argv) > 1 and sys.argv[1] == "--help":
        print("Type Extractor for Salesforce Metadata WSDL")
        print("=" * 50)
        print("This script extracts type definitions and their dependencies from metadata.xml")
        print("and adds them to a copy of base.xml for WSDL to Apex class generation.")
        print()
        print("The script processes a hardcoded list of types.")
        print()
        print("Usage:")
        print("  python extract_types.py [output_file]")
        print("  python extract_types.py --list-types")
        print("  python extract_types.py --help")
        print()
        print("Examples:")
        print("  python extract_types.py")
        print("  python extract_types.py my_output.xml")
        print("  python extract_types.py --list-types | grep -i deploy")
        sys.exit(0)

    # Default file paths
    metadata_file = "./metadata.xml"
    base_file = "./base.xml"

    # Check if files exist
    if not Path(metadata_file).exists():
        print(f"Error: metadata.xml not found at {metadata_file}")
        sys.exit(1)

    if not Path(base_file).exists():
        print(f"Error: base.xml not found at {base_file}")
        sys.exit(1)

    try:
        extractor = TypeExtractor(metadata_file, base_file)

        # Handle --list-types command
        if len(sys.argv) > 1 and sys.argv[1] == "--list-types":
            print("Available types in metadata.xml:")
            print("=" * 40)
            for type_name in sorted(extractor.type_definitions.keys()):
                print(f"  {type_name}")
            print(f"\nTotal: {len(extractor.type_definitions)} types")
            sys.exit(0)

        # Default behavior: process types from hardcoded list
        output_file = sys.argv[1] if len(sys.argv) > 1 and sys.argv[1] != "--list-types" else None

        output_path = extractor.create_output_file_from_types(output_file)
        print(f"\nSuccess! Output written to: {output_path}")

    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
