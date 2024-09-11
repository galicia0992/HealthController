({
    
    createRecord : function(component, event, helper) {
        console.log('desde createRecord')
        let createRecordEvent = $A.get("e.force:createRecord");
        let tabName = component.get('v.tabName')
        console.log(tabName)
        createRecordEvent.setParams({
            "entityApiName": tabName === 'Person' ? 'Person__c':'Location__c'
    });
    createRecordEvent.fire();
    },
    personHealthStatusCount: function(cmp){
       
    }
})
