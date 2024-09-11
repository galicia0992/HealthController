({
    handleOpen : function(cmp, event, helper) {
        let open = cmp.get('v.open')
        const label = cmp.get('v.label')
        
        if(open === false){
            cmp.set('v.open', true)
            
            let comEvent = cmp.getEvent('clickLabel')
            comEvent.setParams({value: label})
            comEvent.fire()
            
        }
        
    }
})
