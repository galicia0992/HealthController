({
    doInit: function (cmp, event, helper) {
        switch (cmp.get("v.tabName")) {
            case "Person": cmp.set("v.columns", [
                    {
                        label: "Id",
                        fieldName: "Id",
                        type: "text"
                    },
                    {
                        label: "Name",
                        fieldName: "Name",
                        type: "text"
                    },
                    {
                        label: "Health Status",
                        fieldName: "Health_Status__c",
                        type: "text"
                    },
                    {
                        label: "Mobile",
                        fieldName: "Mobile__c",
                        type: "phone"
                    }, {
                        label: "Status Update Date",
                        fieldName: "Status_Update_Date__c",
                        type: "date"
                    }, {
                        label: "Token",
                        fieldName: "Token__c",
                        type: "string"
                    }, {
                        label: "View",
                        type: "button",
                        initialWidth: 135,
                        typeAttributes: {
                            label: "View/Update",
                            name: "view_details",
                            title: "Click to View Details"
                        }
                    }
                ]);
                helper.fetchRecentHealthChanges(cmp);

                break;
            case "Location": cmp.set("v.columns", [
                    {
                        label: "Id",
                        fieldName: "Id",
                        type: "text"
                    },
                    {
                        label: "Name",
                        fieldName: "Name",
                        type: "text"
                    },
                    {
                        label: "Status",
                        fieldName: "Status__c",
                        type: "text"
                    },
                    {
                        label: "Pincode",
                        fieldName: "Pincode__c",
                        type: "text"
                    }, {
                        label: "Address",
                        fieldName: "Address__c",
                        type: "text"
                    }, {
                        label: "Red Score",
                        fieldName: "Red_Score__c",
                        type: "double"
                    }, {
                        label: "Status Update Date",
                        fieldName: "Status_Update_Date__c",
                        type: "date"
                    }, {
                        label: "View",
                        type: "button",
                        initialWidth: 135,
                        typeAttributes: {
                            label: "View/Update",
                            name: "view_details",
                            title: "Click to View Details"
                        }
                    }
                ]);
                helper.fetchRecentLocationHealthChanges(cmp);

            default:
                break;
        }

    },
    handleKeyUp: function (cmp, e, helper) {
        var queryTerm = cmp.find("enter-search").get("v.value");
        if (! queryTerm && cmp.get("v.tabName") == "Person") {
            helper.fetchRecentHealthChanges(cmp);
        } else if (! queryTerm && cmp.get("v.tabName") == "Location") {
            helper.fetchRecentLocationHealthChanges(cmp);
        } else {
            if (queryTerm) {
                cmp.set("v.issearching", true);
                if (cmp.get("v.tabName") == "Person") {
                    console.log(queryTerm);
                    helper.searchHealthRecords(cmp, queryTerm);
                    cmp.set("v.issearching", false);
                } else if (cmp.get("v.tabName") == "Location") {
                    helper.searchLocationRecords(cmp, queryTerm);
                    cmp.set("v.issearching", false);
                }
            }
        }
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam("action");
        var row = event.getParam("row");

        switch (action.name) {
            case "view_details":
                const appEvent = cmp.get('v.tabName') === 'Person' ? $A.get('e.c:CTPersonSelectEvent') : $A.get('e.c:CTLocationSelectEvent')
                appEvent.setParams({
                    recordId: row.Id,
                    status: cmp.get('v.tabName') === 'Person' ? row.Health_Status__c : row.Status__c,
                    obj: cmp.get('v.tabName') === 'Person' ? 'Person__c' : 'Location__c'
                })

                appEvent.fire();

                break;
        }
    }
});
