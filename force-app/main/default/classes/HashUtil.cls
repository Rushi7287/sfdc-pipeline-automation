public with sharing class HashUtil {
    public class Input {
        @InvocableVariable(required=true) public String plainPassword;
        @InvocableVariable(required=true) public String salt;
    }
    public class Output {
        @InvocableVariable public String passwordHash;
    }

    public static String hashPassword(String plain, String salt) {
        if (plain == null) plain = '';
        if (salt == null) salt = '';
        Blob data = Blob.valueOf(plain + salt);
        Blob hash = Crypto.generateDigest('SHA-256', data);
        return EncodingUtil.convertToHex(hash);
    }

    @InvocableMethod(label='Hash Password for Flow' description='Hashes plain password with salt')
    public static List<Output> hashPasswordForFlow(List<Input> inputs) {
        List<Output> outs = new List<Output>();
        for (Input input : inputs) {
            Output o = new Output();
            o.passwordHash = hashPassword(input.plainPassword, input.salt);
            outs.add(o);
        }
        return outs;
    }
}