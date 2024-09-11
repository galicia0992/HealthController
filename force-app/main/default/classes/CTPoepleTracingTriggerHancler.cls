public with sharing class CTPoepleTracingTriggerHancler {
    public static void beforeInsert(List<People_Tracing__c> actualRecords, Map<Id, People_Tracing__c> oldRecords){
        List<People_Tracing__c> checkDup = CTPeopleTraciongController.checkDuplicates(actualRecords);
        for(People_Tracing__c dup: checkDup){
            dup.addError('Duplicate record found: Person 1 ' + dup.Person_1__c + ' Person 2 ' + dup.Person_2__c);
        }
    }
}