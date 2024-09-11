public with sharing class CTLocationViewController {
    @AuraEnabled
    public static void updateLocationStatus(String recordId, String status){
        Location__c location = [SELECT Status__c, Id FROM Location__c WHERE Id =:recordId];
        if(location != null){
            location.Status__c = status;
            update location;
        }
    }
}