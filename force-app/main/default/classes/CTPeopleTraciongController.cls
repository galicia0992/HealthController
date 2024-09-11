public with sharing class CTPeopleTraciongController {
    public static List<People_Tracing__c> getTraces(String recordId){
        List<People_Tracing__c> pList = [SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c, Person_1__r.Health_Status__c, Person_1__r.Token__c, Person_2__r.Health_Status__c, Person_2__r.Token__c FROM People_Tracing__c WHERE (Person_1__c =:recordId OR Person_2__c =: recordId) AND Contact_Date__c = LAST_N_DAYS:30 ORDER BY Contact_Date__c DESC];
        return pList;
    }

    public static List<People_Tracing__c> checkDuplicates(List <People_Tracing__c> peopleTraces){
        Set<Id> personsIds = new Set<Id>();

        for(People_Tracing__c a : peopleTraces){
            personsIds.add(a.Person_1__c);
            personsIds.add(a.Person_2__c);
        }

        List<People_Tracing__c> duplicates = new List<People_Tracing__c>();

        Map<Id, Set<id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
        List<People_Tracing__c> existingRecords = [SELECT Person_1__c, Person_2__c FROM People_Tracing__c WHERE Person_1__c IN :personsIds OR Person_2__c IN :personsIds];

        if(existingRecords != null && existingRecords.size() > 0){
            for(People_Tracing__c b: existingRecords){
                if(! mapOfExistingRecords.containsKey(b.Person_1__c)){
                mapOfExistingRecords.put(b.Person_1__c, new Set<Id>());
            }
            mapOfExistingRecords.get(b.Person_1__c).add(b.Person_2__c);

            if(! mapOfExistingRecords.containsKey(b.Person_2__c)){
                mapOfExistingRecords.put(b.Person_2__c, new Set<Id>());
            }
            mapOfExistingRecords.get(b.Person_2__c).add(b.Person_1__c);
        }
        for(People_Tracing__c c : peopleTraces){
            if((mapOfExistingRecords.containsKey(c.Person_1__c) && mapOfExistingRecords.get(c.Person_1__c).contains(c.Person_2__c)) || (mapOfExistingRecords.containsKey(c.Person_2__c) && mapOfExistingRecords.get(c.Person_2__c).contains(c.Person_1__c))){
                duplicates.add(c);
            }
        }
    }
    return duplicates;
    }

    public static Map<String, Integer> getStatusCOunt(){
        Map<String, Integer> statusCount = new Map<String, Integer>();
        List<AggregateResult> agr = [SELECT Status__c, COUNT(id) total FROM Location__c GROUP BY Status__c];

        for(AggregateResult ar: agr){
            String healthStatus = String.valueOf(ar.get('Status__c'));
            Integer count = Integer.valueOf(ar.get('total'));
            statusCount.put(healthStatus, count);
        }
        return statusCount;
    }
}