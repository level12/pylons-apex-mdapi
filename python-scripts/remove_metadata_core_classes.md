# Remove Metadata Core Classes Script

## Overview

This Python script removes all classes from `soapSforceCom200604Metadata.cls` that already exist in `MetadataCore.cls`, creating a dedicated purpose-driven class for Custom Objects and their dependencies. This allows you to create focused, smaller classes instead of working with one large consolidated file.

## Purpose

When working with Salesforce Metadata API WSDL-to-Apex conversions, you often end up with large consolidated classes containing many metadata types. This script helps you:

- **Extract specific functionality** by removing duplicate classes
- **Create dedicated purpose-driven classes** (e.g., Custom Objects only)
- **Reduce file size** and improve maintainability
- **Avoid class name conflicts** between different metadata API classes

## Features

- ✅ **Automatic class detection** - Finds all inner classes in MetadataCore.cls
- ✅ **Safe class removal** - Removes matching classes from the target file
- ✅ **Configurable output** - Specify custom class names and file paths
- ✅ **Reference replacement** - Updates all class name references throughout the file
- ✅ **Formatting cleanup** - Fixes any formatting issues from class removal
- ✅ **Detailed reporting** - Shows what was removed and what remains

## Requirements

- Python 3.6+
- Input files:
  - `../apex-mdapi/src/classes/MetadataCore.cls`
  - `../soapSforceCom200604Metadata.cls`

## Usage

### Basic Usage

```bash
# Default behavior - creates soapSforceCom200604Metadata_CustomObjects.cls
python remove_metadata_core_classes.py
```

### Custom Class Name

```bash
# Specify a custom output class name
python remove_metadata_core_classes.py --output-class-name CustomObjectsAPI
python remove_metadata_core_classes.py -o CustomObjectsAPI
```

### Custom Output File

```bash
# Specify custom output file path
python remove_metadata_core_classes.py --output-file ../MyCustomClass.cls
python remove_metadata_core_classes.py -f ../MyCustomClass.cls
```

### Combined Options

```bash
# Custom class name and file location
python remove_metadata_core_classes.py -o MetadataCustomObjects -f ../apex-mdapi/src/classes/MetadataCustomObjects.cls
```

## Command Line Options

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--output-class-name` | `-o` | Name for the output class | `soapSforceCom200604Metadata_CustomObjects` |
| `--output-file` | `-f` | Output file path | `../{class_name}.cls` |
| `--help` | `-h` | Show help message | - |

## How It Works

1. **Class Detection**: Scans `MetadataCore.cls` to find all inner class names
2. **Class Removal**: Removes matching classes from `soapSforceCom200604Metadata.cls`
3. **Reference Updates**: Replaces all references to the original class name with your specified name
4. **Formatting Cleanup**: Fixes any formatting issues caused by class removal
5. **Output Generation**: Creates a clean, properly formatted output file

## Example Output

```
Extracting class names from MetadataCore.cls...
Skipping main class: MetadataCore
Found inner class: AllOrNoneHeader_element
Found inner class: AsyncResult
...
Found 70 classes in MetadataCore.cls

Reading soapSforceCom200604Metadata.cls...
Removing classes that exist in MetadataCore.cls...
Found class to remove: AllOrNoneHeader_element at positions 15234-15456
Found class to remove: AsyncResult at positions 23456-24567
...
Removed 45 classes:
  - AllOrNoneHeader_element
  - AsyncResult
  - CallOptions_element
  ...

Cleaning up formatting...
Updating class name references to CustomObjectsAPI...
Writing modified content to ../CustomObjectsAPI.cls...
Successfully created ../CustomObjectsAPI.cls

Summary:
- Original classes in soapSforceCom200604Metadata.cls: 104
- Classes removed: 45
- Remaining classes in output file: 59
- Output class name: CustomObjectsAPI
- Output file: ../CustomObjectsAPI.cls
```

## Use Cases

### Creating Custom Objects Class
```bash
python remove_metadata_core_classes.py -o MetadataCustomObjects
```

### Creating Workflow Class
```bash
python remove_metadata_core_classes.py -o MetadataWorkflows -f ../MetadataWorkflows.cls
```

### Creating Reports Class
```bash
python remove_metadata_core_classes.py -o MetadataReports
```

## File Structure

```
python-scripts/
├── remove_metadata_core_classes.py    # Main script
├── README_remove_metadata_core_classes.md    # This file
../
├── apex-mdapi/src/classes/MetadataCore.cls   # Source file (classes to remove)
├── soapSforceCom200604Metadata.cls           # Target file (classes removed from)
└── {OutputClassName}.cls                     # Generated output file
```

## Error Handling

The script includes comprehensive error handling for:
- Missing input files
- File read/write permissions
- Malformed class declarations
- Formatting issues

## Notes

- The script preserves the original files and creates new output files
- All class name references are automatically updated throughout the file
- The script handles various formatting edge cases that can occur during class removal
- Generated files maintain proper Apex syntax and formatting

## Troubleshooting

**Issue**: Classes not being removed
- **Solution**: Check that class names match exactly between files

**Issue**: Formatting problems in output
- **Solution**: The script includes automatic formatting cleanup

**Issue**: File not found errors
- **Solution**: Ensure you're running from the `python-scripts` directory and input files exist
