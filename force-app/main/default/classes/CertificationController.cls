public with sharing class CertificationController {

	@AuraEnabled(cacheable=true)
    public static String getResumeId() {
        // Looks for a file named 'Resume'
        ContentVersion cv = [SELECT ContentDocumentId FROM ContentVersion 
                             WHERE Title = 'Salesforce_Rushikesh_Kale_CV' AND IsLatest = true LIMIT 1];
        return '/sfc/servlet.shepherd/document/download/' + cv.ContentDocumentId;
    }

    @AuraEnabled(cacheable=true)
    public static List<CertWrapper> getCertifications() {
        List<CertWrapper> results = new List<CertWrapper>();
        
        // 1. Fetch Active Certifications
        Map<Id, Certificate__c> certMap = new Map<Id, Certificate__c>([
            SELECT Id, Name, Description__c, Start_From__c, Ends_On__c,RecordType.name 
            FROM Certificate__c 
            WHERE isActive__c = true
        ]);

        if(certMap.isEmpty()) return results;

        // 2. Fetch the latest Version ID for the attached Files
        // We look for files linked to our Certification records
        Map<Id, Id> certToVersionIdMap = new Map<Id, Id>();
        for(ContentDocumentLink link : [
            SELECT LinkedEntityId, ContentDocument.LatestPublishedVersionId 
            FROM ContentDocumentLink 
            WHERE LinkedEntityId IN :certMap.keySet()
        ]) {
            certToVersionIdMap.put(link.LinkedEntityId, link.ContentDocument.LatestPublishedVersionId);
        }

        // 3. Build the Wrapper with the system URL
        for(Certificate__c cert : certMap.values()) {
            String imgUrl = null;
            if(certToVersionIdMap.containsKey(cert.Id)) {
                // Construction of the Salesforce file URL
                imgUrl = '/sfc/servlet.shepherd/version/download/' + certToVersionIdMap.get(cert.Id);
            }
            
            results.add(new CertWrapper(cert, imgUrl));
        }
        
        return results;
    }

    public class CertWrapper {
        @AuraEnabled public Certificate__c details;
        @AuraEnabled public String imageUrl;

        public CertWrapper(Certificate__c details, String imageUrl) {
            this.details = details;
            this.imageUrl = imageUrl;
        }
    }
    
}