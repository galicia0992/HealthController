({
    fetchData: function (cmp) {
        var action = cmp.get("c.getLocationDetails");
        let recordId = cmp.get('v.recordId')
        action.setParams({recordId});

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let res = response.getReturnValue()
                
                if(!res || !res.name){
                    console.log(res)
                    console.log('????')
                    cmp.set('v.locationFound', false)
                    this.showToast('ERROR', 'Please enter a valid user id', 'error')
                }else{
                    console.log(res)
                    console.log('????')
                    cmp.set('v.locationFound', true)
                    cmp.set('v.locationInfo', res)
                }
            } else {
                alert("Error: " + response.getError());
            }
        });

        $A.enqueueAction(action);
    }
})
