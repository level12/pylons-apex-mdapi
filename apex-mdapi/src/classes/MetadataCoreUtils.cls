public virtual with sharing class MetadataCoreUtils {
    public String namedCredentialName;
    public MetadataCore.MetadataPort service;

    public MetadataCoreUtils(String namedCredentialName) {
        if (String.isBlank(namedCredentialName)) {
            throw new IllegalArgumentException('Named credential name cannot be null or empty');
        }
        this.namedCredentialName = namedCredentialName;
        this.service = createService();
    }

    private MetadataCore.MetadataPort createService() {
        MetadataCore.MetadataPort service = new MetadataCore.MetadataPort();
        service.endpoint_x = 'callout:' + namedCredentialName + '/services/Soap/m/64.0';
        service.SessionHeader = new MetadataCore.SessionHeader_element();
        service.SessionHeader.sessionId = '{!$Credential.OAuthToken}';
        service.timeout_x = 120000; //The minimum is 1 millisecond and the maximum is 120,000 milliseconds.
        service.AllOrNoneHeader = new MetadataCore.AllOrNoneHeader_element();
        service.AllOrNoneHeader.allOrNone = true;
        return service;
    }

    public static void handleSaveResult(MetadataCore.SaveResult[] saveResults) {
        List<resultWrapper> errors = new List<resultWrapper>();
        for(MetadataCore.SaveResult result : saveResults) {
            if (result.success) {
                continue;
            } else {
                for (MetadataCore.SaveResult saveResult : saveResults) {
                    if (saveResult.errors != null) {
                        resultWrapper wrapper = new resultWrapper();
                        wrapper.name = saveResult.fullName;
                        wrapper.errors = new List<String>();
                        for (MetadataCore.Error error : saveResult.errors) {
                            wrapper.errors.add(error.message);
                        }
                        errors.add(wrapper);
                    }
                }
            }
        }
        if (errors.size() > 0) {
            throw new SaveResultException(errors);
        }
    }

    public static void handleDeleteResult(MetadataCore.DeleteResult[] deleteResults) {
        List<resultWrapper> errors = new List<resultWrapper>();
        for(MetadataCore.DeleteResult result : deleteResults) {
            if (result.success) {
                continue;
            } else {
                for (MetadataCore.DeleteResult saveResult : deleteResults) {
                    if (saveResult.errors != null) {
                        resultWrapper wrapper = new resultWrapper();
                        wrapper.name = saveResult.fullName;
                        wrapper.errors = new List<String>();
                        for (MetadataCore.Error error : saveResult.errors) {
                            wrapper.errors.add(error.message);
                        }
                        errors.add(wrapper);
                    }
                }
            }
        }
        if (errors.size() > 0) {
            throw new DeleteResultException(errors);
        }
    }

    public class resultWrapper {
        public String name;
        public List<String> errors;
    }

    public class SaveResultException extends Exception {
        public List<resultWrapper> errors;

        public SaveResultException(List<resultWrapper> errors) {
            this.errors = errors;
        }
    }

    public class DeleteResultException extends Exception {
        public List<resultWrapper> errors;

        public DeleteResultException(List<resultWrapper> errors) {
            this.errors = errors;
        }
    }
}