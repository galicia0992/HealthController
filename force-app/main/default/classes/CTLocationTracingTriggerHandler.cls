public with sharing class CTLocationTracingTriggerHandler {
    public static void beforeInsert(List<Location_Tracing__c> newLocations) {
        List<Location_Tracing__c> locations = CTLocationTracingController.checkDuplicates(newLocations);
        for(Location_Tracing__c loc: locations){
            loc.addError('Duplicate record found: Location ' + loc.Location__c + ' Person ' + loc.Person__c);
        }
    }
}