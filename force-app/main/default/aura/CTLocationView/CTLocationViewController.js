({
    locationSelectHandler : function(component, event, helper) {
        let recordId = event.getParam('recordId')
        let status = event.getParam('status')
        
        component.set('v.recordId', recordId)
        component.set('v.status', status)
        
        
    },
    onClickHandler: function(component, event, helper){
        
        helper.updateLocationStatus(component, component.get('v.recordId'), 'Red')
        
    }
    
})
