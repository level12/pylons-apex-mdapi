

## Download WSDL from Salesforce
1) Open the setup menu
2) Search for and select `API`
3) Click on `Generate Metadata WSDL`


## Prep WSDL for conversion

**Change Port Name**
Change from Metadata to MetadataPort

``` XML
<port binding="tns:MetadataBinding" name="MetadataPort">
   <soap:address location="https://login.salesforce.com/services/Soap/m/64.0"/>
</port>
```

**Add Custom Field Property**
Find the custom field complex type and add the following property

``` XML
<xs:complexType name="CustomField">
   <xs:complexContent>
      <xs:extension base="tns:Field">
         <xs:sequence>
            <xsd:element name="displayLocationInDecimal" minOccurs="0" type="xsd:boolean"/>
            <!-- Other Elements -->
         </xs:sequence>
      </xs:extension>
   </xs:complexContent>
</xs:complexType>
```

**Add History Retention Policy**

``` XML
<xs:complexType name="HistoryRetentionPolicy">
   <xs:sequence>
      <xs:element name="gracePeriodDays" type="xsd:int" minOccurs="0"/>
      <!-- Other Properties -->
   </xs:sequence>
</xs:complexType>
```

**Change Custom Metadata Value Type**
Change the type to `string`
``` xml
<xsd:complexType name="CustomMetadataValue">
    <xsd:sequence>
     <xsd:element name="field" type="xsd:string"/>
     <!-- <xsd:element name="value" type="xsd:anyType" nillable="true"/> -->
    </xsd:sequence>
</xsd:complexType>
```

**Change Custom Field Value Type**
Change the type to `string`
``` xml
<xsd:complexType name="FieldValue">
    <xsd:sequence>
     <xsd:element name="field" type="xsd:string"/>
     <!-- <xsd:element name="value" type="xsd:anyType" nillable="true"/> -->
    </xsd:sequence>
</xsd:complexType>
```

## Create Targeted WSDL
1) Update the `get_types_list()` method in the python script to include the types you want to support. This script will recursivly find all dependencies for the types you specify 
2) Execute the python script to extract the types you need from the WSDL. `python extract_types.py output.xml`


## Convert WSDL to Apex
1) Install the WSDL2Apex tool. `mvn install package -Dgpg.skip=true -DskipTests`
2) Execute the tool to generate the apex class. `java -jar WSDL2Apex-1.0.jar output.xml MetadataService no`

## Prep Generated Apex Class
When your are creating a dedicated class for a specific purpose, you will want to remove any classes that are not needed. This will remove all classes that are in the `MetadataCore.cls` file.
1) Execute the python script to remove the classes you don't need. `python remove_metadata_core_classes.py -o <OutputClassName>`

## Update repo classes from output class
1) update the python script `apex_class_replacer.py` with the new class name you want to update to.
2) Execute the python script to update the repo classes. `python apex_class_replacer.py <OutputClassName from WSDL2Apex> <TargetClassName>`

## Update Test Class for service classes
1) Execute the python script to generate the test class. `python generate_test_class.py -i <TargetClassName> -t <TargetClassName>Test`
