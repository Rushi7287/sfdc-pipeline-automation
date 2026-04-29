trigger CommunityUserBeforeInsert on Community_User__c (before insert) {
    for (Community_User__c u : Trigger.new) {
        if (!String.isBlank(u.Password_Plain__c)) {
            String salt = EncodingUtil.convertToHex(Crypto.generateAesKey(128));
            u.Salt__c = salt;
            u.Password_Hash__c = HashUtil.hashPassword(u.Password_Plain__c, salt);
            u.Password_Plain__c = null;
        }
    }
}