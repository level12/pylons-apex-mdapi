#!/usr/bin/env python3
"""
Script to generate a comprehensive test class for Apex classes.
Parses the main class file, extracts all inner class names, and creates
a test class with instantiation coverage for all classes.
"""

import re
import os
import sys
from typing import Set, List


def extract_all_class_names(file_path: str) -> tuple[str, Set[str]]:
    """
    Extract the main class name and all inner class names from an Apex class file.
    
    Args:
        file_path: Path to the Apex class file
        
    Returns:
        Tuple of (main_class_name, set_of_inner_class_names)
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
            
        # Pattern to match class declarations
        pattern = r'^\s*public\s+class\s+([A-Za-z_][A-Za-z0-9_]*)\s*\{'
        
        matches = list(re.finditer(pattern, content, re.MULTILINE))
        
        if not matches:
            print(f"Error: No classes found in {file_path}")
            sys.exit(1)
        
        # First class is the main class
        main_class_name = matches[0].group(1)
        print(f"Found main class: {main_class_name}")
        
        # Remaining classes are inner classes
        inner_classes = set()
        for match in matches[1:]:
            class_name = match.group(1)
            inner_classes.add(class_name)
            print(f"Found inner class: {class_name}")
            
    except FileNotFoundError:
        print(f"Error: File {file_path} not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file {file_path}: {e}")
        sys.exit(1)
        
    return main_class_name, inner_classes


def generate_test_class_content(main_class_name: str, inner_classes: Set[str], test_class_name: str,
                              include_setup: bool = True) -> str:
    """
    Generate the content for a test class.

    Args:
        main_class_name: Name of the main class being tested
        inner_classes: Set of inner class names
        test_class_name: Name for the test class
        include_setup: Whether to include test setup method

    Returns:
        Generated test class content
    """
    # Sort classes for consistent output
    sorted_classes = sorted(inner_classes)

    # Calculate how many classes per test method (max ~20 for readability)
    classes_per_method = 20
    class_chunks = [sorted_classes[i:i + classes_per_method]
                   for i in range(0, len(sorted_classes), classes_per_method)]

    content = f"""//Generated test class for {main_class_name}

@IsTest
public class {test_class_name} {{
"""

    # Add test setup method if requested
    if include_setup:
        content += """
    @TestSetup
    static void setupTestData() {
        // Add any test data setup here if needed
        // Use TestDataFactory methods for creating test records
    }
"""

    # Main class test
    content += f"""
    @IsTest
    private static void testMainClass() {{
        Test.startTest();

        // Test main class instantiation
        {main_class_name} mainInstance = new {main_class_name}();
        System.assertNotEquals(null, mainInstance, 'Main class should be instantiated');

        Test.stopTest();
    }}
"""

    # Generate test methods for inner classes
    for i, chunk in enumerate(class_chunks, 1):
        method_name = f"coverGeneratedCodeTypes{i}" if i > 1 else "coverGeneratedCodeTypes"

        content += f"""
    @IsTest
    private static void {method_name}() {{
        Test.startTest();

        // Test inner class instantiations
"""

        # Add instantiation for each class in the chunk
        for class_name in chunk:
            content += f"        {main_class_name}.{class_name} {class_name.lower()}Instance = new {main_class_name}.{class_name}();\n"
            content += f"        System.assertNotEquals(null, {class_name.lower()}Instance, '{class_name} should be instantiated');\n"

        content += """
        Test.stopTest();
    }
"""

    content += "}\n"

    return content


def main():
    """Main function to execute the test class generation."""
    
    # Parse command line arguments
    import argparse
    parser = argparse.ArgumentParser(description='Generate test class for Apex classes')
    parser.add_argument('--input-file', '-i', 
                       default='../apex-mdapi/src/classes/MetadataCore.cls',
                       help='Input Apex class file path')
    parser.add_argument('--test-class-name', '-t',
                       help='Name for the test class (default: {MainClass}Test)')
    parser.add_argument('--output-file', '-o',
                       help='Output test file path (default: based on test class name)')
    parser.add_argument('--output-dir', '-d',
                       default='../apex-mdapi/src/classes/',
                       help='Output directory for test file')
    parser.add_argument('--no-setup', action='store_true',
                       help='Skip generating @TestSetup method')
    parser.add_argument('--classes-per-method', '-c', type=int, default=20,
                       help='Number of classes to test per method (default: 20)')
    
    args = parser.parse_args()
    
    # Check if input file exists
    if not os.path.exists(args.input_file):
        print(f"Error: Input file {args.input_file} not found")
        sys.exit(1)
    
    print(f"Parsing {args.input_file}...")
    main_class_name, inner_classes = extract_all_class_names(args.input_file)
    
    # Determine test class name
    if args.test_class_name:
        test_class_name = args.test_class_name
    else:
        test_class_name = f"{main_class_name}Test"
    
    # Determine output file path
    if args.output_file:
        output_path = args.output_file
    else:
        output_path = os.path.join(args.output_dir, f"{test_class_name}.cls")
    
    print(f"Generating test class {test_class_name}...")
    test_content = generate_test_class_content(
        main_class_name,
        inner_classes,
        test_class_name,
        include_setup=not args.no_setup
    )
    
    print(f"Writing test class to {output_path}...")
    try:
        # Ensure output directory exists
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        
        with open(output_path, 'w', encoding='utf-8') as file:
            file.write(test_content)
        print(f"Successfully created {output_path}")
    except Exception as e:
        print(f"Error writing to {output_path}: {e}")
        sys.exit(1)
    
    print("\nSummary:")
    print(f"- Main class: {main_class_name}")
    print(f"- Inner classes found: {len(inner_classes)}")
    print(f"- Test class name: {test_class_name}")
    print(f"- Output file: {output_path}")
    print(f"- Test methods generated: {(len(inner_classes) + 19) // 20 + 1}")  # +1 for main class test
    
    print("\nUsage examples:")
    print("  python generate_test_class.py")
    print("  python generate_test_class.py -i ../MyClass.cls -t MyClassTest")
    print("  python generate_test_class.py -i ../MyClass.cls -o ../tests/MyClassTest.cls")
    print("  python generate_test_class.py --no-setup -c 15")
    print("  python generate_test_class.py -i ../CustomObjects.cls -t CustomObjectsTest -d ../tests/")


if __name__ == "__main__":
    main()
