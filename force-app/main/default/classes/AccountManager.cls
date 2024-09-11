@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substringBetween('/Accounts/', '/');
        
        // Query to get Account and related Contacts
        Account result = [
            SELECT Id, Name, (SELECT Id, Name FROM Contacts) 
            FROM Account 
            WHERE Id = :accountId
            LIMIT 1
        ];
        
        // Prepare the response
        return result;
    }
    
    // Wrapper classes to structure 
}