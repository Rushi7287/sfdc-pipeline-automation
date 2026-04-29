public with sharing class AuthController {
    @AuraEnabled
    public static String register(String username, String email, String passwordPlain) {
        if (String.isBlank(username) || String.isBlank(email) || String.isBlank(passwordPlain)) {
            throw new AuraHandledException('Fields cannot be empty');
        }
        List<Community_User__c> existing = [SELECT Id FROM Community_User__c WHERE Username__c = :username LIMIT 1];
        if (!existing.isEmpty()) {
            throw new AuraHandledException('Username already exists');
        }
        String salt = EncodingUtil.convertToHex(Crypto.generateAesKey(128));
        String hash = HashUtil.hashPassword(passwordPlain, salt);
        Community_User__c u = new Community_User__c(
            Username__c = username,
            Email__c = email,
            Password_Hash__c = hash,
            Salt__c = salt,
            IsActive__c = true,
            Created_Web_User__c = true
        );
        insert u;
        return 'SUCCESS';
    }

    public class AuthResult {
        @AuraEnabled public Boolean success;
        @AuraEnabled public String message;
        @AuraEnabled public Id userId;
        public AuthResult(Boolean s, String m, Id id) {
            this.success = s; this.message = m; this.userId = id;
        }
    }

    @AuraEnabled
    public static AuthResult login(String username, String passwordPlain) {
        if (String.isBlank(username) || String.isBlank(passwordPlain)) {
            throw new AuraHandledException('Username and password required');
        }
        List<Community_User__c> lst = [SELECT Id, Password_Hash__c, Salt__c, IsActive__c FROM Community_User__c WHERE Username__c = :username LIMIT 1];
        if (lst.isEmpty()) throw new AuraHandledException('Invalid username or password');
        Community_User__c u = lst[0];
        if (!u.IsActive__c) throw new AuraHandledException('Account not active');
        String hash = HashUtil.hashPassword(passwordPlain, u.Salt__c);
        if (hash != u.Password_Hash__c) throw new AuraHandledException('Invalid username or password');
        u.Last_Login__c = System.now();
        update u;
        return new AuthResult(true, 'Login successful', u.Id);
    }

    @AuraEnabled
    public static String sendOtp(String usernameOrEmail) {
        List<Community_User__c> lst = [SELECT Id, Email__c FROM Community_User__c WHERE Username__c = :usernameOrEmail OR Email__c = :usernameOrEmail LIMIT 1];
        if (lst.isEmpty()) throw new AuraHandledException('User not found');
        Community_User__c u = lst[0];
        String otp = String.valueOf( Math.mod((Math.abs(Crypto.getRandomInteger())), (900000 + 100000)));
        u.OTP__c = otp;
        u.OTP_Expiry__c = System.now().addMinutes(15);
        update u;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{u.Email__c});
        mail.setSubject('Your OTP for password reset');
        mail.setPlainTextBody('Your OTP is: ' + otp + '. It expires in 15 minutes.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        return 'SENT';
    }

    @AuraEnabled
    public static String verifyOtpAndReset(String usernameOrEmail, String otp, String newPass) {
        List<Community_User__c> lst = [SELECT Id, OTP__c, OTP_Expiry__c, Salt__c FROM Community_User__c WHERE Username__c = :usernameOrEmail OR Email__c = :usernameOrEmail LIMIT 1];
        if (lst.isEmpty()) throw new AuraHandledException('User not found');
        Community_User__c u = lst[0];
        if (String.isBlank(u.OTP__c) || u.OTP__c != otp) throw new AuraHandledException('Invalid OTP');
        if (u.OTP_Expiry__c == null || u.OTP_Expiry__c < System.now()) throw new AuraHandledException('OTP expired');
        String newSalt = EncodingUtil.convertToHex(Crypto.generateAesKey(128));
        String newHash = HashUtil.hashPassword(newPass, newSalt);
        u.Password_Hash__c = newHash;
        u.Salt__c = newSalt;
        u.OTP__c = null;
        u.OTP_Expiry__c = null;
        update u;
        return 'RESET';
    }
}