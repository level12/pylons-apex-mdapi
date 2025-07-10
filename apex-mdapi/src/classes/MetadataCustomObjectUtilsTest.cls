//Generated test class for MetadataCustomObjectUtils

@IsTest
public class MetadataCustomObjectUtilsTest {

    private class WebServiceMockImpl implements WebServiceMock {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType) {
            
            // Mock implementation for MetadataCore web service calls
            if(request instanceof MetadataCore.createMetadata_element) {
                MetadataCore.createMetadataResponse_element createResponse = new MetadataCore.createMetadataResponse_element();
                MetadataCore.SaveResult saveResult = new MetadataCore.SaveResult();
                saveResult.success = true;
                saveResult.fullName = 'TestObject__c';
                saveResult.errors = null;
                createResponse.result = new List<MetadataCore.SaveResult>{saveResult};
                response.put('response_x', createResponse);
            }
            else if(request instanceof MetadataCore.updateMetadata_element) {
                MetadataCore.updateMetadataResponse_element updateResponse = new MetadataCore.updateMetadataResponse_element();
                MetadataCore.SaveResult saveResult = new MetadataCore.SaveResult();
                saveResult.success = true;
                saveResult.fullName = 'TestObject__c';
                saveResult.errors = null;
                updateResponse.result = new List<MetadataCore.SaveResult>{saveResult};
                response.put('response_x', updateResponse);
            }
            else if(request instanceof MetadataCore.deleteMetadata_element) {
                MetadataCore.deleteMetadataResponse_element deleteResponse = new MetadataCore.deleteMetadataResponse_element();
                MetadataCore.DeleteResult deleteResult = new MetadataCore.DeleteResult();
                deleteResult.success = true;
                deleteResult.fullName = 'TestObject__c';
                deleteResult.errors = null;
                deleteResponse.result = new List<MetadataCore.DeleteResult>{deleteResult};
                response.put('response_x', deleteResponse);
            }
            else if(request instanceof MetadataCore.readMetadata_element) {
                MetadataCore.readMetadataResponse_element readResponse = new MetadataCore.readMetadataResponse_element();
                MetadataCore.ReadResult readResult = new MetadataCore.ReadResult();
                MetadataCustomObject.CustomObject customObject = new MetadataCustomObject.CustomObject();
                customObject.fullName = 'TestObject__c';
                customObject.label = 'Test Object';
                customObject.pluralLabel = 'Test Objects';
                readResult.records = new List<MetadataCore.Metadata>{customObject};
                readResponse.result = readResult;
                response.put('response_x', readResponse);
            }
            return;
        }
    }

    @IsTest
    private static void testConstructorWithMetadataCoreUtils() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        MetadataCoreUtils coreUtils = new MetadataCoreUtils('TestCredential');
        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils(coreUtils);
        
        Test.stopTest();
        
        // Verify the instance was created successfully
        System.assertNotEquals(null, utils, 'MetadataCustomObjectUtils instance should not be null');
    }

    @IsTest
    private static void testConstructorWithNamedCredential() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        String testCredentialName = 'TestMetadataCredential';
        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils(testCredentialName);
        
        Test.stopTest();
        
        // Verify the instance was created successfully
        System.assertNotEquals(null, utils, 'MetadataCustomObjectUtils instance should not be null');
    }

    @IsTest
    private static void testCreateCustomObjectSuccess() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils('TestCredential');
        
        // Create test custom object
        MetadataCustomObject.CustomObject customObject = new MetadataCustomObject.CustomObject();
        customObject.fullName = 'TestObject__c';
        customObject.label = 'Test Object';
        customObject.pluralLabel = 'Test Objects';
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = 'ReadWrite';
        
        // Create name field
        MetadataCustomObject.CustomField nameField = new MetadataCustomObject.CustomField();
        nameField.type_x = 'Text';
        nameField.label = 'Test Name';
        customObject.nameField = nameField;
        
        MetadataCustomObject.CustomObject result = utils.createCustomObject(customObject);
        
        Test.stopTest();
        
        // Verify the result
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals('TestObject__c', result.fullName, 'FullName should match');
        System.assertEquals('Test Object', result.label, 'Label should match');
    }

    @IsTest
    private static void testReadCustomObjectSuccess() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils('TestCredential');
        
        MetadataCustomObject.CustomObject result = utils.readCustomObject('TestObject__c');
        
        Test.stopTest();
        
        // Verify the result
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals('TestObject__c', result.fullName, 'FullName should match');
        System.assertEquals('Test Object', result.label, 'Label should match');
        System.assertEquals('Test Objects', result.pluralLabel, 'PluralLabel should match');
    }

    @IsTest
    private static void testUpdateCustomObjectSuccess() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils('TestCredential');
        
        // Create test custom object for update
        MetadataCustomObject.CustomObject customObject = new MetadataCustomObject.CustomObject();
        customObject.fullName = 'TestObject__c';
        customObject.label = 'Updated Test Object';
        customObject.pluralLabel = 'Updated Test Objects';
        customObject.deploymentStatus = 'Deployed';
        customObject.sharingModel = 'ReadWrite';
        
        MetadataCustomObject.CustomObject result = utils.updateCustomObject(customObject);
        
        Test.stopTest();
        
        // Verify the result
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals('TestObject__c', result.fullName, 'FullName should match');
        System.assertEquals('Updated Test Object', result.label, 'Label should match updated value');
    }

    @IsTest
    private static void testDeleteCustomObjectSuccess() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        Test.startTest();

        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils('TestCredential');

        try {
            utils.deleteCustomObject('TestObject__c');
            // If no exception is thrown, the delete was successful
            System.assert(true, 'Delete operation completed successfully');
        } catch (Exception e) {
            System.assert(false, 'Delete operation should not throw exception: ' + e.getMessage());
        }

        Test.stopTest();
    }

    @IsTest
    private static void testCreateCustomObjectWithError() {
        // Create a mock that returns errors
        Test.setMock(WebServiceMock.class, new ErrorWebServiceMockImpl());
        
        Test.startTest();
        
        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils('TestCredential');
        
        MetadataCustomObject.CustomObject customObject = new MetadataCustomObject.CustomObject();
        customObject.fullName = 'InvalidObject__c';
        
        try {
            utils.createCustomObject(customObject);
            System.assert(false, 'Expected SaveResultException was not thrown');
        } catch (MetadataCoreUtils.SaveResultException e) {
            System.assertNotEquals(null, e.errors, 'Exception should contain error details');
            System.assertEquals(1, e.errors.size(), 'Should have one error wrapper');
        }
        
        Test.stopTest();
    }

    @IsTest
    private static void testUpdateCustomObjectWithError() {
        // Create a mock that returns errors
        Test.setMock(WebServiceMock.class, new ErrorWebServiceMockImpl());
        
        Test.startTest();
        
        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils('TestCredential');
        
        MetadataCustomObject.CustomObject customObject = new MetadataCustomObject.CustomObject();
        customObject.fullName = 'InvalidObject__c';
        
        try {
            utils.updateCustomObject(customObject);
            System.assert(false, 'Expected SaveResultException was not thrown');
        } catch (MetadataCoreUtils.SaveResultException e) {
            System.assertNotEquals(null, e.errors, 'Exception should contain error details');
        }
        
        Test.stopTest();
    }

    @IsTest
    private static void testDeleteCustomObjectWithError() {
        // Create a mock that returns errors
        Test.setMock(WebServiceMock.class, new ErrorWebServiceMockImpl());

        Test.startTest();

        MetadataCustomObjectUtils utils = new MetadataCustomObjectUtils('TestCredential');

        try {
            utils.deleteCustomObject('InvalidObject__c');
            System.assert(false, 'Expected DeleteResultException was not thrown');
        } catch (MetadataCoreUtils.DeleteResultException e) {
            System.assertNotEquals(null, e.errors, 'Exception should contain error details');
        }

        Test.stopTest();
    }

    // Error mock implementation for testing error scenarios
    private class ErrorWebServiceMockImpl implements WebServiceMock {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType) {
            
            if(request instanceof MetadataCore.createMetadata_element) {
                MetadataCore.createMetadataResponse_element createResponse = new MetadataCore.createMetadataResponse_element();
                MetadataCore.SaveResult saveResult = new MetadataCore.SaveResult();
                saveResult.success = false;
                saveResult.fullName = 'InvalidObject__c';
                
                MetadataCore.Error error = new MetadataCore.Error();
                error.message = 'Invalid object definition';
                error.statusCode = 'INVALID_TYPE';
                saveResult.errors = new List<MetadataCore.Error>{error};
                
                createResponse.result = new List<MetadataCore.SaveResult>{saveResult};
                response.put('response_x', createResponse);
            }
            else if(request instanceof MetadataCore.updateMetadata_element) {
                MetadataCore.updateMetadataResponse_element updateResponse = new MetadataCore.updateMetadataResponse_element();
                MetadataCore.SaveResult saveResult = new MetadataCore.SaveResult();
                saveResult.success = false;
                saveResult.fullName = 'InvalidObject__c';
                
                MetadataCore.Error error = new MetadataCore.Error();
                error.message = 'Update failed';
                error.statusCode = 'UPDATE_FAILED';
                saveResult.errors = new List<MetadataCore.Error>{error};
                
                updateResponse.result = new List<MetadataCore.SaveResult>{saveResult};
                response.put('response_x', updateResponse);
            }
            else if(request instanceof MetadataCore.deleteMetadata_element) {
                MetadataCore.deleteMetadataResponse_element deleteResponse = new MetadataCore.deleteMetadataResponse_element();
                MetadataCore.DeleteResult deleteResult = new MetadataCore.DeleteResult();
                deleteResult.success = false;
                deleteResult.fullName = 'InvalidObject__c';

                MetadataCore.Error error = new MetadataCore.Error();
                error.message = 'Delete failed';
                error.statusCode = 'DELETE_FAILED';
                deleteResult.errors = new List<MetadataCore.Error>{error};

                deleteResponse.result = new List<MetadataCore.DeleteResult>{deleteResult};
                response.put('response_x', deleteResponse);
            }
            return;
        }
    }
}
