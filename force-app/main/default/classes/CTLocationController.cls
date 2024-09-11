public class CTLocationController {
    public static List<Location__c> getRecentStatusChanges(){
        List<Location__c> lList = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c FROM Location__c ORDER BY Status_Update_Date__c DESC LIMIT 100];
        return lList;
    }
    public static List<Location__c> searchLocations(String searchTerm){
        List<Location__c> lList = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c FROM Location__c WHERE Name LIKE :searchTerm OR Pincode__c LIKE :searchTerm OR Address__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC];
        return lList;
    }
    public static Location__c getLocationById(String locationId){
        List<Location__c> sLocation = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c FROM Location__c WHERE Id =:locationId];
        if(sLocation != null && sLocation.size() > 0){
            return sLocation[0];
        }
        return null;
    }

    public static void updateRedScore(Set<Id> locationIds){
        List<Location__c> locationToUpdate = new List<Location__c>();
        AggregateResult[] redPeoplePerLocation = [SELECT Location__c, COUNT(Id) total FROM Location_Tracing__c WHERE Person__r.Health_Status__c = 'Red' AND Visit_Date__c = LAST_N_DAYS: 10 AND Location__c IN :locationIds GROUP BY Location__c];

        for(AggregateResult ar: redPeoplePerLocation){
            String locationId = String.valueOf(ar.get('Location__c'));
            Integer redCount = Integer.valueOf(ar.get('total'));
            String status = getStatus(redCount);
            locationToUpdate.add(new Location__c(Id = locationId, Red_Score__c = redCount, Status__c = status));
        }
        if(locationToUpdate != null && locationToUpdate.size() > 0){
            update locationToUpdate;
        }
    }

    public static String getStatus(Integer redScore){
        if(redScore == 0){
            return 'Green';
        }else if(redScore <= 5){
            return 'Yellow';
        }else if(redScore <= 10){
            return 'Orange';
        }else{
            return 'Red';
        }
    }
}