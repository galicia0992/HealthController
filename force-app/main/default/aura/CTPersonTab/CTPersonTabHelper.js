({
    fetchData: function (cmp) {
        var action = cmp.get("c.getPersonDetails");
        let recordId = cmp.get('v.recordId')
        action.setParams({recordId});

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let res = response.getReturnValue()
                if(!res || !res.name){
                    cmp.set('v.userFound', false)
                    this.showToast('ERROR', 'Please enter a valid user id', 'error')
                }else{
                    cmp.set('v.userFound', true)
                    cmp.set('v.userInfo', res)
                }
            } else {
                alert("Error: " + response.getError());
            }
        });

        $A.enqueueAction(action);
    }
})
