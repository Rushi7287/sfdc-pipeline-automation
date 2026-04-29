public with sharing class PortfolioDataController {
    @AuraEnabled(cacheable=true)
    public static List<FileWrapper> getCertificateFiles(Id recordId) {
        List<FileWrapper> results = new List<FileWrapper>();

        // Step 1: Get ContentDocumentIds first
        List<Id> documentIds = new List<Id>();

        for (ContentDocumentLink cdl : [
            SELECT ContentDocumentId
            FROM ContentDocumentLink
            WHERE LinkedEntityId = :recordId
        ]) {
            documentIds.add(cdl.ContentDocumentId);
        }

        if (documentIds.isEmpty()) {
            return results;
        }

        // Step 2: Query latest ContentVersion using ContentDocumentId
        List<ContentVersion> versions = [
            SELECT Id, Title, FileExtension, VersionData
            FROM ContentVersion
            WHERE ContentDocumentId IN :documentIds
            AND IsLatest = true
        ];

        for (ContentVersion cv : versions) {
            String base64Data = EncodingUtil.base64Encode(cv.VersionData);

            results.add(new FileWrapper(
                cv.Id,
                cv.Title,
                cv.FileExtension,
                'data:' + getMimeType(cv.FileExtension) + ';base64,' + base64Data
            ));
        }

        return results;
    }

    // MIME type resolver
    private static String getMimeType(String ext) {
        ext = ext != null ? ext.toLowerCase() : '';
        if (ext == 'png') return 'image/png';
        if (ext == 'jpg' || ext == 'jpeg') return 'image/jpeg';
        if (ext == 'pdf') return 'application/pdf';
        return 'application/octet-stream';
    }

    public class FileWrapper {
        @AuraEnabled public String id;
        @AuraEnabled public String title;
        @AuraEnabled public String extension;
        @AuraEnabled public String fileData;

        public FileWrapper(String id, String title, String ext, String data) {
            this.id = id;
            this.title = title;
            this.extension = ext;
            this.fileData = data;
        }
    }
}