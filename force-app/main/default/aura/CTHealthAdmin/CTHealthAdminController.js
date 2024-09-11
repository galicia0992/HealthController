({
    doInit: function(cmp, event, helper){
        // Crear promesas para cada llamada a Apex
        let promise1 = new Promise((resolve, reject) => {
            var action1 = cmp.get("c.getPersonHealthStatusCount");
            action1.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    cmp.set('v.healthStatusCount', response.getReturnValue());
                    resolve(); // Resolver la promesa cuando la llamada sea exitosa
                } else {
                    console.log("Failed with state: " + state);
                    reject(); // Rechazar la promesa si la llamada falla
                }
            });
            $A.enqueueAction(action1);
        });

        let promise2 = new Promise((resolve, reject) => {
            var action2 = cmp.get("c.getLocationHealthStatusCount");
            action2.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    cmp.set('v.locationStatusCount', response.getReturnValue());
                    resolve(); // Resolver la promesa cuando la llamada sea exitosa
                } else {
                    console.log("Failed with state: " + state);
                    reject(); // Rechazar la promesa si la llamada falla
                }
            });
            $A.enqueueAction(action2);
        });

        // Esperar a que ambas promesas se resuelvan
        Promise.all([promise1, promise2])
            .then(() => {
                // Ejecutar handleTab después de que ambas promesas se resuelvan
                helper.handleTab(cmp, event);
            })
            .catch(() => {
                console.log("Failed to fetch data from Apex");
            });
    },

    handleTab: function(cmp, event, helper) {
        let tabId = event.getParam('id')
        cmp.set('v.tabName', tabId )
        let tabName = cmp.get('v.tabName')
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
