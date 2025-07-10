//Generated test class for MetadataCoreUtils

@IsTest
public class MetadataCoreUtilsTest {

    private class WebServiceMockImpl implements WebServiceMock {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType) {
            
            // Mock implementation for MetadataCore web service calls
            if(request instanceof MetadataCore.retrieve_element)
                response.put('response_x', new MetadataCore.retrieveResponse_element());
            else if(request instanceof MetadataCore.checkDeployStatus_element)
                response.put('response_x', new MetadataCore.checkDeployStatusResponse_element());
            else if(request instanceof MetadataCore.listMetadata_element)
                response.put('response_x', new MetadataCore.listMetadataResponse_element());
            else if(request instanceof MetadataCore.checkRetrieveStatus_element)
                response.put('response_x', new MetadataCore.checkRetrieveStatusResponse_element());
            else if(request instanceof MetadataCore.describeMetadata_element)
                response.put('response_x', new MetadataCore.describeMetadataResponse_element());
            else if(request instanceof MetadataCore.deploy_element)
                response.put('response_x', new MetadataCore.deployResponse_element());
            else if(request instanceof MetadataCore.createMetadata_element)
                response.put('response_x', new MetadataCore.createMetadataResponse_element());
            else if(request instanceof MetadataCore.updateMetadata_element)
                response.put('response_x', new MetadataCore.updateMetadataResponse_element());
            else if(request instanceof MetadataCore.deleteMetadata_element)
                response.put('response_x', new MetadataCore.deleteMetadataResponse_element());
            else if(request instanceof MetadataCore.upsertMetadata_element)
                response.put('response_x', new MetadataCore.upsertMetadataResponse_element());
            else if(request instanceof MetadataCore.renameMetadata_element)
                response.put('response_x', new MetadataCore.renameMetadataResponse_element());
            else if(request instanceof MetadataCore.cancelDeploy_element)
                response.put('response_x', new MetadataCore.cancelDeployResponse_element());
            else if(request instanceof MetadataCore.deployRecentValidation_element)
                response.put('response_x', new MetadataCore.deployRecentValidationResponse_element());
            else if(request instanceof MetadataCore.describeValueType_element)
                response.put('response_x', new MetadataCore.describeValueTypeResponse_element());
            else if(request instanceof MetadataCore.readMetadata_element)
                response.put('response_x', new MetadataCore.readMetadataResponse_element());
            return;
        }
    }

    @IsTest
    private static void testConstructorWithValidNamedCredential() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        String testCredentialName = 'TestMetadataCredential';
        MetadataCoreUtils utils = new MetadataCoreUtils(testCredentialName);
        
        Test.stopTest();
        
        // Verify the instance was created successfully
        System.assertNotEquals(null, utils, 'MetadataCoreUtils instance should not be null');
        System.assertEquals(testCredentialName, utils.namedCredentialName, 'Named credential name should be set correctly');
        System.assertNotEquals(null, utils.service, 'MetadataPort service should be initialized');
    }

    @IsTest
    private static void testConstructorWithNullNamedCredential() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        Test.startTest();

        try {
            MetadataCoreUtils utils = new MetadataCoreUtils(null);
            System.assert(false, 'Expected IllegalArgumentException was not thrown');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Named credential name cannot be null or empty', e.getMessage(),
                'Exception message should match expected text');
        }

        Test.stopTest();
    }

    @IsTest
    private static void testConstructorWithEmptyNamedCredential() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        Test.startTest();

        try {
            String emptyCredentialName = '';
            MetadataCoreUtils utils = new MetadataCoreUtils(emptyCredentialName);
            System.assert(false, 'Expected IllegalArgumentException was not thrown');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Named credential name cannot be null or empty', e.getMessage(),
                'Exception message should match expected text');
        }

        Test.stopTest();
    }

    @IsTest
    private static void testServiceConfiguration() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        String testCredentialName = 'TestMetadataCredential';
        MetadataCoreUtils utils = new MetadataCoreUtils(testCredentialName);
        
        Test.stopTest();
        
        // Verify service configuration
        MetadataCore.MetadataPort service = utils.service;
        
        // Check endpoint configuration
        String expectedEndpoint = 'callout:' + testCredentialName + '/services/Soap/m/64.0';
        System.assertEquals(expectedEndpoint, service.endpoint_x, 'Endpoint should be configured correctly');
        
        // Check timeout configuration
        System.assertEquals(120000, service.timeout_x, 'Timeout should be set to 120000 milliseconds');
        
        // Check SessionHeader configuration
        System.assertNotEquals(null, service.SessionHeader, 'SessionHeader should be initialized');
        System.assertEquals('{!$Credential.OAuthToken}', service.SessionHeader.sessionId, 'SessionId should be set to credential token');
        
        // Check AllOrNoneHeader configuration
        System.assertNotEquals(null, service.AllOrNoneHeader, 'AllOrNoneHeader should be initialized');
        System.assertEquals(true, service.AllOrNoneHeader.allOrNone, 'AllOrNone should be set to true');
    }

    @IsTest
    private static void testConstructorWithWhitespaceNamedCredential() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        Test.startTest();

        try {
            String whitespaceCredentialName = '   ';
            MetadataCoreUtils utils = new MetadataCoreUtils(whitespaceCredentialName);
            System.assert(false, 'Expected IllegalArgumentException was not thrown');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Named credential name cannot be null or empty', e.getMessage(),
                'Exception message should match expected text');
        }

        Test.stopTest();
    }

    @IsTest
    private static void testConstructorWithValidSpecialCharacterCredential() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        Test.startTest();

        String specialCredentialName = 'Test_Credential-123';
        MetadataCoreUtils utils = new MetadataCoreUtils(specialCredentialName);

        Test.stopTest();

        // Verify the instance was created successfully with special characters
        System.assertNotEquals(null, utils, 'MetadataCoreUtils instance should not be null');
        System.assertEquals(specialCredentialName, utils.namedCredentialName, 'Named credential name should be set correctly');
        System.assertNotEquals(null, utils.service, 'MetadataPort service should be initialized');

        // Verify endpoint includes special characters correctly
        String expectedEndpoint = 'callout:' + specialCredentialName + '/services/Soap/m/64.0';
        System.assertEquals(expectedEndpoint, utils.service.endpoint_x, 'Endpoint should include special characters correctly');
    }

    @IsTest
    private static void testMultipleInstancesWithDifferentCredentials() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        String credential1 = 'Credential1';
        String credential2 = 'Credential2';
        
        MetadataCoreUtils utils1 = new MetadataCoreUtils(credential1);
        MetadataCoreUtils utils2 = new MetadataCoreUtils(credential2);
        
        Test.stopTest();
        
        // Verify both instances are independent
        System.assertNotEquals(utils1, utils2, 'Instances should be different objects');
        System.assertEquals(credential1, utils1.namedCredentialName, 'First instance should have first credential');
        System.assertEquals(credential2, utils2.namedCredentialName, 'Second instance should have second credential');
        
        // Verify services are configured independently
        String expectedEndpoint1 = 'callout:' + credential1 + '/services/Soap/m/64.0';
        String expectedEndpoint2 = 'callout:' + credential2 + '/services/Soap/m/64.0';
        
        System.assertEquals(expectedEndpoint1, utils1.service.endpoint_x, 'First service should have first endpoint');
        System.assertEquals(expectedEndpoint2, utils2.service.endpoint_x, 'Second service should have second endpoint');
    }

    @IsTest
    private static void testServiceHeadersInitialization() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        MetadataCoreUtils utils = new MetadataCoreUtils('TestCredential');
        
        Test.stopTest();
        
        MetadataCore.MetadataPort service = utils.service;
        
        // Test SessionHeader_element initialization
        System.assertNotEquals(null, service.SessionHeader, 'SessionHeader should be initialized');

        // Test AllOrNoneHeader_element initialization
        System.assertNotEquals(null, service.AllOrNoneHeader, 'AllOrNoneHeader should be initialized');
        
        // Test that the boolean value is set correctly
        System.assertEquals(true, service.AllOrNoneHeader.allOrNone, 'AllOrNone boolean should be true');
    }

    @IsTest
    private static void testInvalidCredentialExceptionTypes() {
        // Set up web service mock
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        Test.startTest();

        // Test various invalid credential scenarios
        List<String> invalidCredentials = new List<String>{null, '', '   ', '\t', '\n'};

        for (String invalidCredential : invalidCredentials) {
            try {
                MetadataCoreUtils utils = new MetadataCoreUtils(invalidCredential);
                System.assert(false, 'Expected IllegalArgumentException was not thrown for: ' + invalidCredential);
            } catch (IllegalArgumentException e) {
                System.assertEquals('Named credential name cannot be null or empty', e.getMessage(),
                    'Exception message should match expected text for: ' + invalidCredential);
            } catch (Exception e) {
                System.assert(false, 'Unexpected exception type thrown: ' + e.getTypeName() + ' for: ' + invalidCredential);
            }
        }

        Test.stopTest();
    }

    @IsTest
    private static void testHandleSaveResultWithSuccessfulResults() {
        Test.startTest();

        // Create successful SaveResult
        MetadataCore.SaveResult successResult = new MetadataCore.SaveResult();
        successResult.success = true;
        successResult.fullName = 'TestObject__c';
        successResult.errors = null;

        MetadataCore.SaveResult[] results = new List<MetadataCore.SaveResult>{successResult};

        // Should not throw exception for successful results
        try {
            MetadataCoreUtils.handleSaveResult(results);
            System.assert(true, 'No exception should be thrown for successful results');
        } catch (Exception e) {
            System.assert(false, 'No exception should be thrown for successful results: ' + e.getMessage());
        }

        Test.stopTest();
    }

    @IsTest
    private static void testHandleSaveResultWithErrors() {
        Test.startTest();

        // Create error
        MetadataCore.Error error1 = new MetadataCore.Error();
        error1.message = 'Field already exists';
        error1.statusCode = 'DUPLICATE_VALUE';

        MetadataCore.Error error2 = new MetadataCore.Error();
        error2.message = 'Invalid field type';
        error2.statusCode = 'INVALID_TYPE';

        // Create failed SaveResult
        MetadataCore.SaveResult failedResult = new MetadataCore.SaveResult();
        failedResult.success = false;
        failedResult.fullName = 'TestObject__c.TestField__c';
        failedResult.errors = new List<MetadataCore.Error>{error1, error2};

        MetadataCore.SaveResult[] results = new List<MetadataCore.SaveResult>{failedResult};

        // Should throw SaveResultException
        try {
            MetadataCoreUtils.handleSaveResult(results);
            System.assert(false, 'SaveResultException should have been thrown');
        } catch (MetadataCoreUtils.SaveResultException e) {
            System.assertNotEquals(null, e.errors, 'Exception should contain error details');
            System.assertEquals(1, e.errors.size(), 'Should have one error wrapper');
            System.assertEquals('TestObject__c.TestField__c', e.errors[0].name, 'Error wrapper should have correct name');
            System.assertEquals(2, e.errors[0].errors.size(), 'Error wrapper should have two error messages');
            System.assertEquals('Field already exists', e.errors[0].errors[0], 'First error message should match');
            System.assertEquals('Invalid field type', e.errors[0].errors[1], 'Second error message should match');
        } catch (Exception e) {
            System.assert(false, 'Wrong exception type thrown: ' + e.getTypeName());
        }

        Test.stopTest();
    }

    @IsTest
    private static void testHandleSaveResultWithMixedResults() {
        Test.startTest();

        // Create successful result
        MetadataCore.SaveResult successResult = new MetadataCore.SaveResult();
        successResult.success = true;
        successResult.fullName = 'SuccessfulObject__c';
        successResult.errors = null;

        // Create error
        MetadataCore.Error error = new MetadataCore.Error();
        error.message = 'Validation failed';
        error.statusCode = 'FIELD_CUSTOM_VALIDATION_EXCEPTION';

        // Create failed result
        MetadataCore.SaveResult failedResult = new MetadataCore.SaveResult();
        failedResult.success = false;
        failedResult.fullName = 'FailedObject__c';
        failedResult.errors = new List<MetadataCore.Error>{error};

        MetadataCore.SaveResult[] results = new List<MetadataCore.SaveResult>{successResult, failedResult};

        // Should throw exception because of failed result
        try {
            MetadataCoreUtils.handleSaveResult(results);
            System.assert(false, 'SaveResultException should have been thrown');
        } catch (MetadataCoreUtils.SaveResultException e) {
            System.assertEquals(1, e.errors.size(), 'Should have one error wrapper for failed result');
            System.assertEquals('FailedObject__c', e.errors[0].name, 'Error should be for failed object');
        }

        Test.stopTest();
    }

    @IsTest
    private static void testHandleSaveResultWithNullErrors() {
        Test.startTest();

        // Create failed result with null errors
        MetadataCore.SaveResult failedResult = new MetadataCore.SaveResult();
        failedResult.success = false;
        failedResult.fullName = 'TestObject__c';
        failedResult.errors = null;

        MetadataCore.SaveResult[] results = new List<MetadataCore.SaveResult>{failedResult};

        // Should not throw exception when errors is null
        try {
            MetadataCoreUtils.handleSaveResult(results);
            System.assert(true, 'No exception should be thrown when errors is null');
        } catch (Exception e) {
            System.assert(false, 'No exception should be thrown when errors is null: ' + e.getMessage());
        }

        Test.stopTest();
    }

    @IsTest
    private static void testHandleDeleteResultWithSuccessfulResults() {
        Test.startTest();

        // Create successful DeleteResult
        MetadataCore.DeleteResult successResult = new MetadataCore.DeleteResult();
        successResult.success = true;
        successResult.fullName = 'TestObject__c';
        successResult.errors = null;

        MetadataCore.DeleteResult[] results = new List<MetadataCore.DeleteResult>{successResult};

        // Should not throw exception for successful results
        try {
            MetadataCoreUtils.handleDeleteResult(results);
            System.assert(true, 'No exception should be thrown for successful results');
        } catch (Exception e) {
            System.assert(false, 'No exception should be thrown for successful results: ' + e.getMessage());
        }

        Test.stopTest();
    }

    @IsTest
    private static void testHandleDeleteResultWithErrors() {
        Test.startTest();

        // Create error
        MetadataCore.Error error = new MetadataCore.Error();
        error.message = 'Cannot delete: Object is referenced by other components';
        error.statusCode = 'DELETE_FAILED';

        // Create failed DeleteResult
        MetadataCore.DeleteResult failedResult = new MetadataCore.DeleteResult();
        failedResult.success = false;
        failedResult.fullName = 'TestObject__c';
        failedResult.errors = new List<MetadataCore.Error>{error};

        MetadataCore.DeleteResult[] results = new List<MetadataCore.DeleteResult>{failedResult};

        // Should throw DeleteResultException
        try {
            MetadataCoreUtils.handleDeleteResult(results);
            System.assert(false, 'DeleteResultException should have been thrown');
        } catch (MetadataCoreUtils.DeleteResultException e) {
            System.assertNotEquals(null, e.errors, 'Exception should contain error details');
            System.assertEquals(1, e.errors.size(), 'Should have one error wrapper');
            System.assertEquals('TestObject__c', e.errors[0].name, 'Error wrapper should have correct name');
            System.assertEquals(1, e.errors[0].errors.size(), 'Error wrapper should have one error message');
            System.assertEquals('Cannot delete: Object is referenced by other components', e.errors[0].errors[0], 'Error message should match');
        } catch (Exception e) {
            System.assert(false, 'Wrong exception type thrown: ' + e.getTypeName());
        }

        Test.stopTest();
    }

    @IsTest
    private static void testResultWrapperClass() {
        Test.startTest();

        // Test resultWrapper instantiation and properties
        MetadataCoreUtils.resultWrapper wrapper = new MetadataCoreUtils.resultWrapper();
        wrapper.name = 'TestObject__c';
        wrapper.errors = new List<String>{'Error 1', 'Error 2'};

        System.assertEquals('TestObject__c', wrapper.name, 'Name should be set correctly');
        System.assertEquals(2, wrapper.errors.size(), 'Should have two errors');
        System.assertEquals('Error 1', wrapper.errors[0], 'First error should match');
        System.assertEquals('Error 2', wrapper.errors[1], 'Second error should match');

        Test.stopTest();
    }

    @IsTest
    private static void testSaveResultExceptionClass() {
        Test.startTest();

        // Create error wrapper
        MetadataCoreUtils.resultWrapper wrapper = new MetadataCoreUtils.resultWrapper();
        wrapper.name = 'TestObject__c';
        wrapper.errors = new List<String>{'Test error'};

        List<MetadataCoreUtils.resultWrapper> errorList = new List<MetadataCoreUtils.resultWrapper>{wrapper};

        // Test SaveResultException
        MetadataCoreUtils.SaveResultException saveException = new MetadataCoreUtils.SaveResultException(errorList);

        System.assertNotEquals(null, saveException.errors, 'Exception should have errors');
        System.assertEquals(1, saveException.errors.size(), 'Should have one error wrapper');
        System.assertEquals('TestObject__c', saveException.errors[0].name, 'Error name should match');

        Test.stopTest();
    }

    @IsTest
    private static void testDeleteResultExceptionClass() {
        Test.startTest();

        // Create error wrapper
        MetadataCoreUtils.resultWrapper wrapper = new MetadataCoreUtils.resultWrapper();
        wrapper.name = 'TestObject__c';
        wrapper.errors = new List<String>{'Delete error'};

        List<MetadataCoreUtils.resultWrapper> errorList = new List<MetadataCoreUtils.resultWrapper>{wrapper};

        // Test DeleteResultException
        MetadataCoreUtils.DeleteResultException deleteException = new MetadataCoreUtils.DeleteResultException(errorList);

        System.assertNotEquals(null, deleteException.errors, 'Exception should have errors');
        System.assertEquals(1, deleteException.errors.size(), 'Should have one error wrapper');
        System.assertEquals('TestObject__c', deleteException.errors[0].name, 'Error name should match');

        Test.stopTest();
    }
}
