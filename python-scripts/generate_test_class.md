# Generate Test Class Script

## Overview

This Python script automatically generates comprehensive test classes for Apex classes by parsing the main class file, extracting all inner class names, and creating test methods with instantiation coverage for all classes. This is particularly useful for testing large generated classes like those created from WSDL-to-Apex conversions.

## Purpose

When working with large Apex classes containing many inner classes (like Salesforce Metadata API classes), manually creating test coverage can be time-consuming and error-prone. This script helps you:

- **Automate test creation** for classes with many inner classes
- **Ensure complete coverage** of all class instantiations
- **Generate maintainable test code** with proper structure and assertions
- **Save development time** on repetitive test writing
- **Follow Salesforce testing best practices** with proper test structure

## Features

- ✅ **Automatic class detection** - Finds main class and all inner classes
- ✅ **Comprehensive test coverage** - Creates tests for every class found
- ✅ **Chunked test methods** - Breaks large class lists into manageable test methods
- ✅ **Proper assertions** - Includes `System.assertNotEquals` for each instantiation
- ✅ **Configurable output** - Custom test class names and file paths
- ✅ **Test setup support** - Optional `@TestSetup` method generation
- ✅ **Governor limit friendly** - Prevents CPU/heap limit issues with large classes
- ✅ **Clean formatting** - Generates properly formatted, readable Apex code

## Requirements

- Python 3.6+
- Input Apex class file (e.g., `MetadataCore.cls`)

## Usage

### Basic Usage

```bash
# Generate test for MetadataCore.cls (default)
python generate_test_class.py
```

### Custom Input File

```bash
# Test a specific class file
python generate_test_class.py --input-file ../MyCustomClass.cls
python generate_test_class.py -i ../MyCustomClass.cls
```

### Custom Test Class Name

```bash
# Specify custom test class name
python generate_test_class.py --test-class-name MyCustomTest
python generate_test_class.py -t MyCustomTest
```

### Custom Output Location

```bash
# Specify output file path
python generate_test_class.py --output-file ../tests/MyTest.cls
python generate_test_class.py -o ../tests/MyTest.cls

# Specify output directory
python generate_test_class.py --output-dir ../tests/
python generate_test_class.py -d ../tests/
```

### Advanced Options

```bash
# Skip @TestSetup method generation
python generate_test_class.py --no-setup

# Control classes per test method (default: 20)
python generate_test_class.py --classes-per-method 15
python generate_test_class.py -c 15

# Combined options
python generate_test_class.py -i ../CustomObjects.cls -t CustomObjectsTest -d ../tests/ --no-setup -c 10
```

## Command Line Options

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--input-file` | `-i` | Input Apex class file path | `../apex-mdapi/src/classes/MetadataCore.cls` |
| `--test-class-name` | `-t` | Name for the test class | `{MainClass}Test` |
| `--output-file` | `-o` | Output test file path | `{output-dir}/{test-class-name}.cls` |
| `--output-dir` | `-d` | Output directory for test file | `../apex-mdapi/src/classes/` |
| `--no-setup` | - | Skip generating @TestSetup method | Include setup |
| `--classes-per-method` | `-c` | Classes to test per method | 20 |
| `--help` | `-h` | Show help message | - |

## Generated Test Structure

The script generates a test class with the following structure:

### 1. Test Setup (Optional)
```apex
@TestSetup
static void setupTestData() {
    // Add any test data setup here if needed
    // Use TestDataFactory methods for creating test records
}
```

### 2. Main Class Test
```apex
@IsTest
private static void testMainClass() {
    Test.startTest();
    
    // Test main class instantiation
    MetadataCore mainInstance = new MetadataCore();
    System.assertNotEquals(null, mainInstance, 'Main class should be instantiated');
    
    Test.stopTest();
}
```

### 3. Inner Class Tests (Chunked)
```apex
@IsTest
private static void coverGeneratedCodeTypes() {
    Test.startTest();
    
    // Test inner class instantiations
    MetadataCore.AllOrNoneHeader_element allornoneheader_elementInstance = new MetadataCore.AllOrNoneHeader_element();
    System.assertNotEquals(null, allornoneheader_elementInstance, 'AllOrNoneHeader_element should be instantiated');
    
    MetadataCore.AsyncResult asyncresultInstance = new MetadataCore.AsyncResult();
    System.assertNotEquals(null, asyncresultInstance, 'AsyncResult should be instantiated');
    
    // ... more classes (up to 20 per method)
    
    Test.stopTest();
}
```

## Why Separate Test Methods?

The script breaks large class lists into separate test methods for several important reasons:

### Salesforce Governor Limits
- **CPU Time**: Each method gets fresh CPU time allowance
- **Heap Size**: Separate heap space allocation per method
- **Timeout Prevention**: Reduces risk of test timeouts

### Test Execution Benefits
- **Parallel Execution**: Methods can run in parallel for faster execution
- **Failure Isolation**: Issues in one group don't fail the entire test
- **Better Debugging**: Easier to identify which classes cause problems

### Code Quality
- **Readability**: Keeps methods manageable (20 classes = ~40-50 lines)
- **Maintenance**: Easier to understand and modify
- **Best Practices**: Follows Salesforce testing recommendations

## Example Output

```
Parsing ../apex-mdapi/src/classes/MetadataCore.cls...
Found main class: MetadataCore
Found inner class: AllOrNoneHeader_element
Found inner class: AsyncResult
Found inner class: CallOptions_element
...
Found inner class: upsertMetadata_element

Generating test class MetadataCoreTest...
Writing test class to ../apex-mdapi/src/classes/MetadataCoreTest.cls...
Successfully created ../apex-mdapi/src/classes/MetadataCoreTest.cls

Summary:
- Main class: MetadataCore
- Inner classes found: 70
- Test class name: MetadataCoreTest
- Output file: ../apex-mdapi/src/classes/MetadataCoreTest.cls
- Test methods generated: 5
```

## Use Cases

### Testing Generated WSDL Classes
```bash
python generate_test_class.py -i ../MetadataCore.cls -t MetadataCoreTest
```

### Testing Custom Object Classes
```bash
python generate_test_class.py -i ../CustomObjectsMetadata.cls -t CustomObjectsTest
```

### Testing with Custom Setup
```bash
python generate_test_class.py -i ../WorkflowMetadata.cls -t WorkflowTest -d ../tests/ -c 15
```

## File Structure

```
python-scripts/
├── generate_test_class.py                    # Main script
├── README_generate_test_class.md            # This file
../apex-mdapi/src/classes/
├── MetadataCore.cls                         # Input file (example)
├── MetadataCoreTest.cls                     # Generated output
└── {CustomClassName}Test.cls                # Other generated tests
```

## Best Practices

### For Large Classes (50+ inner classes)
- Use default chunking (20 classes per method)
- Include test setup for any required test data
- Consider running tests in smaller batches during development

### For Smaller Classes (< 30 inner classes)
- Can use larger chunks: `-c 30`
- Single method approach would also work

### Test Data Requirements
- Use the generated `@TestSetup` method for any required test records
- Leverage TestDataFactory classes for consistent test data
- Remember that these tests focus on instantiation, not business logic

## Troubleshooting

**Issue**: "No classes found" error
- **Solution**: Verify the input file path and that it contains valid Apex classes

**Issue**: Test methods failing in Salesforce
- **Solution**: Check if any inner classes require specific initialization or dependencies

**Issue**: CPU timeout in generated tests
- **Solution**: Reduce classes per method using `-c` option (try 10-15)

**Issue**: Output file permission errors
- **Solution**: Ensure you have write permissions to the output directory

## Related Scripts

This script works well with other metadata processing scripts:
- `remove_metadata_core_classes.py` - For creating focused class files
- XML metadata parsers - For processing metadata definitions
- Type extraction scripts - For analyzing class dependencies
