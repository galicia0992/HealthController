({
    helperMethod : function() {

    },
    refreshResultTable: function(){
        const appEvent = $A.get('e.c:resultTableRefresh');
        console.log('Evento resultApplication:', appEvent);
        appEvent.fire();
        console.log('Evento disparado');
    }
})
