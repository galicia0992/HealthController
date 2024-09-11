trigger CTPersonTrigger on Person__c (before insert, after insert, before update, after update, before delete, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            //update health status
            //generate unique token for person record
            CTPersonTriggerHandler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            CTPersonTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE{
            CTPersonTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}