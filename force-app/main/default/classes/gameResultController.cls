public with sharing class gameResultController {
    @AuraEnabled
    public static List <World_Shuffle__c> showResults(){
        List <World_Shuffle__c> res = [SELECT Name, Mode__c, Result__c FROM World_Shuffle__c ORDER BY Name ASC];
       
        return res;
    }
}