({
    updateLocationStatus: function (cmp, recordId, status) { // Llamada al método de Apex
        
        var action = cmp.get("c.updateLocationStatus");
        

        // Pasamos los parámetros al método de Apex
        action.setParams({recordId: recordId, status: status});

        // Definimos el callback que se ejecutará cuando se reciba la respuesta del servidor
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("Estado de salud actualizado correctamente");
                
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error: " + errors[0].message);
                    }
                } else {
                    console.log("Error desconocido");
                }
            }
        });

        // Enviamos la acción al servidor
        $A.enqueueAction(action);
    }
})
