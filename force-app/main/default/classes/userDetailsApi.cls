@RestResource(urlMapping='/getUserDetails/*')
global without sharing class userDetailsApi {
    /**
    * -------------------------------------------------------------------------------
    * @description
    * A generic method used to fetch the details of Customer and Dealer through responses received from the api. 
    * -------------------------------------------------------------------------------
    * @param requestMap
    * @param responseList
    * @param oppList
    */
    @HttpPost
    global static void getRestResponse(){
        
        Map<String,object> requestMap = new Map<String,Object>();
        List<Map<String,object>> responseList = new List<Map<String,object>>(); 
        List<Account> userList = new List<Account>();

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String jsonString = req.requestBody.toString();
        requestMap = (Map<String,Object>)JSON.deserializeUntyped(jsonString);
        
        String jsnStr = '';
        String query = '';
        String username = '';
        String password = '';

        if(requestMap.containsKey('username') && requestMap.get('username') != null){
           username = (String)requestMap.get('username');  
        }
        if(requestMap.containsKey('password') && requestMap.get('password') != null){
           password =(String)requestMap.get('password');
        }
        
        if(!string.isBlank(password) && !string.isBlank(password)){
            query = 'Select Id from Account Where';
            if(!string.isBlank(username)){
                query += ' AccountNumber = \''+ username +'\'';
            }
            if(!string.isBlank(password)){
                query += ' and SLASerialNumber__c = \''+ password +'\'';
            }
        }

        if(!string.isBlank(query)){
            userList = Database.query(query);
        }

        if(userList != null && !userList.isEmpty()){
            Map<String,object> responseMap = new Map<String,Object>();
            responseMap.put('Status','User Login Success');
            responseList.add(responseMap);
        }else{
            Map<String,object> responseMap = new Map<String,Object>();
            responseMap.put('Status','User Login Failed');
            responseList.add(responseMap);
        }

        if(responseList != null && !responseList.isEmpty()){
            jsnStr = JSON.serialize(responseList);
        }

        if(!string.isBlank(jsnStr)){
            res.responseBody = Blob.valueOf(jsnStr);
        }else{
            jsnStr = JSON.serialize('json String is empty');
            res.responseBody = Blob.valueOf(jsnStr);
        }
    }
}
/*
Post
URL : /services/apexrest/getUserDetails
Request Body : 
{
    "username" : "CD355118",
    "password" : "6654"
}
*/