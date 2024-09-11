public class CTLocationTracingController {
    public static List<Location_Tracing__c> getVisitors(String locationId){
        List<Location_Tracing__c> lTList = [SELECT id, Location__c, Person__c, Visit_Date__c, Person__r.Health_Status__c, Person__r.Token__c  FROM Location_Tracing__c WHERE id =:locationId ORDER BY Visit_Date__c DESC];
        return lTList;
    }
    public static List<Location_Tracing__c> getLocationsByPersonsId(Set<Id> personsId){
        List<Location_Tracing__c> lTList = [SELECT id, Location__c, Person__c, Visit_Date__c FROM Location_Tracing__c WHERE id IN :personsId AND Visit_Date__c = LAST_N_DAYS:10];
        return lTList;
    }
    public static List<Location_Tracing__c> getLocationsByLocationsIds(set<Id> locationIds){
        List<Location_Tracing__c> lTList = [SELECT id, Location__c, Person__c, Visit_Date__c, Person__r.Health_Status__c FROM Location_Tracing__c WHERE id IN :locationIds AND Person__r.Health_Status__c = 'Green' AND Visit_Date__c = LAST_N_DAYS:10];
        return lTList;
    }
    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newLocationTraces){
        Set<Id> locationsIds = new Set<Id>();
        Set<Id> personsIds = new Set<Id>();
        for(Location_Tracing__c lT : newLocationTraces){
            locationsIds.add(lt.Location__c);
            personsIds.add(lt.Person__c);
        }

        Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<id>>();
        List<Location_Tracing__c> lTList = [SELECT id, Location__c, Person__c, Visit_Date__c, Person__r.Health_Status__c, Person__r.Token__c  FROM Location_Tracing__c WHERE Location__c IN :locationsIds AND Person__c IN :personsIds];
        List<Location_Tracing__c> lTduplicates = new List<Location_Tracing__c>();
        if(lTList != null && lTList.size() > 0){
            for(Location_Tracing__c lt : lTList){
            if(! mapOfExistingRecords.containsKey(lt.Location__c)){
                mapOfExistingRecords.put(lt.Location__c, new Set<Id>());
            }
            mapOfExistingRecords.get(lt.Location__c).add(lt.Person__c);
        }
        for(Location_Tracing__c lt : newLocationTraces){
            if(mapOfExistingRecords.containsKey(lt.Location__c) && mapOfExistingRecords.get(lt.Location__c).contains(lt.Person__c)){
                lTduplicates.add(lt);
            }
        }
    }
    return lTduplicates;
}
}