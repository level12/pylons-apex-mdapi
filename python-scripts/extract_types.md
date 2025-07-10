# Type Extractor for Salesforce Metadata WSDL

A Python script for extracting specific type definitions and their dependencies from Salesforce metadata WSDL files and creating focused XML files for WSDL2Apex conversion.

## Overview

This script helps you create smaller, focused WSDL files by extracting only the types you need from the complete Salesforce metadata WSDL. This is particularly useful when:

- The full metadata WSDL is too large for WSDL2Apex processing
- You only need specific metadata types for your Apex classes
- You want to reduce compilation time and class size
- You need to work around Salesforce governor limits

## Features

- **Recursive Dependency Resolution**: Automatically finds all dependent types for requested types
- **Smart XML Processing**: Preserves proper XML structure and formatting
- **Type Discovery**: List all available types in the metadata WSDL
- **Flexible Output**: Specify custom output file names
- **Error Handling**: Comprehensive error reporting and validation
- **Clean Integration**: Works seamlessly with existing WSDL2Apex workflows

## Requirements

- Python 3.6+
- No external dependencies (uses only standard library)
- `metadata.xml` - Complete Salesforce metadata WSDL file
- `base.xml` - Base WSDL template file

## File Structure

The script expects these files in the same directory:

```
python-scripts/
├── extract_types.py
├── metadata.xml          # Complete Salesforce metadata WSDL
├── base.xml              # Base WSDL template
└── output.xml            # Generated output (created by script)
```

## Usage

### Basic Usage

```bash
# Extract types using hardcoded list in script
python extract_types.py

# Specify custom output file
python extract_types.py my_custom_output.xml
```

### Discovery Commands

```bash
# List all available types in metadata.xml
python extract_types.py --list-types

# Search for specific types
python extract_types.py --list-types | grep -i deploy

# Get help information
python extract_types.py --help
```

## Configuration

### Adding Types to Extract

Edit the `get_types_list()` method in the script to specify which types to extract:

```python
def get_types_list(self) -> List[str]:
    """Get the hardcoded list of types to process"""
    return [
        'DeployOptions',
        'DeployResult', 
        'AsyncResult',
        'RetrieveRequest',
        'RetrieveResult',
        'Metadata',
        'SaveResult'
    ]
```

### File Paths

By default, the script looks for:
- `./metadata.xml` - Source metadata WSDL
- `./base.xml` - Base template file

These can be modified in the `main()` function if needed.

## How It Works

1. **Parse Metadata**: Loads and parses the complete metadata.xml WSDL file
2. **Build Type Cache**: Creates an index of all available type definitions
3. **Dependency Analysis**: For each requested type, recursively finds all dependencies
4. **XML Generation**: Extracts type definitions with proper formatting
5. **File Creation**: Copies base.xml and inserts the extracted types
6. **Output Generation**: Creates a new WSDL file with only the needed types

## Example Output

When run, the script provides detailed information about the extraction process:

```
Processing 7 types from hardcoded list:
  - DeployOptions
  - DeployResult
  - AsyncResult
  - RetrieveRequest
  - RetrieveResult
  - Metadata
  - SaveResult

Finding dependencies for: DeployOptions
  Found 12 dependencies for DeployOptions

Finding dependencies for: DeployResult
  Found 8 dependencies for DeployResult

...

Total unique types to add: 45
  - AsyncResult
  - CallOptions
  - CodeCoverageResult
  - DeployDetails
  - DeployMessage
  - DeployOptions
  - DeployResult
  ...

Created output file: output.xml
Added 45 type definitions
```

## Integration with WSDL2Apex

After running the script, use the generated XML file with WSDL2Apex:

```bash
# Generate Apex class from extracted types
wsdl2apex output.xml > MetadataServiceCore.cls
```

## Advanced Features

### Type Discovery

Find specific types in the metadata WSDL:

```bash
# Find all deploy-related types
python extract_types.py --list-types | grep -i deploy

# Find all result types  
python extract_types.py --list-types | grep -i result

# Count total available types
python extract_types.py --list-types | wc -l
```

### Dependency Analysis

The script automatically resolves complex dependency chains:

- **Direct Dependencies**: Types referenced in attributes (e.g., `type="tns:SomeType"`)
- **Nested Dependencies**: Types used within complex type definitions
- **Recursive Resolution**: Dependencies of dependencies, preventing circular references
- **Deduplication**: Ensures each type is included only once

## File Format Details

### Input Files

**metadata.xml**: Complete Salesforce metadata WSDL containing all type definitions
**base.xml**: Template WSDL file with basic structure but no type definitions

### Output File

The generated output.xml contains:
- All content from base.xml
- Extracted type definitions inserted before `</xsd:schema>`
- Proper XML formatting and indentation
- All dependencies resolved

## Common Use Cases

### Core Metadata Operations

Extract types for basic metadata operations:

```python
return [
    'Metadata',
    'SaveResult', 
    'DeleteResult',
    'UpsertResult'
]
```

### Deployment Operations

Extract types for deployment workflows:

```python
return [
    'DeployOptions',
    'DeployResult',
    'AsyncResult', 
    'DeployMessage'
]
```

### Retrieve Operations

Extract types for metadata retrieval:

```python
return [
    'RetrieveRequest',
    'RetrieveResult',
    'FileProperties',
    'Package'
]
```

## Troubleshooting

### Common Issues

**"metadata.xml not found"**
- Ensure metadata.xml is in the same directory as the script
- Download the latest metadata WSDL from Salesforce

**"base.xml not found"**  
- Create a base WSDL template file
- Ensure it contains proper WSDL structure with `<xsd:schema>` element

**"Could not find xsd:schema element"**
- Verify the XML files are properly formatted
- Check that namespace declarations are correct

**"Type 'TypeName' not found"**
- Use `--list-types` to see available types
- Check spelling and case sensitivity
- Verify the type exists in your metadata WSDL version

### Debug Tips

1. **Start Small**: Begin with a few core types and add more gradually
2. **Check Dependencies**: Use the output to understand dependency relationships
3. **Validate XML**: Ensure generated XML is well-formed before using with WSDL2Apex
4. **Version Compatibility**: Make sure your metadata.xml matches your Salesforce API version

## Performance Considerations

- **Large WSDLs**: Processing very large metadata files may take several seconds
- **Memory Usage**: The script loads the entire WSDL into memory
- **Dependency Chains**: Complex types with many dependencies will increase output size

## Extending the Script

### Custom Type Lists

Create different configurations for different use cases:

```python
def get_deployment_types(self):
    return ['DeployOptions', 'DeployResult', 'AsyncResult']

def get_retrieve_types(self):
    return ['RetrieveRequest', 'RetrieveResult', 'Package']
```

### External Configuration

Modify the script to read type lists from external files:

```python
def load_types_from_file(self, filename):
    with open(filename, 'r') as f:
        return [line.strip() for line in f if line.strip()]
```

## Best Practices

1. **Version Control**: Keep your type lists in version control
2. **Documentation**: Document why specific types are needed
3. **Testing**: Test generated Apex classes thoroughly
4. **Incremental Updates**: Add types gradually to avoid issues
5. **Backup**: Keep copies of working configurations
