({
    userSearchHandler: function(cmp, e, helper){
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
                label: "Contact Date",
                fieldName: "contactDate",
                type: "date"
            }
        ]);
        cmp.set('v.userFound', 'true')
        
        helper.fetchData(cmp)
    }
})
