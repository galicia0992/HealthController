public with sharing class CTPersonTriggerHandler {
    public static void beforeInsert(List<Person__c> newRecords){
        for(Person__c person: newRecords){
            person.Health_Status__c = 'Green';
            person.Token__c = CTPersonController.getToken(person.Mobile__c);
        }
    }
    public static void beforeUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldRecords){
        for(Person__c person: newRecords){
            if(person.Health_Status__c != oldRecords.get(person.id).Health_Status__c){
                person.Status_Update_Date__c = Date.today();
            }
        }
    }
    public static void afterUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldRecords){
        Set<Id> StatusChange = new Set<Id>();
        Set<Id> RedStatus = new Set<Id>();
        for(Person__c person: newRecords){
            if(person.Health_Status__c != oldRecords.get(person.id).Health_Status__c){
                StatusChange.add(person.Id);
            }
            if(person.Health_Status__c == 'Red' && oldRecords.get(person.id).Health_Status__c != 'Red'){
                RedStatus.add(person.Id);
            }
        }
        Set<Id> alreadyProcessed = new Set<Id>();
        alreadyProcessed.addAll(RedStatus);


        Set<Id>orangeStatus = new Set<Id>();
        Set<Id>yellowStatus = new Set<Id>();

        List<Person__c> personsToUpdate = new List<Person__c>();

        orangeStatus.addAll(CTPersonController.getCohabitants(redStatus, alreadyProcessed));
        Set<Id> primaryContacts = CTPersonController.getPrimaryContact(redStatus, alreadyProcessed);
        orangeStatus.addAll(primaryContacts);
        yellowStatus.addAll(CTPersonController.getNeighbours(redStatus, alreadyProcessed));
        yellowStatus.addAll(CTPersonController.getSecondaryContact(primaryContacts, alreadyProcessed));
        
        for(Id pid: orangeStatus){
            personsToUpdate.add(new Person__c(Id=pid, Health_Status__c = 'Orange'));
        }
        for(Id pid: yellowStatus){
            personsToUpdate.add(new Person__c(Id=pid, Health_Status__c = 'Yellow'));
        }

        if(personsToUpdate.size() > 0){
            update personsToUpdate;
        }
        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByPersonsId(StatusChange);
        if(locationTraces != null && locationTraces.size() > 0){
            Set<Id>locationIds = new Set<Id>();
            for(Location_Tracing__c trace: locationTraces){
                locationIds.add(trace.Location__c);
            }
            CTLocationController.updateRedScore(locationIds);
        }
    }
}