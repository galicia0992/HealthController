({
    resultList : function(cmp, event, helper) {
        const action = cmp.get('c.showResults')
        action.setCallback(this, function(response) {
            let state = response.getState();
            console.log(response.getReturnValue())
            if (state === "SUCCESS") {
                cmp.set('v.columns', [
                    {label: 'Name', fieldName: 'Name', type: 'text'},
                    {label: 'Mode', fieldName: 'Mode__c', type: 'text'},
                    {label: 'Result', fieldName: 'Result__c', type: 'text'}
                ])
                cmp.set('v.data', response.getReturnValue());
                
            } else {
                console.error("Failed with state: " + state);
            }
        });

        // Enqueue the action to send the request to the server
        $A.enqueueAction(action);
    }
})
