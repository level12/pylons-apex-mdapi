@IsTest
public class MetadataCoreTest {

    private class WebServiceMockImpl implements WebServiceMock 
	{
		public void doInvoke(
			Object stub, Object request, Map<String, Object> response,
			String endpoint, String soapAction, String requestName,
			String responseNS, String responseName, String responseType) 
		{
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
            else if(request instanceof MetadataCore.updateMetadata_element)
                response.put('response_x', new MetadataCore.updateMetadataResponse_element());
            else if(request instanceof MetadataCore.renameMetadata_element)
                response.put('response_x', new MetadataCore.renameMetadataResponse_element());
            else if(request instanceof  MetadataCore.cancelDeploy_element)
                response.put('response_x', new MetadataCore.cancelDeployResponse_element());
            else if(request instanceof  MetadataCore.deleteMetadata_element)
                response.put('response_x', new MetadataCore.deleteMetadataResponse_element());
            else if(request instanceof  MetadataCore.upsertMetadata_element)
                response.put('response_x', new MetadataCore.upsertMetadataResponse_element());
            else if(request instanceof  MetadataCore.createMetadata_element)
                response.put('response_x', new MetadataCore.createMetadataResponse_element());
            else if(request instanceof  MetadataCore.deployRecentValidation_element)
                response.put('response_x', new MetadataCore.deployRecentValidationResponse_element());
            else if(request instanceof MetadataCore.describeValueType_element)
                response.put('response_x', new MetadataCore.describeValueTypeResponse_element());
            else if(request instanceof MetadataCore.checkRetrieveStatus_element)
                response.put('response_x', new MetadataCore.checkRetrieveStatusResponse_element());
			return;
		}
	}
		
	@IsTest
	private static void coverGeneratedCodeCRUDOperations()
	{	
    	// Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataCore MetadataCore = new MetadataCore();
        // Invoke operations     
        Test.startTest();    
        MetadataCore.MetadataPort metaDataPort = new MetadataCore.MetadataPort();
        Test.stopTest();
	}
	
	@IsTest
    private static void coverGeneratedCodeFileBasedOperations1()
    {    	
    	// Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataCore MetadataCore = new MetadataCore();
        // Invoke operations    
        Test.startTest();     
        MetadataCore.MetadataPort metaDataPort = new MetadataCore.MetadataPort();
        metaDataPort.checkDeployStatus(null, false);
        metaDataPort.listMetadata(null, null);
        metaDataPort.describeMetadata(null);
        metaDataPort.deploy(null, null);
        metaDataPort.checkDeployStatus(null, false);
        metaDataPort.updateMetadata(null);
        metaDataPort.renameMetadata(null, null, null);
        metaDataPort.cancelDeploy(null);
        Test.stopTest();
    }

    @IsTest
    private static void coverGeneratedCodeFileBasedOperations2()
    {       
        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataCore MetadataCore = new MetadataCore();
        // Invoke operations     
        Test.startTest();    
        MetadataCore.MetadataPort metaDataPort = new MetadataCore.MetadataPort();
        metaDataPort.deleteMetadata(null, null);
        metaDataPort.upsertMetadata(null);
        metaDataPort.createMetadata(null);
        metaDataPort.deployRecentValidation(null);
        metaDataPort.describeValueType(null);
        metaDataPort.checkRetrieveStatus(null, null);
        Test.stopTest();
    }

    @IsTest
    private static void testMainClass() {
        Test.startTest();

        // Test main class instantiation
        MetadataCore mainInstance = new MetadataCore();
        System.assertNotEquals(null, mainInstance, 'Main class should be instantiated');

        Test.stopTest();
    }

    @IsTest
    private static void coverGeneratedCodeTypes() {
        Test.startTest();

        // Test inner class instantiations
        MetadataCore.AllOrNoneHeader_element allornoneheader_elementInstance = new MetadataCore.AllOrNoneHeader_element();
        System.assertNotEquals(null, allornoneheader_elementInstance, 'AllOrNoneHeader_element should be instantiated');
        MetadataCore.AsyncResult asyncresultInstance = new MetadataCore.AsyncResult();
        System.assertNotEquals(null, asyncresultInstance, 'AsyncResult should be instantiated');
        MetadataCore.CallOptions_element calloptions_elementInstance = new MetadataCore.CallOptions_element();
        System.assertNotEquals(null, calloptions_elementInstance, 'CallOptions_element should be instantiated');
        MetadataCore.CancelDeployResult canceldeployresultInstance = new MetadataCore.CancelDeployResult();
        System.assertNotEquals(null, canceldeployresultInstance, 'CancelDeployResult should be instantiated');
        MetadataCore.CodeCoverageResult codecoverageresultInstance = new MetadataCore.CodeCoverageResult();
        System.assertNotEquals(null, codecoverageresultInstance, 'CodeCoverageResult should be instantiated');
        MetadataCore.CodeCoverageWarning codecoveragewarningInstance = new MetadataCore.CodeCoverageWarning();
        System.assertNotEquals(null, codecoveragewarningInstance, 'CodeCoverageWarning should be instantiated');
        MetadataCore.CodeLocation codelocationInstance = new MetadataCore.CodeLocation();
        System.assertNotEquals(null, codelocationInstance, 'CodeLocation should be instantiated');
        MetadataCore.DebuggingHeader_element debuggingheader_elementInstance = new MetadataCore.DebuggingHeader_element();
        System.assertNotEquals(null, debuggingheader_elementInstance, 'DebuggingHeader_element should be instantiated');
        MetadataCore.DebuggingInfo_element debugginginfo_elementInstance = new MetadataCore.DebuggingInfo_element();
        System.assertNotEquals(null, debugginginfo_elementInstance, 'DebuggingInfo_element should be instantiated');
        MetadataCore.DeleteResult deleteresultInstance = new MetadataCore.DeleteResult();
        System.assertNotEquals(null, deleteresultInstance, 'DeleteResult should be instantiated');
        MetadataCore.DeployDetails deploydetailsInstance = new MetadataCore.DeployDetails();
        System.assertNotEquals(null, deploydetailsInstance, 'DeployDetails should be instantiated');
        MetadataCore.DeployMessage deploymessageInstance = new MetadataCore.DeployMessage();
        System.assertNotEquals(null, deploymessageInstance, 'DeployMessage should be instantiated');
        MetadataCore.DeployOptions deployoptionsInstance = new MetadataCore.DeployOptions();
        System.assertNotEquals(null, deployoptionsInstance, 'DeployOptions should be instantiated');
        MetadataCore.DeployResult deployresultInstance = new MetadataCore.DeployResult();
        System.assertNotEquals(null, deployresultInstance, 'DeployResult should be instantiated');
        MetadataCore.DescribeMetadataObject describemetadataobjectInstance = new MetadataCore.DescribeMetadataObject();
        System.assertNotEquals(null, describemetadataobjectInstance, 'DescribeMetadataObject should be instantiated');
        MetadataCore.DescribeMetadataResult describemetadataresultInstance = new MetadataCore.DescribeMetadataResult();
        System.assertNotEquals(null, describemetadataresultInstance, 'DescribeMetadataResult should be instantiated');
        MetadataCore.DescribeValueTypeResult describevaluetyperesultInstance = new MetadataCore.DescribeValueTypeResult();
        System.assertNotEquals(null, describevaluetyperesultInstance, 'DescribeValueTypeResult should be instantiated');
        MetadataCore.Error errorInstance = new MetadataCore.Error();
        System.assertNotEquals(null, errorInstance, 'Error should be instantiated');
        MetadataCore.ExtendedErrorDetails extendederrordetailsInstance = new MetadataCore.ExtendedErrorDetails();
        System.assertNotEquals(null, extendederrordetailsInstance, 'ExtendedErrorDetails should be instantiated');
        MetadataCore.FileProperties filepropertiesInstance = new MetadataCore.FileProperties();
        System.assertNotEquals(null, filepropertiesInstance, 'FileProperties should be instantiated');

        Test.stopTest();
    }

    @IsTest
    private static void coverGeneratedCodeTypes2() {
        Test.startTest();

        // Test inner class instantiations
        MetadataCore.FlowCoverageResult flowcoverageresultInstance = new MetadataCore.FlowCoverageResult();
        System.assertNotEquals(null, flowcoverageresultInstance, 'FlowCoverageResult should be instantiated');
        MetadataCore.FlowCoverageWarning flowcoveragewarningInstance = new MetadataCore.FlowCoverageWarning();
        System.assertNotEquals(null, flowcoveragewarningInstance, 'FlowCoverageWarning should be instantiated');
        MetadataCore.ListMetadataQuery listmetadataqueryInstance = new MetadataCore.ListMetadataQuery();
        System.assertNotEquals(null, listmetadataqueryInstance, 'ListMetadataQuery should be instantiated');
        MetadataCore.Metadata metadataInstance = new MetadataCore.Metadata();
        System.assertNotEquals(null, metadataInstance, 'Metadata should be instantiated');
        MetadataCore.MetadataPort metadataportInstance = new MetadataCore.MetadataPort();
        System.assertNotEquals(null, metadataportInstance, 'MetadataPort should be instantiated');
        MetadataCore.PackageTypeMembers packagetypemembersInstance = new MetadataCore.PackageTypeMembers();
        System.assertNotEquals(null, packagetypemembersInstance, 'PackageTypeMembers should be instantiated');
        MetadataCore.Package_x package_xInstance = new MetadataCore.Package_x();
        System.assertNotEquals(null, package_xInstance, 'Package_x should be instantiated');
        MetadataCore.PicklistEntry picklistentryInstance = new MetadataCore.PicklistEntry();
        System.assertNotEquals(null, picklistentryInstance, 'PicklistEntry should be instantiated');
        MetadataCore.ProfileObjectPermissions profileobjectpermissionsInstance = new MetadataCore.ProfileObjectPermissions();
        System.assertNotEquals(null, profileobjectpermissionsInstance, 'ProfileObjectPermissions should be instantiated');
        MetadataCore.ReadResult readresultInstance = new MetadataCore.ReadResult();
        System.assertNotEquals(null, readresultInstance, 'ReadResult should be instantiated');
        MetadataCore.RetrieveMessage retrievemessageInstance = new MetadataCore.RetrieveMessage();
        System.assertNotEquals(null, retrievemessageInstance, 'RetrieveMessage should be instantiated');
        MetadataCore.RetrieveRequest retrieverequestInstance = new MetadataCore.RetrieveRequest();
        System.assertNotEquals(null, retrieverequestInstance, 'RetrieveRequest should be instantiated');
        MetadataCore.RetrieveResult retrieveresultInstance = new MetadataCore.RetrieveResult();
        System.assertNotEquals(null, retrieveresultInstance, 'RetrieveResult should be instantiated');
        MetadataCore.RunTestFailure runtestfailureInstance = new MetadataCore.RunTestFailure();
        System.assertNotEquals(null, runtestfailureInstance, 'RunTestFailure should be instantiated');
        MetadataCore.RunTestSuccess runtestsuccessInstance = new MetadataCore.RunTestSuccess();
        System.assertNotEquals(null, runtestsuccessInstance, 'RunTestSuccess should be instantiated');
        MetadataCore.RunTestsResult runtestsresultInstance = new MetadataCore.RunTestsResult();
        System.assertNotEquals(null, runtestsresultInstance, 'RunTestsResult should be instantiated');
        MetadataCore.SaveResult saveresultInstance = new MetadataCore.SaveResult();
        System.assertNotEquals(null, saveresultInstance, 'SaveResult should be instantiated');
        MetadataCore.SessionHeader_element sessionheader_elementInstance = new MetadataCore.SessionHeader_element();
        System.assertNotEquals(null, sessionheader_elementInstance, 'SessionHeader_element should be instantiated');
        MetadataCore.UpsertResult upsertresultInstance = new MetadataCore.UpsertResult();
        System.assertNotEquals(null, upsertresultInstance, 'UpsertResult should be instantiated');
        MetadataCore.ValueTypeField valuetypefieldInstance = new MetadataCore.ValueTypeField();
        System.assertNotEquals(null, valuetypefieldInstance, 'ValueTypeField should be instantiated');

        Test.stopTest();
    }

    @IsTest
    private static void coverGeneratedCodeTypes3() {
        Test.startTest();

        // Test inner class instantiations
        MetadataCore.cancelDeployResponse_element canceldeployresponse_elementInstance = new MetadataCore.cancelDeployResponse_element();
        System.assertNotEquals(null, canceldeployresponse_elementInstance, 'cancelDeployResponse_element should be instantiated');
        MetadataCore.cancelDeploy_element canceldeploy_elementInstance = new MetadataCore.cancelDeploy_element();
        System.assertNotEquals(null, canceldeploy_elementInstance, 'cancelDeploy_element should be instantiated');
        MetadataCore.checkDeployStatusResponse_element checkdeploystatusresponse_elementInstance = new MetadataCore.checkDeployStatusResponse_element();
        System.assertNotEquals(null, checkdeploystatusresponse_elementInstance, 'checkDeployStatusResponse_element should be instantiated');
        MetadataCore.checkDeployStatus_element checkdeploystatus_elementInstance = new MetadataCore.checkDeployStatus_element();
        System.assertNotEquals(null, checkdeploystatus_elementInstance, 'checkDeployStatus_element should be instantiated');
        MetadataCore.checkRetrieveStatusResponse_element checkretrievestatusresponse_elementInstance = new MetadataCore.checkRetrieveStatusResponse_element();
        System.assertNotEquals(null, checkretrievestatusresponse_elementInstance, 'checkRetrieveStatusResponse_element should be instantiated');
        MetadataCore.checkRetrieveStatus_element checkretrievestatus_elementInstance = new MetadataCore.checkRetrieveStatus_element();
        System.assertNotEquals(null, checkretrievestatus_elementInstance, 'checkRetrieveStatus_element should be instantiated');
        MetadataCore.createMetadataResponse_element createmetadataresponse_elementInstance = new MetadataCore.createMetadataResponse_element();
        System.assertNotEquals(null, createmetadataresponse_elementInstance, 'createMetadataResponse_element should be instantiated');
        MetadataCore.createMetadata_element createmetadata_elementInstance = new MetadataCore.createMetadata_element();
        System.assertNotEquals(null, createmetadata_elementInstance, 'createMetadata_element should be instantiated');
        MetadataCore.deleteMetadataResponse_element deletemetadataresponse_elementInstance = new MetadataCore.deleteMetadataResponse_element();
        System.assertNotEquals(null, deletemetadataresponse_elementInstance, 'deleteMetadataResponse_element should be instantiated');
        MetadataCore.deleteMetadata_element deletemetadata_elementInstance = new MetadataCore.deleteMetadata_element();
        System.assertNotEquals(null, deletemetadata_elementInstance, 'deleteMetadata_element should be instantiated');
        MetadataCore.deployRecentValidationResponse_element deployrecentvalidationresponse_elementInstance = new MetadataCore.deployRecentValidationResponse_element();
        System.assertNotEquals(null, deployrecentvalidationresponse_elementInstance, 'deployRecentValidationResponse_element should be instantiated');
        MetadataCore.deployRecentValidation_element deployrecentvalidation_elementInstance = new MetadataCore.deployRecentValidation_element();
        System.assertNotEquals(null, deployrecentvalidation_elementInstance, 'deployRecentValidation_element should be instantiated');
        MetadataCore.deployResponse_element deployresponse_elementInstance = new MetadataCore.deployResponse_element();
        System.assertNotEquals(null, deployresponse_elementInstance, 'deployResponse_element should be instantiated');
        MetadataCore.deploy_element deploy_elementInstance = new MetadataCore.deploy_element();
        System.assertNotEquals(null, deploy_elementInstance, 'deploy_element should be instantiated');
        MetadataCore.describeMetadataResponse_element describemetadataresponse_elementInstance = new MetadataCore.describeMetadataResponse_element();
        System.assertNotEquals(null, describemetadataresponse_elementInstance, 'describeMetadataResponse_element should be instantiated');
        MetadataCore.describeMetadata_element describemetadata_elementInstance = new MetadataCore.describeMetadata_element();
        System.assertNotEquals(null, describemetadata_elementInstance, 'describeMetadata_element should be instantiated');
        MetadataCore.describeValueTypeResponse_element describevaluetyperesponse_elementInstance = new MetadataCore.describeValueTypeResponse_element();
        System.assertNotEquals(null, describevaluetyperesponse_elementInstance, 'describeValueTypeResponse_element should be instantiated');
        MetadataCore.describeValueType_element describevaluetype_elementInstance = new MetadataCore.describeValueType_element();
        System.assertNotEquals(null, describevaluetype_elementInstance, 'describeValueType_element should be instantiated');
        MetadataCore.listMetadataResponse_element listmetadataresponse_elementInstance = new MetadataCore.listMetadataResponse_element();
        System.assertNotEquals(null, listmetadataresponse_elementInstance, 'listMetadataResponse_element should be instantiated');
        MetadataCore.listMetadata_element listmetadata_elementInstance = new MetadataCore.listMetadata_element();
        System.assertNotEquals(null, listmetadata_elementInstance, 'listMetadata_element should be instantiated');

        Test.stopTest();
    }

    @IsTest
    private static void coverGeneratedCodeTypes4() {
        Test.startTest();

        // Test inner class instantiations
        MetadataCore.readMetadataResponse_element readmetadataresponse_elementInstance = new MetadataCore.readMetadataResponse_element();
        System.assertNotEquals(null, readmetadataresponse_elementInstance, 'readMetadataResponse_element should be instantiated');
        MetadataCore.readMetadata_element readmetadata_elementInstance = new MetadataCore.readMetadata_element();
        System.assertNotEquals(null, readmetadata_elementInstance, 'readMetadata_element should be instantiated');
        MetadataCore.renameMetadataResponse_element renamemetadataresponse_elementInstance = new MetadataCore.renameMetadataResponse_element();
        System.assertNotEquals(null, renamemetadataresponse_elementInstance, 'renameMetadataResponse_element should be instantiated');
        MetadataCore.renameMetadata_element renamemetadata_elementInstance = new MetadataCore.renameMetadata_element();
        System.assertNotEquals(null, renamemetadata_elementInstance, 'renameMetadata_element should be instantiated');
        MetadataCore.retrieveResponse_element retrieveresponse_elementInstance = new MetadataCore.retrieveResponse_element();
        System.assertNotEquals(null, retrieveresponse_elementInstance, 'retrieveResponse_element should be instantiated');
        MetadataCore.retrieve_element retrieve_elementInstance = new MetadataCore.retrieve_element();
        System.assertNotEquals(null, retrieve_elementInstance, 'retrieve_element should be instantiated');
        MetadataCore.updateMetadataResponse_element updatemetadataresponse_elementInstance = new MetadataCore.updateMetadataResponse_element();
        System.assertNotEquals(null, updatemetadataresponse_elementInstance, 'updateMetadataResponse_element should be instantiated');
        MetadataCore.updateMetadata_element updatemetadata_elementInstance = new MetadataCore.updateMetadata_element();
        System.assertNotEquals(null, updatemetadata_elementInstance, 'updateMetadata_element should be instantiated');
        MetadataCore.upsertMetadataResponse_element upsertmetadataresponse_elementInstance = new MetadataCore.upsertMetadataResponse_element();
        System.assertNotEquals(null, upsertmetadataresponse_elementInstance, 'upsertMetadataResponse_element should be instantiated');
        MetadataCore.upsertMetadata_element upsertmetadata_elementInstance = new MetadataCore.upsertMetadata_element();
        System.assertNotEquals(null, upsertmetadata_elementInstance, 'upsertMetadata_element should be instantiated');

        Test.stopTest();
    }
}
