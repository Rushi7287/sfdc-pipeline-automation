public with sharing class SaltGenerator {
    public class Out { @InvocableVariable public String salt; }
    @InvocableMethod(label='Generate Salt')
    public static List<Out> generate(List<Integer> inputs) {
        List<Out> outs = new List<Out>();
        if (inputs == null || inputs.size() == 0) {
            outs.add(genOne());
        } else {
            for(Integer i=0;i<inputs.size();i++){
                outs.add(genOne());
            }
        }
        return outs;
    }
    private static Out genOne(){
        Out o = new Out();
        o.salt = EncodingUtil.convertToHex(Crypto.generateAesKey(128));
        return o;
    }
}