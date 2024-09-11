({
    updateHealthStatus: function (cmp, recordId, status) { // Llamada al método de Apex
        var action = cmp.get("c.updateStatus");
        console.log(recordId)

        // Pasamos los parámetros al método de Apex
        action.setParams({recordId: recordId, status: status});

        // Definimos el callback que se ejecutará cuando se reciba la respuesta del servidor
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set('v.recordId', recordId)
                cmp.set('v.status', status)
                alert("Estado de salud actualizado correctamente");

                 // Disparar el evento para notificar sobre la actualización
                 var appEvent = $A.get("e.c:CTHealthStatusUpdateEvent");
                 appEvent.setParams({
                     recordId: recordId,
                     status: status
                 });
                 appEvent.fire();
 

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
