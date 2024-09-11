public with sharing class CTUserTabController {
    @AuraEnabled
    public static UserInformation getPersonDetails(String recordId){
        userInformation info = new userInformation();


        Person__c person = CTPersonController.getPersonById(recordId);
        if(person != null){
            info.name = person.Name;
            info.token = person.Token__c;
            info.statusUpdateOn = person.Status_Update_Date__c;
            info.phone = person.Mobile__c;
            info.status = person.Health_Status__c;

        }

        
        List<People_Tracing__c> traces = CTPeopleTraciongController.getTraces(recordId);
        if(traces != null){
            List<CloseContacts> closeContact = new List<CloseContacts>();
            Set<Id> uniqueIds = new set<Id>();
            uniqueIds.add(recordId);

            for(People_Tracing__c trace: traces){
                closeContacts cc = new closeContacts();
                if(!uniqueIds.contains(trace.Person_1__c)){
                    cc.id = trace.Person_1__c;
                    cc.status = trace.Person_1__r.Health_Status__c;
                    cc.token = trace.Person_1__r.Token__c;
                    cc.contactDate = trace.Contact_Date__c;
                }
                if(!uniqueIds.contains(trace.Person_2__c)){
                    cc.id = trace.Person_2__c;
                    cc.status = trace.Person_2__r.Health_Status__c;
                    cc.token = trace.Person_2__r.Token__c;
                    cc.contactDate = trace.Contact_Date__c;
                }
                closeContact.add(cc);
            }
            info.contacts = closeContact;
            info.contactsCount = closeContact.size();
        }
        return info;
    }
    public class UserInformation{
        @AuraEnabled public String name;
        @AuraEnabled public String token;
        @AuraEnabled public Date statusUpdateOn;
        @AuraEnabled public String phone;
        @AuraEnabled public String status;
        @AuraEnabled public Integer contactsCount = 0;
        @AuraEnabled public List<CloseContacts> contacts;
    }
    public class CloseContacts{
        @AuraEnabled public String Id;
        @AuraEnabled public String status;
        @AuraEnabled public String token;
        @AuraEnabled public Date contactDate;
    }
}