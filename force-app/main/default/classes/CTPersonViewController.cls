public with sharing class CTPersonViewController {
    @AuraEnabled
    public static void updateStatus(String recordId, String status){
        
        Person__c person = [SELECT Health_status__c, Id FROM Person__c WHERE Id =:recordId];
        if(person != null){
            person.Health_status__c = status;
            update person;
        }

       
    }
}