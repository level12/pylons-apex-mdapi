public class MetadataCustomObjectUtils {
    private MetadataCoreUtils metadataUtils;

    public MetadataCustomObjectUtils(MetadataCoreUtils utils) {
        metadataUtils = utils;
    }

    public MetadataCustomObjectUtils(String namedCredentialName) {
        metadataUtils = new MetadataCoreUtils(namedCredentialName);
    }

    public MetadataCustomObject.CustomObject createCustomObject(MetadataCustomObject.CustomObject customObject) {
        MetadataCore.SaveResult[] results = metadataUtils.service.createMetadata(new MetadataCustomObject.CustomObject[] { customObject });
        try{
            MetadataCoreUtils.handleSaveResult(results);
        }
        catch(Exception e){
            throw e;
        }
        return customObject;
    }

    public MetadataCustomObject.CustomObject readCustomObject(String customObjectName) {
        MetadataCore.ReadResult readResult = metadataUtils.service.readMetadata('CustomObject', new String[] { customObjectName });
        return (MetadataCustomObject.CustomObject) readResult.records[0];
    }

    public MetadataCustomObject.CustomObject updateCustomObject(MetadataCustomObject.CustomObject customObject) {
        MetadataCore.SaveResult[] results = metadataUtils.service.updateMetadata(new MetadataCustomObject.CustomObject[] { customObject });
        try{
            MetadataCoreUtils.handleSaveResult(results);
        }
        catch(Exception e){
            throw e;
        }
        return customObject;
    }

    public void deleteCustomObject(String customObjectName) {
        MetadataCore.DeleteResult[] results = metadataUtils.service.deleteMetadata('CustomObject', new String[] { customObjectName });
        try{
            MetadataCoreUtils.handleDeleteResult(results);
        }
        catch(Exception e){
            throw e;
        }
    }
}
