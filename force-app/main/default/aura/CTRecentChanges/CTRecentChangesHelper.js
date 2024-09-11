({
    fetchRecentHealthChanges: function (cmp) {
        var action1 = cmp.get("c.getRecentPersonHealthChanges");
        action1.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set('v.data', response.getReturnValue());

            } else {
                console.log("Failed with state: " + state);

            }
        });
        $A.enqueueAction(action1);
    },
    fetchRecentLocationHealthChanges: function (cmp) {
        var action2 = cmp.get("c.getRecentLocationHealthChanges");
        action2.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set('v.data', response.getReturnValue());

            } else {
                console.log("Failed with state: " + state);

            }
        });
        $A.enqueueAction(action2);
    },
    searchHealthRecords: function (cmp, queryTerm) {
        var action = cmp.get("c.searchPeople");
        console.log(queryTerm)
        action.setParams({
            searchTerm: queryTerm + '%'
        })
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue())
                cmp.set('v.data', response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    searchLocationRecords: function (cmp, queryTerm) {
        var action = cmp.get("c.searchLocation");
        action.setParams({
            searchTerm: queryTerm + '%'
        })
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set('v.data', response.getReturnValue());

            } else {
                console.log("Failed with state: " + state);

            }
        });
        $A.enqueueAction(action);
    }
})
