public with sharing class CTLocationTabController {
    @AuraEnabled
    public static LocationInformation getLocationDetails(String recordId){
        LocationInformation info = new LocationInformation();


        Location__c location = CTLocationController.getLocationById(recordId);
        if(location != null){
            info.name = location.Name;
            info.redScore = location.Red_Score__c;
            info.statusUpdateOn = location.Status_Update_Date__c;
            info.pincode = location.Pincode__c;
            info.status = location.Status__c;
        }

        
        List<Location_Tracing__c> visitors = CTLocationTracingController.getVisitors(recordId);
        if(visitors != null){
            List<CloseContacts> closeContact = new List<CloseContacts>();
            
            

            for(Location_Tracing__c visitor: visitors){
                closeContacts cc = new closeContacts();
                    cc.id = visitor.Person__c;
                    cc.status = visitor.Person__r.Health_Status__c;
                    cc.token = visitor.Person__r.Token__c;
                    cc.visitDate = visitor.Visit_Date__c;
                closeContact.add(cc);
            }
            info.contacts = closeContact;
            info.contactsCount = closeContact.size();
        }
        return info;
    }
    public class LocationInformation{
        @AuraEnabled public String name;
        @AuraEnabled public Double redScore;
        @AuraEnabled public Date statusUpdateOn;
        @AuraEnabled public String pinCode;
        @AuraEnabled public String status;
        @AuraEnabled public Integer contactsCount = 0;
        @AuraEnabled public List<CloseContacts> contacts;
    }
    public class CloseContacts{
        @AuraEnabled public String Id;
        @AuraEnabled public String status;
        @AuraEnabled public String token;
        @AuraEnabled public Date visitDate;
    }
}