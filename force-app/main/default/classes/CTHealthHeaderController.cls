public with sharing class CTHealthHeaderController {
    @AuraEnabled
    public static Map<String, Integer> getPersonHealthStatusCount(){
        List<AggregateResult> agr = [SELECT COUNT(Id) totalCount, Health_Status__c FROM Person__c GROUP BY Health_Status__c ORDER BY Health_Status__c];
        Map<String, Integer> healthCount = new Map<String, Integer>();

        for(AggregateResult a: agr){
            healthCount.put((String)a.get('Health_Status__c'), (Integer)a.get('totalCount'));
        }
        
        return healthCount;
    }
    @AuraEnabled
    public static Map<String, Integer> getLocationHealthStatusCount(){
        List<AggregateResult> agr = [SELECT COUNT(id) totalCount, Status__c FROM Location__c GROUP BY Status__c ORDER BY Status__c];
        Map<String, Integer> locationCount = new Map<String, Integer>();

        for(AggregateResult a: agr){
            locationCount.put((String)a.get('Status__c'), (Integer)a.get('totalCount'));
        }
        
        return locationCount;
    }
}