({
    locationSearchHandler: function(cmp, e, helper){
        cmp.set('v.columns', [
            {
                label: "Id",
                fieldName: "Id",
                type: "text"
            },
            {
                label: "Status",
                fieldName: "status",
                type: "text"
            },
            {
                label: "Token",
                fieldName: "token",
                type: "text"
            },
            {
                label: "Visit Date",
                fieldName: "visitDate",
                type: "date"
            }
        ]);
        cmp.set('v.locationFound', 'true')
        
        helper.fetchData(cmp)
    }
})
