({
    handleTab: function(cmp, event, helper) {
        let tabId = event.getParam('id')
        cmp.set('v.tabName', tabId )
        let tabName = cmp.get('v.tabName') || 'Person'
        let healthStatusCount = cmp.get('v.healthStatusCount')
        let locationStatusCount = cmp.get('v.locationStatusCount')
        if(tabName == 'Person'){
            [healthStatusCount].map(item => {
                item.Green ? cmp.set('v.greenCount', item.Green): cmp.set('v.greenCount', 0)
                item.Yellow ? cmp.set('v.yellowCount', item.Yellow): cmp.set('v.yellowCount', 0)
                item.Orange ? cmp.set('v.orangeCount', item.Orange): cmp.set('v.orangeCount', 0)
                item.Red ? cmp.set('v.redCount', item.Red): cmp.set('v.redCount', 0)
            })
        }else{
            [locationStatusCount].map(item => {
                item.Green ? cmp.set('v.greenCount', item.Green): cmp.set('v.greenCount', 0)
                item.Yellow ? cmp.set('v.yellowCount', item.Yellow): cmp.set('v.yellowCount', 0)
                item.Orange ? cmp.set('v.orangeCount', item.Orange): cmp.set('v.orangeCount', 0)
                item.Red ? cmp.set('v.redCount', item.Red): cmp.set('v.redCount', 0)
            })
        }
    }
})
