public with sharing class CTLocationTriggerHandler {
    public static void beforeInsert(List<Location__c> location) {
        //antes de hacer el insert, el estatus se convertira en green
        for(Location__c loc: location){
            loc.Status__c = 'Green';
        }
    }

    //en el map, el id es igual a el location__c id <1223={location id = 1223, status__c=green}
    public static void beforeUpdate(List<Location__c> location, Map<Id, Location__c> oldLocation){
        for(Location__c loc: location){
            //si el estatus de loc es diferente al estatus del oldlocation, se actualiza la fecha de cambio
            //oldLocation.get(loc.id) jala el objeto que tenga el id de loc.id y con notacion de punto accede al status__c
            //<1223={location id = 1223, status__c=green}
    //           ^                            ^
     //          |                            |
        //oldLocation.get(loc.Id)        .Status__c
            if(loc.Status__c != oldLocation.get(loc.Id).Status__c){
                loc.Status_Update_Date__c = Date.today();
            }
        }
    }

    //apenas me di cuenta que usa el Map<Id, Location__c> para no hacer una segunda iteracion
    //y asi en el for, solo buscar el dato por el Id nada mas
    public static void afterUpdate(List<Location__c> location, Map<Id, Location__c> oldLocation){
        //aqui guardamos los Ids de las locaciones
        Set<Id> statusChange = new Set<Id>();
        
        for(Location__c loc: location){
            if(loc.Status__c == 'Red' && oldLocation.get(loc.Id).Status__c != 'Red'){
                statusChange.add(loc.Id);
            }
        }
        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByLocationsIds(statusChange);
       Set<Id> personIds = new Set<Id>();
        for(Location_Tracing__c trace : locationTraces){
            personIds.add(trace.Person__c);
        }
        List<Person__c> peopleToUpdate = new List<Person__c>();
        for(Id pid: personIds){
            peopleToUpdate.add(new Person__c(id=pid, Health_Status__c = 'Yellow'));
        }
        if(peopleToUpdate.size() > 0){
            update peopleToUpdate;
        }
    }
}